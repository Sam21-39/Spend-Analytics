import 'dart:async';

import 'package:get/get.dart';
import 'package:spend_analytics/core/local_db/app_database.dart';
import 'package:spend_analytics/core/supabase/supabase_service.dart';
import 'package:spend_analytics/shared/models/transaction_model.dart';

class DashboardController extends GetxController {
  final AppDatabase _db = Get.find<AppDatabase>();
  final SupabaseService _supabase = Get.find<SupabaseService>();
  StreamSubscription<List<TransactionModel>>? _transactionsSub;

  final transactions = <TransactionModel>[].obs;
  final monthlySpend = 0.0.obs;
  final isGuestMode = false.obs;

  @override
  void onInit() {
    super.onInit();
    isGuestMode.value = !_supabase.isAuthenticated;
    _transactionsSub = _db.watchAllTransactions().listen((rows) {
      transactions.assignAll(rows);
      monthlySpend.value = rows
          .where((t) => t.type == 'expense')
          .fold<double>(0, (sum, t) => sum + t.amount);
    });
  }

  Future<void> refreshDashboard() async {
    final data = await _db.allTransactions();
    transactions.assignAll(data);
    monthlySpend.value = data
        .where((t) => t.type == 'expense')
        .fold<double>(0, (sum, t) => sum + t.amount);
  }

  @override
  void onClose() {
    _transactionsSub?.cancel();
    super.onClose();
  }
}
