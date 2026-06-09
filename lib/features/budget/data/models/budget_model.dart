import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive_ce/hive.dart';
import 'package:spend_analytics/core/enums/budget_period.dart';
import 'package:spend_analytics/features/budget/domain/entities/budget_entity.dart';

part 'budget_model.g.dart';

@HiveType(typeId: 1)
class BudgetModel {
  BudgetModel({
    required this.id,
    required this.userId,
    required this.category,
    required this.month,
    required this.year,
    required this.limitAmount,
    this.period = BudgetPeriod.monthly,
    required this.createdAt,
    required this.updatedAt,
    this.isDeleted = false,
    this.deletedAt,
  });

  @HiveField(0)
  String id;

  @HiveField(1)
  String userId;

  @HiveField(2)
  String category;

  @HiveField(3)
  int month;

  @HiveField(4)
  int year;

  @HiveField(5)
  double limitAmount;

  @HiveField(6)
  BudgetPeriod period;

  @HiveField(7)
  DateTime createdAt;

  @HiveField(8)
  DateTime updatedAt;

  @HiveField(9)
  bool isDeleted;

  @HiveField(10)
  DateTime? deletedAt;

  factory BudgetModel.fromEntity(BudgetEntity e) => BudgetModel(
    id: e.id,
    userId: e.userId,
    category: e.category,
    month: e.month,
    year: e.year,
    limitAmount: e.limitAmount,
    period: e.period,
    createdAt: e.createdAt,
    updatedAt: e.updatedAt,
    isDeleted: e.isDeleted,
    deletedAt: e.deletedAt,
  );

  factory BudgetModel.fromFirestore(String id, Map<String, dynamic> data) =>
      BudgetModel(
        id: id,
        userId: data['userId'] as String? ?? '',
        category: data['category'] as String? ?? '',
        month: data['month'] as int? ?? DateTime.now().month,
        year: data['year'] as int? ?? DateTime.now().year,
        limitAmount: (data['limitAmount'] as num? ?? 0).toDouble(),
        period: BudgetPeriod.fromString(data['period'] as String? ?? 'monthly'),
        createdAt: _ts(data['createdAt']),
        updatedAt: _ts(data['updatedAt']),
        isDeleted: data['isDeleted'] as bool? ?? false,
        deletedAt: _tsOrNull(data['deletedAt']),
      );

  BudgetEntity toEntity() => BudgetEntity(
    id: id,
    userId: userId,
    category: category,
    month: month,
    year: year,
    limitAmount: limitAmount,
    period: period,
    createdAt: createdAt,
    updatedAt: updatedAt,
    isDeleted: isDeleted,
    deletedAt: deletedAt,
  );

  Map<String, dynamic> toFirestoreMap() => {
    'userId': userId,
    'category': category,
    'month': month,
    'year': year,
    'limitAmount': limitAmount,
    'period': period.value,
    'createdAt': createdAt.toUtc().toIso8601String(),
    'updatedAt': updatedAt.toUtc().toIso8601String(),
    'isDeleted': isDeleted,
    'deletedAt': deletedAt?.toUtc().toIso8601String(),
  };

  static DateTime _ts(dynamic v) {
    if (v is Timestamp) return v.toDate().toUtc();
    if (v is DateTime) return v.toUtc();
    if (v is String) return DateTime.parse(v).toUtc();
    return DateTime.now().toUtc();
  }

  static DateTime? _tsOrNull(dynamic v) => v == null ? null : _ts(v);
}
