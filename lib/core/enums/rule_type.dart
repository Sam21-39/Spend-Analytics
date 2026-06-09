import 'package:hive_ce/hive.dart';

part 'rule_type.g.dart';

@HiveType(typeId: 103)
enum RuleType {
  @HiveField(0)
  budgetThreshold,
  @HiveField(1)
  dailyLimit,
  @HiveField(2)
  noEntryReminder,
  @HiveField(3)
  categorySpike,
  @HiveField(4)
  weekendOverspend,
  @HiveField(5)
  recurringDue;

  String get value => switch (this) {
    budgetThreshold => 'budget_threshold',
    dailyLimit => 'daily_limit',
    noEntryReminder => 'no_entry_reminder',
    categorySpike => 'category_spike',
    weekendOverspend => 'weekend_overspend',
    recurringDue => 'recurring_due',
  };

  static RuleType fromString(String v) => switch (v.trim()) {
    'budget_threshold' => budgetThreshold,
    'daily_limit' => dailyLimit,
    'no_entry_reminder' => noEntryReminder,
    'category_spike' => categorySpike,
    'weekend_overspend' => weekendOverspend,
    'recurring_due' => recurringDue,
    _ => budgetThreshold,
  };
}
