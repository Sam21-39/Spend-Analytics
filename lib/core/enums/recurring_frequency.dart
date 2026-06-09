import 'package:hive_ce/hive.dart';

part 'recurring_frequency.g.dart';

@HiveType(typeId: 104)
enum RecurringFrequency {
  @HiveField(0)
  daily,
  @HiveField(1)
  weekly,
  @HiveField(2)
  monthly,
  @HiveField(3)
  yearly;

  String get value => name;

  static RecurringFrequency fromString(String v) =>
      switch (v.trim().toLowerCase()) {
        'daily' => daily,
        'weekly' => weekly,
        'yearly' => yearly,
        _ => monthly,
      };
}
