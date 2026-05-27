import 'package:get/get.dart';
import 'package:spend_analytics/core/firebase/analytics_service.dart';
import 'package:spend_analytics/core/firebase/crashlytics_service.dart';
import 'package:spend_analytics/core/local_db/app_database.dart';
import 'package:spend_analytics/core/rules/rule_engine.dart';
import 'package:spend_analytics/core/sync/sync_manager.dart';
import 'package:spend_analytics/shared/models/transaction_model.dart';

class TransactionController extends GetxController {
  final AppDatabase _db = Get.find<AppDatabase>();
  final SyncManager _syncManager = Get.find<SyncManager>();
  final RuleEngine _rules = Get.find<RuleEngine>();
  final AnalyticsService _analytics = Get.find<AnalyticsService>();
  final CrashlyticsService _crashlytics = Get.find<CrashlyticsService>();

  final isLoading = false.obs;

  Future<void> addTransaction(TransactionModel txn) async {
    await saveTransaction(txn, isUpdate: false);
  }

  Future<void> saveTransaction(
    TransactionModel txn, {
    required bool isUpdate,
  }) async {
    isLoading.value = true;
    try {
      await _db.upsertTransaction(txn);
      await _syncManager.enqueueTransactionUpsert(txn);

      await _rules.evaluate(txn);
      if (isUpdate) {
        await _analytics.logEvent(
          'transaction_updated',
          parameters: <String, Object>{
            'type': txn.type,
            'category': txn.category,
            'payment_mode': txn.paymentMode,
          },
        );
      } else {
        await _analytics.logTransactionAdded(txn);
      }
    } catch (error, stack) {
      await _crashlytics.recordError(
        error,
        stack,
        customKeys: <String, Object?>{
          'action': isUpdate ? 'update_transaction' : 'add_transaction',
          'type': txn.type,
        },
      );
      Get.snackbar('Sync Error', 'Saved locally. Will sync when online.');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteTransaction(TransactionModel txn) async {
    isLoading.value = true;
    try {
      await _db.deleteTransactionById(txn.id);
      await _syncManager.enqueueTransactionDelete(
        transactionId: txn.id,
        userId: txn.userId,
      );
      await _analytics.logEvent(
        'transaction_deleted',
        parameters: <String, Object>{
          'type': txn.type,
          'category': txn.category,
          'payment_mode': txn.paymentMode,
        },
      );
    } catch (error, stack) {
      await _crashlytics.recordError(
        error,
        stack,
        customKeys: <String, Object?>{
          'action': 'delete_transaction',
          'type': txn.type,
          'id': txn.id,
        },
      );
      Get.snackbar('Delete failed', 'Could not delete transaction right now.');
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }
}
