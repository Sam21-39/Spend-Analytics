import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:spend_analytics/core/error/failures.dart';
import 'package:spend_analytics/features/budget/domain/entities/budget_entity.dart';
import 'package:spend_analytics/features/budget/domain/repositories/i_budget_repository.dart';

@injectable
class LoadBudgetsUseCase {
  const LoadBudgetsUseCase(this._repo);
  final IBudgetRepository _repo;

  Future<Either<Failure, List<BudgetEntity>>> call({
    required String userId,
    required int month,
    required int year,
  }) =>
      _repo.getBudgetsForMonth(userId: userId, month: month, year: year);
}
