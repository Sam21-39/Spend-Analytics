import 'package:get/get.dart';
import 'package:spend_analytics/core/firebase/fcm_service.dart';
import 'package:spend_analytics/shared/models/transaction_model.dart';

class RuleEngine extends GetxService {
  final FcmService _fcm = Get.find<FcmService>();

  Future<RuleEngine> init() async {
    return this;
  }

  Future<void> evaluate(TransactionModel txn) async {
    if (txn.type == 'expense' && txn.amount >= 5000) {
      await _fcm.showLocalNotification(
        title: 'Daily Spend Alert',
        body: 'Large expense detected: ${txn.amount.toStringAsFixed(0)}',
      );
    }
  }
}
