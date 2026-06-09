import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:spend_analytics/core/error/failures.dart';
import 'package:spend_analytics/features/expense/domain/entities/expense_entity.dart';
import 'package:spend_analytics/features/expense/domain/repositories/i_expense_repository.dart';

@injectable
class WatchExpensesUseCase {
  const WatchExpensesUseCase(this._repo);
  final IExpenseRepository _repo;

  Stream<Either<Failure, List<ExpenseEntity>>> call(String userId) =>
      _repo.watchExpenses(userId);
}
