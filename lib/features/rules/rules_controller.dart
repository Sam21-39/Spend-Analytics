import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:spend_analytics/core/firebase/crashlytics_service.dart';
import 'package:spend_analytics/core/local_db/app_database.dart';
import 'package:spend_analytics/core/supabase/supabase_service.dart';
import 'package:uuid/uuid.dart';

import '../../shared/utils/currency_formatter.dart';

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
        final pct = ((parameters['threshold_pct'] as num? ?? 0.8) * 100).toStringAsFixed(0);
        return 'Budget alert at $pct%';
      case 'daily_limit':
        final limit = (parameters['limit_amount'] as num? ?? 1500).toStringAsFixed(0);
        return 'Daily spend limit ${getCurrencySymbol()}$limit';
      case 'no_entry_reminder':
        final time = parameters['time']?.toString() ?? '21:00';
        return 'No-entry reminder at $time';
      case 'category_spike':
        final mult = (parameters['multiplier'] as num? ?? 2).toStringAsFixed(1);
        return 'Category spike > ${mult}x average';
      case 'weekend_overspend':
        return 'Weekend overspend insight';
      case 'recurring_due':
        final days = (parameters['days_before'] as num? ?? 2).toStringAsFixed(0);
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
    await _db.normalizeRuleIdsToUuid(_userId);
    await _syncWithCloud();
    await _removeLegacySeededRulesIfPresent();
    await _pruneDuplicateRulesByContent();

    final query = _db.select(_db.userRules)..where((t) => t.userId.equals(_userId));
    _rulesSub = query.watch().listen((rows) {
      final sorted = rows.toList(growable: false)
        ..sort((a, b) => b.updatedAt.compareTo(a.updatedAt));

      final unique = <String, UserRule>{};
      for (final row in sorted) {
        final key = '${row.ruleType}|${_canonicalParamsKey(row)}';
        unique.putIfAbsent(key, () => row);
      }

      final mapped = unique.values
          .where((row) => row.ruleType != 'recurring_due')
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

  Future<void> _removeLegacySeededRulesIfPresent() async {
    final existing = await _db.getRules(_userId);
    if (existing.isEmpty) {
      return;
    }

    bool isLegacySeed(UserRule row) {
      final params = _db.parseRuleParameters(row);
      switch (row.ruleType) {
        case 'budget_threshold':
          return (params['threshold_pct'] as num?)?.toDouble() == 0.8;
        case 'daily_limit':
          return (params['limit_amount'] as num?)?.toDouble() == 1500;
        case 'no_entry_reminder':
          return '${params['time'] ?? ''}'.trim() == '21:00';
        default:
          return false;
      }
    }

    final legacySeeded = existing.where(isLegacySeed).toList(growable: false);
    if (legacySeeded.isEmpty) {
      return;
    }

    final hasAnyNonLegacyRule = legacySeeded.length != existing.length;
    if (hasAnyNonLegacyRule) {
      return;
    }

    for (final rule in legacySeeded) {
      await _db.deleteRuleById(rule.id);
      await _supabase.deleteRule(rule.id);
    }
  }

  Future<void> _pruneDuplicateRulesByContent() async {
    final existing = await _db.getRules(_userId);
    if (existing.length < 2) {
      return;
    }

    final sorted = existing.toList(growable: false)
      ..sort((a, b) => b.updatedAt.compareTo(a.updatedAt));

    final seenKeys = <String>{};
    final duplicateIds = <String>[];
    for (final row in sorted) {
      final key = '${row.ruleType}|${_canonicalParamsKey(row)}';
      if (seenKeys.contains(key)) {
        duplicateIds.add(row.id);
        continue;
      }
      seenKeys.add(key);
    }

    for (final id in duplicateIds) {
      await _db.deleteRuleById(id);
      await _supabase.deleteRule(id);
    }
  }

  String _canonicalParamsKey(UserRule row) {
    final params = _db.parseRuleParameters(row);
    final sortedEntries = params.entries.toList(growable: false)
      ..sort((a, b) => a.key.compareTo(b.key));
    final canonical = <String, dynamic>{for (final entry in sortedEntries) entry.key: entry.value};
    return jsonEncode(canonical);
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
    final local = (await _db.getRules(
      _userId,
    )).where((rule) => rule.id == id).toList(growable: false);
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

  Future<bool> addDailyLimitRule() async {
    final existing = await _db.getRules(_userId);
    final hasSame = existing.any((rule) {
      if (rule.ruleType != 'daily_limit') {
        return false;
      }
      final params = _db.parseRuleParameters(rule);
      return (params['limit_amount'] as num?)?.toDouble() == 2000;
    });
    if (hasSame) {
      Get.snackbar('Rule exists', 'A similar Daily Limit rule already exists.');
      return false;
    }

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
    return true;
  }

  Future<bool> addSuggestedRule(String ruleType) async {
    switch (ruleType) {
      case 'daily_limit':
        return addDailyLimitRule();
      case 'category_spike':
        return _addRuleIfMissing(
          ruleType: 'category_spike',
          parameters: const <String, dynamic>{'multiplier': 2.0},
        );
      case 'no_entry_reminder':
        return _addRuleIfMissing(
          ruleType: 'no_entry_reminder',
          parameters: const <String, dynamic>{'time': '21:00'},
        );
      case 'weekend_overspend':
        return _addRuleIfMissing(
          ruleType: 'weekend_overspend',
          parameters: const <String, dynamic>{'enabled': true},
        );
    }
    return false;
  }

  Future<bool> _addRuleIfMissing({
    required String ruleType,
    required Map<String, dynamic> parameters,
  }) async {
    final existing = await _db.getRules(_userId);
    final alreadyExists = existing.any((rule) {
      if (rule.ruleType != ruleType) {
        return false;
      }
      final params = _db.parseRuleParameters(rule);
      return params.toString() == parameters.toString();
    });
    if (alreadyExists) {
      Get.snackbar('Rule exists', 'A similar $ruleType rule already exists.');
      return false;
    }

    final id = const Uuid().v4();
    await _db.upsertRule(
      id: id,
      userId: _userId,
      ruleType: ruleType,
      parameters: parameters,
      isActive: true,
    );
    await _supabase.upsertRule(id: id, ruleType: ruleType, parameters: parameters, isActive: true);
    return true;
  }

  String _resolveActiveUserId() {
    if (_supabase.isAuthenticated) {
      return _supabase.currentUserId!;
    }
    return 'guest';
  }

  @override
  void onClose() {
    _rulesSub?.cancel();
    super.onClose();
  }
}
