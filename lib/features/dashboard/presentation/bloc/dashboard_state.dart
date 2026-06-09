import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:spend_analytics/core/error/failures.dart';
import 'package:spend_analytics/features/budget/domain/models/budget_progress.dart';
import 'package:spend_analytics/features/expense/domain/entities/expense_entity.dart';

part 'dashboard_state.freezed.dart';

@freezed
sealed class DashboardState with _$DashboardState {
  const factory DashboardState.initial() = DashboardInitial;
  const factory DashboardState.loading() = DashboardLoading;
  const factory DashboardState.loaded({
    required List<ExpenseEntity> expenses,
    required List<BudgetProgress> budgetProgresses,
    required double monthlySpend,
    required String firstName,
    required bool isGuestMode,
  }) = DashboardLoaded;
  const factory DashboardState.failure({required Failure failure}) =
      DashboardFailure;
}
