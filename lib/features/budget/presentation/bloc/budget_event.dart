import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:spend_analytics/features/budget/domain/entities/budget_entity.dart';

part 'budget_event.freezed.dart';

@freezed
sealed class BudgetEvent with _$BudgetEvent {
  const factory BudgetEvent.load({
    required String userId,
    required int month,
    required int year,
  }) = BudgetLoad;
  const factory BudgetEvent.upsert({required BudgetEntity budget}) =
      BudgetUpsert;
  const factory BudgetEvent.archive({
    required String id,
    required String userId,
  }) = BudgetArchive;
  const factory BudgetEvent.seedDefaults({
    required String userId,
    required int month,
    required int year,
  }) = BudgetSeedDefaults;
}
