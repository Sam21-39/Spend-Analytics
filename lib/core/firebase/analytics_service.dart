import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:get/get.dart';
import 'package:spend_analytics/core/firebase/firebase_bootstrap_service.dart';
import 'package:spend_analytics/shared/models/transaction_model.dart';

class AnalyticsService extends GetxService {
  bool _enabled = false;

  Future<AnalyticsService> init() async {
    _enabled = Get.find<FirebaseBootstrapService>().isEnabled;
    return this;
  }

  Future<void> logEvent(String name, {Map<String, Object>? parameters}) async {
    if (!_enabled) return;
    await FirebaseAnalytics.instance.logEvent(
      name: name,
      parameters: parameters,
    );
  }

  Future<void> logTransactionAdded(TransactionModel txn) {
    return logEvent(
      'transaction_added',
      parameters: <String, Object>{
        'type': txn.type,
        'category': txn.category,
        'payment_mode': txn.paymentMode,
      },
    );
  }
}
