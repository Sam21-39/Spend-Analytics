import 'dart:async';
import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:spend_analytics/core/firebase/crashlytics_service.dart';
import 'package:spend_analytics/core/local_db/app_database.dart';
import 'package:spend_analytics/core/supabase/supabase_service.dart';
import 'package:spend_analytics/core/sync/conflict_resolver.dart';
import 'package:spend_analytics/shared/models/transaction_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SyncManager extends GetxService {
  final AppDatabase _db = Get.find<AppDatabase>();
  final SupabaseService _supabase = Get.find<SupabaseService>();
  final CrashlyticsService _crashlytics = Get.find<CrashlyticsService>();
  final Connectivity _connectivity = Connectivity();

  final isOnline = true.obs;
  final isSyncing = false.obs;
  final pendingSyncCount = 0.obs;

  StreamSubscription<List<ConnectivityResult>>? _connectivitySub;
  StreamSubscription<AuthState>? _authSub;

  Future<SyncManager> init() async {
    final result = await _connectivity.checkConnectivity();
    isOnline.value = !result.contains(ConnectivityResult.none);

    _connectivitySub = _connectivity.onConnectivityChanged.listen((results) {
      isOnline.value = !results.contains(ConnectivityResult.none);
      if (isOnline.value) {
        unawaited(flushQueueIfPossible());
      }
    });

    if (_supabase.isEnabled) {
      _authSub = _supabase.client.auth.onAuthStateChange.listen(
        (_) => unawaited(flushQueueIfPossible()),
        onError: (error, stack) {
          unawaited(
            _crashlytics.recordError(
              error,
              stack,
              customKeys: const <String, Object?>{
                'action': 'sync_auth_state_listener',
              },
            ),
          );
        },
      );
    }

    await _refreshPendingCount();
    await flushQueueIfPossible();
    return this;
  }

  Future<void> enqueueTransactionUpsert(TransactionModel txn) async {
    await _db.enqueueTransactionUpsert(txn);
    await _refreshPendingCount();
    await flushQueueIfPossible();
  }

  Future<void> enqueueTransactionDelete({
    required String transactionId,
    required String userId,
  }) async {
    await _db.enqueueTransactionDelete(
      transactionId: transactionId,
      userId: userId,
    );
    await _refreshPendingCount();
    await flushQueueIfPossible();
  }

  Future<void> flushQueueIfPossible() async {
    if (isSyncing.value || !isOnline.value) {
      return;
    }
    if (!_supabase.isEnabled || !_supabase.isAuthenticated) {
      return;
    }

    isSyncing.value = true;
    try {
      final userId = _supabase.currentUserId!;
      final queue = await _db.pendingSyncQueue(userId: userId, limit: 100);

      for (final item in queue) {
        try {
          await _syncOneItem(item, userId);
          await _db.markSyncQueueSuccess(item.id);
        } catch (error, stack) {
          await _db.markSyncQueueFailure(item.id, error.toString());
          await _crashlytics.recordError(
            error,
            stack,
            customKeys: <String, Object?>{
              'action': 'sync_queue_item',
              'item_id': item.id,
              'entity': item.entityType,
              'operation': item.operation,
            },
          );
        }
      }
    } finally {
      await _refreshPendingCount();
      isSyncing.value = false;
    }
  }

  /// Initial cloud-to-local hydration — called silently after sign-in.
  /// On a fresh install the local DB is empty, so all remote records win.
  /// On an existing device the last-write-wins conflict resolver applies.
  Future<void> pullAllFromCloud(String userId) async {
    if (!isOnline.value || !_supabase.isEnabled || !_supabase.isAuthenticated) {
      return;
    }
    try {
      final records = await _supabase.fetchAllTransactions(userId: userId);
      for (final record in records) {
        try {
          final now = DateTime.now().toUtc();
          final transactionDateRaw =
              record['transaction_date'] ?? now.toIso8601String();
          final updatedAtRaw =
              record['updated_at'] ?? now.toIso8601String();
          final tagsRaw = record['tags'];

          final remoteTxn = TransactionModel(
            id: '${record['id']}',
            userId: userId,
            amount: (record['amount'] as num?)?.toDouble() ?? 0,
            type: '${record['type'] ?? 'expense'}',
            category:
                '${record['category_name'] ?? record['category'] ?? 'Others'}',
            paymentMode: '${record['payment_mode'] ?? 'other'}',
            transactionDate: DateTime.parse('$transactionDateRaw'),
            updatedAt: DateTime.parse('$updatedAtRaw'),
            note: record['note'] as String?,
            tags:
                (tagsRaw is List)
                    ? tagsRaw.map((e) => '$e').toList(growable: false)
                    : const <String>[],
          );

          final localTxn = await _db.getTransactionById(remoteTxn.id);
          if (localTxn == null) {
            // Fresh install: remote always wins
            await _db.upsertTransaction(remoteTxn);
          } else {
            // Existing device: last-write wins
            final outcome = const ConflictResolver().resolve(
              localUpdatedAt: localTxn.updatedAt.toUtc(),
              remoteUpdatedAt: remoteTxn.updatedAt.toUtc(),
            );
            if (outcome == ConflictResolution.remoteWins) {
              await _db.upsertTransaction(remoteTxn);
            }
          }
        } catch (_) {
          // Skip malformed records silently
        }
      }
    } catch (error, stack) {
      await _crashlytics.recordError(
        error,
        stack,
        customKeys: const <String, Object?>{'action': 'pull_all_from_cloud'},
      );
    }
  }


  Future<void> _syncOneItem(SyncQueueItem item, String userId) async {
    if (item.entityType != 'transaction') {
      throw UnsupportedError(
        'Unsupported sync item: ${item.entityType}/${item.operation}',
      );
    }

    if (item.operation == 'upsert') {
      final payload = jsonDecode(item.payloadJson) as Map<String, dynamic>;
      final txn = TransactionModel.fromJson(payload);
      final normalizedPaymentMode = _normalizePaymentMode(txn.paymentMode);
      await _supabase.client.from('transactions').upsert(<String, dynamic>{
        'id': txn.id,
        'user_id': userId,
        'amount': txn.amount,
        'type': txn.type,
        'category_id': null,
        'category_name': txn.category,
        'payment_mode': normalizedPaymentMode,
        'note': txn.note,
        'tags': txn.tags,
        'transaction_date':
            txn.transactionDate.toIso8601String().split('T').first,
        'updated_at': txn.updatedAt.toUtc().toIso8601String(),
      });
      return;
    }

    if (item.operation == 'delete') {
      final payload = jsonDecode(item.payloadJson) as Map<String, dynamic>;
      final txnId = '${payload['id'] ?? item.entityId}'.trim();
      if (txnId.isEmpty) {
        throw StateError('Missing transaction id for delete operation');
      }
      await _supabase.client
          .from('transactions')
          .delete()
          .eq('id', txnId)
          .eq('user_id', userId);
      return;
    }

    throw UnsupportedError(
      'Unsupported sync item: ${item.entityType}/${item.operation}',
    );
  }

  String _normalizePaymentMode(String value) {
    final normalized = value.trim().toLowerCase();
    switch (normalized) {
      case 'cash':
      case 'upi':
      case 'card':
      case 'netbanking':
      case 'other':
        return normalized;
      default:
        return 'other';
    }
  }

  Future<void> _refreshPendingCount() async {
    if (!_supabase.isEnabled || !_supabase.isAuthenticated) {
      pendingSyncCount.value = 0;
      return;
    }
    pendingSyncCount.value = await _db.syncQueueCountForUser(
      _supabase.currentUserId!,
    );
  }

  @override
  void onClose() {
    _connectivitySub?.cancel();
    _authSub?.cancel();
    super.onClose();
  }
}
