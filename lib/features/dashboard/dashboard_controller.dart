import 'dart:async';

import 'package:get/get.dart';
import 'package:spend_analytics/core/local_db/app_database.dart';
import 'package:spend_analytics/core/supabase/supabase_service.dart';
import 'package:spend_analytics/shared/models/transaction_model.dart';

class DashboardController extends GetxController {
  final AppDatabase _db = Get.find<AppDatabase>();
  final SupabaseService _supabase = Get.find<SupabaseService>();
  StreamSubscription<List<TransactionModel>>? _transactionsSub;
  late final String _activeUserId;

  final transactions = <TransactionModel>[].obs;
  final monthlySpend = 0.0.obs;
  final isGuestMode = false.obs;
  final isLoading = true.obs;
  final firstName = 'User'.obs;

  @override
  void onInit() {
    super.onInit();
    isGuestMode.value = !_supabase.isAuthenticated;
    _hydrateProfile();
    _activeUserId =
        _supabase.isAuthenticated ? _supabase.currentUserId! : 'guest';
    _transactionsSub = _db.watchTransactionsForUser(_activeUserId).listen((
      rows,
    ) {
      transactions.assignAll(rows);
      final now = DateTime.now();
      monthlySpend.value = rows
          .where(
            (t) =>
                t.type == 'expense' &&
                t.transactionDate.month == now.month &&
                t.transactionDate.year == now.year,
          )
          .fold<double>(0, (sum, t) => sum + t.amount);
      isLoading.value = false;
    });
  }

  void _hydrateProfile() {
    if (!_supabase.isAuthenticated || !_supabase.isEnabled) {
      firstName.value = 'User';
      return;
    }

    final user = _supabase.client.auth.currentUser;
    final meta = user?.userMetadata ?? <String, dynamic>{};
    final rawName =
        '${meta['display_name'] ?? meta['full_name'] ?? meta['name'] ?? ''}'
            .trim();
    if (rawName.isNotEmpty) {
      firstName.value = _extractFirstName(rawName);
      return;
    }

    final email = (user?.email ?? '').trim();
    if (email.isNotEmpty) {
      final localPart = email
          .split('@')
          .first
          .replaceAll(RegExp(r'[._-]+'), ' ');
      firstName.value = _extractFirstName(localPart);
      return;
    }

    firstName.value = 'User';
  }

  String _extractFirstName(String fullName) {
    final compact = fullName.trim();
    if (compact.isEmpty) {
      return 'User';
    }
    final first = compact.split(RegExp(r'\s+')).first;
    if (first.isEmpty) {
      return 'User';
    }
    return '${first[0].toUpperCase()}${first.substring(1)}';
  }

  Future<void> refreshDashboard() async {
    final data = await _db.allTransactionsForUser(_activeUserId);
    transactions.assignAll(data);
    final now = DateTime.now();
    monthlySpend.value = data
        .where(
          (t) =>
              t.type == 'expense' &&
              t.transactionDate.month == now.month &&
              t.transactionDate.year == now.year,
        )
        .fold<double>(0, (sum, t) => sum + t.amount);
  }

  @override
  void onClose() {
    _transactionsSub?.cancel();
    super.onClose();
  }
}
