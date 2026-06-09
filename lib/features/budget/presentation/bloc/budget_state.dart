import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:spend_analytics/core/error/failures.dart';
import 'package:spend_analytics/features/budget/domain/models/budget_progress.dart';

part 'budget_state.freezed.dart';

@freezed
sealed class BudgetState with _$BudgetState {
  const factory BudgetState.initial() = BudgetInitial;
  const factory BudgetState.loading() = BudgetLoading;
  const factory BudgetState.loaded({
    required List<BudgetProgress> progresses,
  }) = BudgetLoaded;
  const factory BudgetState.failure({required Failure failure}) = BudgetFailure;
}
