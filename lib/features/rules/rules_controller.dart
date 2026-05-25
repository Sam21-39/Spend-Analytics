import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:get/get.dart';
import 'package:spend_analytics/core/firebase/crashlytics_service.dart';
import 'package:spend_analytics/core/local_db/app_database.dart';
import 'package:spend_analytics/core/supabase/supabase_service.dart';
import 'package:uuid/uuid.dart';

class RuleViewModel {
  const RuleViewModel({
    required this.id,
    required this.ruleType,
    required this.parameters,
    required this.isActive,
  });

  final String id;
  final String ruleType;
  final Map<String, dynamic> parameters;
  final bool isActive;

  String get title {
    switch (ruleType) {
      case 'budget_threshold':
        final pct = ((parameters['threshold_pct'] as num? ?? 0.8) * 100)
            .toStringAsFixed(0);
        return 'Budget alert at $pct%';
      case 'daily_limit':
        final limit =
            (parameters['limit_amount'] as num? ?? 1500).toStringAsFixed(0);
        return 'Daily spend limit ₹$limit';
      case 'no_entry_reminder':
        final time = parameters['time']?.toString() ?? '21:00';
        return 'No-entry reminder at $time';
      case 'category_spike':
        final mult = (parameters['multiplier'] as num? ?? 2).toStringAsFixed(1);
        return 'Category spike > ${mult}x average';
      case 'weekend_overspend':
        return 'Weekend overspend insight';
      case 'recurring_due':
        final days =
            (parameters['days_before'] as num? ?? 2).toStringAsFixed(0);
        return 'Recurring due in $days day(s)';
      default:
        return ruleType;
    }
  }

  String get subtitle {
    switch (ruleType) {
      case 'budget_threshold':
        return 'Notifies when a category crosses the budget threshold.';
      case 'daily_limit':
        return 'Alerts when daily expense exceeds your configured cap.';
      case 'no_entry_reminder':
        return 'Reminder if no expense is logged for the day.';
      case 'category_spike':
        return 'Flags unusual category jumps compared to baseline.';
      case 'weekend_overspend':
        return 'Compares weekend and weekday average spend.';
      case 'recurring_due':
        return 'Warns before upcoming recurring charges.';
      default:
        return 'Custom rule';
    }
  }
}

class RulesController extends GetxController {
  final AppDatabase _db = Get.find<AppDatabase>();
  final SupabaseService _supabase = Get.find<SupabaseService>();
  final CrashlyticsService _crashlytics = Get.find<CrashlyticsService>();

  final rules = <RuleViewModel>[].obs;
  final isSyncing = false.obs;

  StreamSubscription<List<UserRule>>? _rulesSub;
  late final String _userId;

  @override
  void onInit() {
    super.onInit();
    _userId = _resolveActiveUserId();
    unawaited(_bootstrap());
  }

  Future<void> _bootstrap() async {
    await _db.seedDefaultRules(_userId);
    await _db.normalizeRuleIdsToUuid(_userId);
    await _syncWithCloud();

    final query = _db.select(_db.userRules)
      ..where((t) => t.userId.equals(_userId));
    _rulesSub = query.watch().listen((rows) {
      final mapped = rows
          .map(
            (row) => RuleViewModel(
              id: row.id,
              ruleType: row.ruleType,
              parameters: _db.parseRuleParameters(row),
              isActive: row.isActive,
            ),
          )
          .toList(growable: false);
      rules.assignAll(mapped);
    });
  }

  Future<void> _syncWithCloud() async {
    if (!_supabase.isEnabled || !_supabase.isAuthenticated) {
      return;
    }

    isSyncing.value = true;
    try {
      final cloudRules = await _supabase.fetchRules();
      for (final rule in cloudRules) {
        await _db.upsertRule(
          id: rule.id,
          userId: _userId,
          ruleType: rule.ruleType,
          parameters: rule.parameters,
          isActive: rule.isActive,
          createdAt: rule.createdAt,
          updatedAt: rule.updatedAt,
        );
      }

      final localRules = await _db.getRules(_userId);
      for (final local in localRules) {
        await _supabase.upsertRule(
          id: local.id,
          ruleType: local.ruleType,
          parameters: _db.parseRuleParameters(local),
          isActive: local.isActive,
          createdAt: local.createdAt,
          updatedAt: local.updatedAt,
        );
      }
    } catch (error, stack) {
      await _crashlytics.recordError(
        error,
        stack,
        customKeys: const <String, Object?>{'action': 'rules_sync'},
      );
    } finally {
      isSyncing.value = false;
    }
  }

  Future<void> toggleRule(String id, bool value) async {
    await _db.setRuleActive(id: id, isActive: value);
    final local = (await _db.getRules(_userId))
        .where((rule) => rule.id == id)
        .toList(growable: false);
    if (local.isEmpty) {
      return;
    }

    final row = local.first;
    await _supabase.upsertRule(
      id: row.id,
      ruleType: row.ruleType,
      parameters: _db.parseRuleParameters(row),
      isActive: value,
      createdAt: row.createdAt,
      updatedAt: row.updatedAt,
    );
  }

  Future<void> addDailyLimitRule() async {
    final id = const Uuid().v4();
    await _db.upsertRule(
      id: id,
      userId: _userId,
      ruleType: 'daily_limit',
      parameters: const <String, dynamic>{'limit_amount': 2000},
      isActive: true,
    );
    await _supabase.upsertRule(
      id: id,
      ruleType: 'daily_limit',
      parameters: const <String, dynamic>{'limit_amount': 2000},
      isActive: true,
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
    _rulesSub?.cancel();
    super.onClose();
  }
}
