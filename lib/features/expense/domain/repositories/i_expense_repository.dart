import 'package:dartz/dartz.dart';
import 'package:spend_analytics/core/error/failures.dart';
import 'package:spend_analytics/features/expense/domain/entities/expense_entity.dart';

abstract interface class IExpenseRepository {
  Future<Either<Failure, void>> addExpense(ExpenseEntity expense);
  Future<Either<Failure, void>> updateExpense(ExpenseEntity expense);
  Future<Either<Failure, void>> deleteExpense(String id, String userId);
  Stream<Either<Failure, List<ExpenseEntity>>> watchExpenses(String userId);
  Future<Either<Failure, ExpenseEntity?>> getExpenseById(String id);
  Future<Either<Failure, List<ExpenseEntity>>> getExpensesForMonth({
    required String userId,
    required int month,
    required int year,
  });
  Future<Either<Failure, Map<String, double>>> getCategorySpendForMonth({
    required String userId,
    required int month,
    required int year,
  });
}
