import 'package:dartz/dartz.dart';
import 'package:spend_analytics/core/error/failures.dart';
import 'package:spend_analytics/features/budget/domain/entities/budget_entity.dart';

abstract interface class IBudgetRepository {
  Stream<Either<Failure, List<BudgetEntity>>> watchBudgetsForMonth({
    required String userId,
    required int month,
    required int year,
  });
  Future<Either<Failure, void>> upsertBudget(BudgetEntity budget);
  Future<Either<Failure, void>> archiveBudget(String id, String userId);
  Future<Either<Failure, List<BudgetEntity>>> getBudgetsForMonth({
    required String userId,
    required int month,
    required int year,
  });
}
