import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:get/get.dart';
import 'package:spend_analytics/core/firebase/crashlytics_service.dart';
import 'package:spend_analytics/core/local_db/app_database.dart';
import 'package:spend_analytics/core/supabase/supabase_service.dart';

class BudgetController extends GetxController {
  final AppDatabase _db = Get.find<AppDatabase>();
  final SupabaseService _supabase = Get.find<SupabaseService>();
  final CrashlyticsService _crashlytics = Get.find<CrashlyticsService>();

  final categoryBudgets = <String, double>{}.obs;
  final categorySpend = <String, double>{}.obs;
  final isSyncing = false.obs;

  StreamSubscription<List<Budget>>? _budgetSub;
  StreamSubscription<Map<String, double>>? _spendSub;

  late final String _userId;
  late final int _month;
  late final int _year;

  @override
  void onInit() {
    super.onInit();
    final now = DateTime.now();
    _month = now.month;
    _year = now.year;
    _userId = _resolveActiveUserId();
    unawaited(_bootstrap());
  }

  Future<void> _bootstrap() async {
    await _seedDefaultBudgetsIfNeeded();
    await _syncWithCloud();

    _budgetSub = _db
        .watchBudgetsForMonth(userId: _userId, month: _month, year: _year)
        .listen((rows) {
      categoryBudgets.assignAll(
        <String, double>{for (final row in rows) row.category: row.limitAmount},
      );
    });

    _spendSub = _db
        .watchCategorySpendByMonth(userId: _userId, month: _month, year: _year)
        .listen((totals) {
      categorySpend.assignAll(totals);
    });
  }

  Future<void> _seedDefaultBudgetsIfNeeded() async {
    final existing = await _db
        .watchBudgetsForMonth(userId: _userId, month: _month, year: _year)
        .first;
    if (existing.isNotEmpty) {
      return;
    }

    await _db.saveBudget(
      userId: _userId,
      category: 'Food',
      month: _month,
      year: _year,
      limitAmount: 4000,
    );
    await _db.saveBudget(
      userId: _userId,
      category: 'Transport',
      month: _month,
      year: _year,
      limitAmount: 2500,
    );
    await _db.saveBudget(
      userId: _userId,
      category: 'Shopping',
      month: _month,
      year: _year,
      limitAmount: 3000,
    );
  }

  Future<void> _syncWithCloud() async {
    if (!_supabase.isEnabled || !_supabase.isAuthenticated) {
      return;
    }

    isSyncing.value = true;
    try {
      final cloudBudgets = await _supabase.fetchBudgetsForMonth(
        month: _month,
        year: _year,
      );

      for (final item in cloudBudgets) {
        if (item.category.trim().isEmpty) {
          continue;
        }
        await _db.saveBudget(
          userId: _userId,
          category: item.category,
          month: item.month,
          year: item.year,
          limitAmount: item.limitAmount,
        );
      }

      final localBudgets = await _db
          .watchBudgetsForMonth(userId: _userId, month: _month, year: _year)
          .first;
      for (final local in localBudgets) {
        await _supabase.upsertBudget(
          category: local.category,
          month: local.month,
          year: local.year,
          limitAmount: local.limitAmount,
        );
      }
    } catch (error, stack) {
      await _crashlytics.recordError(
        error,
        stack,
        customKeys: const <String, Object?>{'action': 'budget_sync'},
      );
    } finally {
      isSyncing.value = false;
    }
  }

  Future<void> upsertBudget(String category, double amount) async {
    await _db.saveBudget(
      userId: _userId,
      category: category,
      month: _month,
      year: _year,
      limitAmount: amount,
    );
    await _supabase.upsertBudget(
      category: category,
      month: _month,
      year: _year,
      limitAmount: amount,
    );
  }

  String _resolveActiveUserId() {
    if (_supabase.isAuthenticated) {
      return _supabase.currentUserId!;
    }
    final firebaseUser = fb.FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      return firebaseUser.uid;
    }
    return 'guest';
  }

  @override
  void onClose() {
    _budgetSub?.cancel();
    _spendSub?.cancel();
    super.onClose();
  }
}
