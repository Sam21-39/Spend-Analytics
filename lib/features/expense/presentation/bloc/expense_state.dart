import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:spend_analytics/core/error/failures.dart';
import 'package:spend_analytics/features/expense/domain/entities/expense_entity.dart';

part 'expense_state.freezed.dart';

@freezed
sealed class ExpenseState with _$ExpenseState {
  const factory ExpenseState.initial() = ExpenseInitial;
  const factory ExpenseState.loading() = ExpenseLoading;
  const factory ExpenseState.loaded({
    required List<ExpenseEntity> expenses,
    String? filterType,
    String? filterCategory,
  }) = ExpenseLoaded;
  const factory ExpenseState.saving() = ExpenseSaving;
  const factory ExpenseState.saved() = ExpenseSaved;
  const factory ExpenseState.failure({required Failure failure}) = ExpenseFailure;
}
