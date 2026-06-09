import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:spend_analytics/core/error/failures.dart';
import 'package:spend_analytics/features/expense/domain/usecases/add_expense_use_case.dart';
import 'package:spend_analytics/features/expense/domain/usecases/delete_expense_use_case.dart';
import 'package:spend_analytics/features/expense/domain/usecases/update_expense_use_case.dart';
import 'package:spend_analytics/features/expense/domain/usecases/watch_expenses_use_case.dart';
import 'package:spend_analytics/features/rules/domain/usecases/evaluate_rules_use_case.dart';

import 'expense_event.dart';
import 'expense_state.dart';

@injectable
class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  ExpenseBloc(
    this._watchExpenses,
    this._addExpense,
    this._updateExpense,
    this._deleteExpense,
    this._evaluateRules,
  ) : super(const ExpenseState.initial()) {
    on<ExpenseLoad>(_onLoad, transformer: restartable());
    on<ExpenseAdd>(_onAdd);
    on<ExpenseUpdate>(_onUpdate);
    on<ExpenseDelete>(_onDelete);
    on<ExpenseFilter>(_onFilter);
    on<ExpenseApplyVoiceResult>(_onApplyVoice);
  }

  final WatchExpensesUseCase _watchExpenses;
  final AddExpenseUseCase _addExpense;
  final UpdateExpenseUseCase _updateExpense;
  final DeleteExpenseUseCase _deleteExpense;
  final EvaluateRulesUseCase _evaluateRules;

  Future<void> _onLoad(ExpenseLoad event, Emitter<ExpenseState> emit) async {
    emit(const ExpenseState.loading());
    await emit.forEach(
      _watchExpenses(event.userId),
      onData: (result) => result.fold(
        (f) => ExpenseState.failure(failure: f),
        (expenses) => ExpenseState.loaded(expenses: expenses),
      ),
      onError: (e, _) =>
          ExpenseState.failure(failure: Failure.unknown(e.toString(), cause: e)),
    );
  }

  Future<void> _onAdd(ExpenseAdd event, Emitter<ExpenseState> emit) async {
    emit(const ExpenseState.saving());
    final result = await _addExpense(event.expense);
    result.fold(
      (f) => emit(ExpenseState.failure(failure: f)),
      (_) {
        emit(const ExpenseState.saved());
        // Fire-and-forget rules evaluation; failures are non-blocking
        _evaluateRules(event.expense).ignore();
      },
    );
  }

  Future<void> _onUpdate(ExpenseUpdate event, Emitter<ExpenseState> emit) async {
    emit(const ExpenseState.saving());
    final result = await _updateExpense(event.expense);
    result.fold(
      (f) => emit(ExpenseState.failure(failure: f)),
      (_) => emit(const ExpenseState.saved()),
    );
  }

  Future<void> _onDelete(ExpenseDelete event, Emitter<ExpenseState> emit) async {
    emit(const ExpenseState.saving());
    final result =
        await _deleteExpense(id: event.id, userId: event.userId);
    result.fold(
      (f) => emit(ExpenseState.failure(failure: f)),
      (_) => emit(const ExpenseState.saved()),
    );
  }

  void _onFilter(ExpenseFilter event, Emitter<ExpenseState> emit) {
    final current = state;
    if (current is ExpenseLoaded) {
      emit(ExpenseState.loaded(
        expenses: current.expenses,
        filterType: event.type,
        filterCategory: event.category,
      ));
    }
  }

  Future<void> _onApplyVoice(
      ExpenseApplyVoiceResult event, Emitter<ExpenseState> emit) async {
    final result = event.result;
    final amount = result.amount;
    if (amount == null || amount <= 0) return;
    // Voice result is forwarded as an intent to add; the UI builds the
    // ExpenseEntity and dispatches ExpenseAdd with full entity.
  }
}
