import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:spend_analytics/core/error/failures.dart';
import 'package:spend_analytics/features/budget/domain/models/budget_progress.dart';
import 'package:spend_analytics/features/budget/domain/repositories/i_budget_repository.dart';
import 'package:spend_analytics/features/expense/domain/repositories/i_expense_repository.dart';

@injectable
class GetBudgetProgressUseCase {
  const GetBudgetProgressUseCase(this._budgetRepo, this._expenseRepo);
  final IBudgetRepository _budgetRepo;
  final IExpenseRepository _expenseRepo;

  Future<Either<Failure, List<BudgetProgress>>> call({
    required String userId,
    required int month,
    required int year,
  }) async {
    final budgetsResult = await _budgetRepo.getBudgetsForMonth(
      userId: userId,
      month: month,
      year: year,
    );
    if (budgetsResult.isLeft()) return budgetsResult.map((_) => []);

    final budgets = budgetsResult
        .getOrElse(() => [])
        .where((b) => !b.isDeleted)
        .toList();
    if (budgets.isEmpty) return const Right([]);

    final spendResult = await _expenseRepo.getCategorySpendForMonth(
      userId: userId,
      month: month,
      year: year,
    );
    if (spendResult.isLeft()) return spendResult.map((_) => []);

    final spendMap = spendResult.getOrElse(() => {});
    return Right(
      budgets
          .map((b) => BudgetProgress(
                budget: b,
                spent: spendMap[b.category] ?? 0,
              ))
          .toList(),
    );
  }
}
