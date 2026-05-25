import 'package:get/get.dart';
import 'package:spend_analytics/core/firebase/crashlytics_service.dart';
import 'package:spend_analytics/core/local_db/app_database.dart';
import 'package:spend_analytics/core/supabase/supabase_service.dart';
import 'package:spend_analytics/core/sync/conflict_resolver.dart';
import 'package:spend_analytics/core/sync/sync_manager.dart';
import 'package:spend_analytics/shared/models/transaction_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RealtimeService extends GetxService {
  final SupabaseService _supabase = Get.find<SupabaseService>();
  final AppDatabase _db = Get.find<AppDatabase>();
  final SyncManager _syncManager = Get.find<SyncManager>();
  final CrashlyticsService _crashlytics = Get.find<CrashlyticsService>();
  final ConflictResolver _resolver = const ConflictResolver();

  RealtimeChannel? _channel;

  Future<RealtimeService> init() async {
    if (!_supabase.isEnabled || !_supabase.isAuthenticated) {
      return this;
    }
    await _subscribeForCurrentUser();
    return this;
  }

  Future<void> refreshSubscription() async {
    if (!_supabase.isEnabled || !_supabase.isAuthenticated) {
      await _unsubscribe();
      return;
    }
    await _subscribeForCurrentUser();
  }

  Future<void> _subscribeForCurrentUser() async {
    final userId = _supabase.currentUserId;
    if (userId == null || userId.isEmpty) {
      return;
    }

    await _unsubscribe();
    final channel = _supabase.client.channel('public:transactions:$userId');
    channel
        .onPostgresChanges(
          event: PostgresChangeEvent.all,
          schema: 'public',
          table: 'transactions',
          filter: PostgresChangeFilter(
            type: PostgresChangeFilterType.eq,
            column: 'user_id',
            value: userId,
          ),
          callback: (payload) {
            _handleTransactionChange(payload, userId);
          },
        )
        .subscribe();
    _channel = channel;
  }

  Future<void> _handleTransactionChange(
    PostgresChangePayload payload,
    String userId,
  ) async {
    try {
      switch (payload.eventType) {
        case PostgresChangeEvent.insert:
        case PostgresChangeEvent.update:
          await _mergeUpsert(
            payload.newRecord,
            userId,
            payload.commitTimestamp,
          );
          break;
        case PostgresChangeEvent.delete:
          await _mergeDelete(payload.oldRecord, payload.commitTimestamp);
          break;
        case PostgresChangeEvent.all:
          break;
      }
    } catch (error, stack) {
      await _crashlytics.recordError(
        error,
        stack,
        customKeys: const <String, Object?>{'action': 'realtime_merge'},
      );
    }
  }

  Future<void> _mergeUpsert(
    Map<String, dynamic> record,
    String userId,
    DateTime commitTimestamp,
  ) async {
    final remoteTxn = _mapRemoteRecord(
      record: record,
      userId: userId,
      commitTimestamp: commitTimestamp,
    );
    final localTxn = await _db.getTransactionById(remoteTxn.id);
    if (localTxn == null) {
      await _db.upsertTransaction(remoteTxn);
      return;
    }

    final outcome = _resolver.resolve(
      localUpdatedAt: localTxn.updatedAt.toUtc(),
      remoteUpdatedAt: remoteTxn.updatedAt.toUtc(),
    );
    if (outcome == ConflictResolution.remoteWins) {
      await _db.upsertTransaction(remoteTxn);
      return;
    }

    if (outcome == ConflictResolution.localWins) {
      await _syncManager.enqueueTransactionUpsert(localTxn);
    }
  }

  Future<void> _mergeDelete(
    Map<String, dynamic> record,
    DateTime commitTimestamp,
  ) async {
    final id = record['id']?.toString();
    if (id == null || id.isEmpty) {
      return;
    }
    final localTxn = await _db.getTransactionById(id);
    if (localTxn == null) {
      return;
    }

    final shouldApplyRemote = _resolver.shouldApplyRemote(
      localUpdatedAt: localTxn.updatedAt.toUtc(),
      remoteUpdatedAt: commitTimestamp.toUtc(),
    );
    if (shouldApplyRemote) {
      await _db.deleteTransactionById(id);
      return;
    }

    await _syncManager.enqueueTransactionUpsert(localTxn);
  }

  TransactionModel _mapRemoteRecord({
    required Map<String, dynamic> record,
    required String userId,
    required DateTime commitTimestamp,
  }) {
    final transactionDateRaw =
        record['transaction_date'] ?? commitTimestamp.toIso8601String();
    final updatedAtRaw =
        record['updated_at'] ?? commitTimestamp.toIso8601String();
    final tagsRaw = record['tags'];

    return TransactionModel(
      id: '${record['id']}',
      userId: userId,
      amount: (record['amount'] as num?)?.toDouble() ?? 0,
      type: '${record['type'] ?? 'expense'}',
      category: '${record['category_name'] ?? record['category'] ?? 'Other'}',
      paymentMode: '${record['payment_mode'] ?? 'other'}',
      transactionDate: DateTime.parse('$transactionDateRaw'),
      updatedAt: DateTime.parse('$updatedAtRaw'),
      note: record['note'] as String?,
      tags: (tagsRaw is List)
          ? tagsRaw.map((e) => '$e').toList(growable: false)
          : const <String>[],
    );
  }

  Future<void> _unsubscribe() async {
    final channel = _channel;
    if (channel == null) return;
    await _supabase.client.removeChannel(channel);
    _channel = null;
  }

  @override
  void onClose() {
    _unsubscribe();
    super.onClose();
  }
}
