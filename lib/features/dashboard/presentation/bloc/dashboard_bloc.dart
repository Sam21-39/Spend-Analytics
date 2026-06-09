import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:spend_analytics/core/error/failures.dart';
import 'package:spend_analytics/features/budget/domain/models/budget_progress.dart';
import 'package:spend_analytics/features/budget/domain/usecases/get_budget_progress_use_case.dart';
import 'package:spend_analytics/features/expense/domain/usecases/watch_expenses_use_case.dart';

import 'dashboard_event.dart';
import 'dashboard_state.dart';

@injectable
class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc(this._watchExpenses, this._getBudgetProgress)
      : super(const DashboardState.initial()) {
    on<DashboardLoad>(_onLoad, transformer: restartable());
    on<DashboardRefresh>(_onRefresh);
  }

  final WatchExpensesUseCase _watchExpenses;
  final GetBudgetProgressUseCase _getBudgetProgress;

  String? _currentUserId;
  List<BudgetProgress> _cachedBudgetProgresses = const [];

  Future<void> _onLoad(DashboardLoad event, Emitter<DashboardState> emit) async {
    _currentUserId = event.userId;
    emit(const DashboardState.loading());

    final now = DateTime.now();
    final budgetResult = await _getBudgetProgress(
      userId: event.userId,
      month: now.month,
      year: now.year,
    );
    _cachedBudgetProgresses = budgetResult.getOrElse(() => []);

    await emit.forEach(
      _watchExpenses(event.userId),
      onData: (result) => result.fold(
        (f) => DashboardState.failure(failure: f),
        (expenses) {
          final monthlySpend = expenses
              .where((e) =>
                  e.expenseType.name == 'expense' &&
                  e.transactionDate.month == now.month &&
                  e.transactionDate.year == now.year)
              .fold<double>(0, (sum, e) => sum + e.amount);
          return DashboardState.loaded(
            expenses: expenses,
            budgetProgresses: _cachedBudgetProgresses,
            monthlySpend: monthlySpend,
            firstName: event.firstName,
            isGuestMode: event.isGuestMode,
          );
        },
      ),
      onError: (e, _) =>
          DashboardState.failure(failure: Failure.unknown(e.toString(), cause: e)),
    );
  }

  Future<void> _onRefresh(
      DashboardRefresh event, Emitter<DashboardState> emit) async {
    final uid = _currentUserId;
    if (uid == null) return;
    final current = state;
    add(DashboardEvent.load(
      userId: uid,
      firstName: current.maybeMap(
        loaded: (s) => s.firstName,
        orElse: () => 'User',
      ),
      isGuestMode: current.maybeMap(
        loaded: (s) => s.isGuestMode,
        orElse: () => true,
      ),
    ));
  }
}
