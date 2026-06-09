import 'package:hive_ce/hive.dart';

part 'budget_period.g.dart';

@HiveType(typeId: 102)
enum BudgetPeriod {
  @HiveField(0)
  monthly,
  @HiveField(1)
  weekly,
  @HiveField(2)
  yearly;

  String get value => name;

  static BudgetPeriod fromString(String v) => switch (v.trim().toLowerCase()) {
    'weekly' => weekly,
    'yearly' => yearly,
    _ => monthly,
  };
}
