import 'dart:async';
import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:spend_analytics/core/firebase/crashlytics_service.dart';
import 'package:spend_analytics/core/local_db/app_database.dart';
import 'package:spend_analytics/core/supabase/supabase_service.dart';
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
      final queue = await _db.pendingSyncQueue(limit: 100);

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

  Future<void> _syncOneItem(SyncQueueItem item, String userId) async {
    if (item.entityType != 'transaction' || item.operation != 'upsert') {
      throw UnsupportedError(
        'Unsupported sync item: ${item.entityType}/${item.operation}',
      );
    }

    final payload = jsonDecode(item.payloadJson) as Map<String, dynamic>;
    final txn = TransactionModel.fromJson(payload);
    await _supabase.client.from('transactions').upsert(<String, dynamic>{
      'id': txn.id,
      'user_id': userId,
      'amount': txn.amount,
      'type': txn.type,
      'category_id': null,
      'payment_mode': txn.paymentMode,
      'note': txn.note,
      'tags': txn.tags,
      'transaction_date': txn.transactionDate
          .toIso8601String()
          .split('T')
          .first,
      'updated_at': txn.updatedAt.toUtc().toIso8601String(),
    });
  }

  Future<void> _refreshPendingCount() async {
    pendingSyncCount.value = await _db.syncQueueCount();
  }

  @override
  void onClose() {
    _connectivitySub?.cancel();
    _authSub?.cancel();
    super.onClose();
  }
}
