import 'package:hive_ce/hive.dart';

part 'expense_type.g.dart';

@HiveType(typeId: 101)
enum ExpenseType {
  @HiveField(0)
  expense,
  @HiveField(1)
  income,
  @HiveField(2)
  transfer;

  String get value => name;

  static ExpenseType fromString(String v) => switch (v.trim().toLowerCase()) {
    'income' => income,
    'transfer' => transfer,
    _ => expense,
  };
}
