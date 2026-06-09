import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:spend_analytics/core/enums/budget_period.dart';

part 'budget_entity.freezed.dart';

@freezed
abstract class BudgetEntity with _$BudgetEntity {
  const factory BudgetEntity({
    required String id,
    required String userId,
    required String category,
    required int month,
    required int year,
    required double limitAmount,
    @Default(BudgetPeriod.monthly) BudgetPeriod period,
    required DateTime createdAt,
    required DateTime updatedAt,
    @Default(false) bool isDeleted,
    DateTime? deletedAt,
  }) = _BudgetEntity;
}
