import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:spend_analytics/core/error/failures.dart';
import 'package:spend_analytics/features/budget/domain/entities/budget_entity.dart';
import 'package:spend_analytics/features/budget/domain/repositories/i_budget_repository.dart';

@injectable
class UpsertBudgetUseCase {
  const UpsertBudgetUseCase(this._repo);
  final IBudgetRepository _repo;

  Future<Either<Failure, void>> call(BudgetEntity budget) async {
    if (budget.limitAmount <= 0) {
      return Left(Failure.validation('Budget limit must be positive'));
    }
    return _repo.upsertBudget(budget);
  }
}
