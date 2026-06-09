import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:spend_analytics/core/error/failures.dart';
import 'package:spend_analytics/features/expense/domain/entities/expense_entity.dart';
import 'package:spend_analytics/features/expense/domain/repositories/i_expense_repository.dart';

@injectable
class UpdateExpenseUseCase {
  const UpdateExpenseUseCase(this._repo);
  final IExpenseRepository _repo;

  Future<Either<Failure, void>> call(ExpenseEntity expense) async {
    if (expense.amount <= 0) {
      return Left(Failure.validation('Amount must be positive'));
    }
    return _repo.updateExpense(expense);
  }
}
