import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:spend_analytics/core/error/failures.dart';
import 'package:spend_analytics/features/expense/domain/repositories/i_expense_repository.dart';

@injectable
class DeleteExpenseUseCase {
  const DeleteExpenseUseCase(this._repo);
  final IExpenseRepository _repo;

  Future<Either<Failure, void>> call({
    required String id,
    required String userId,
  }) =>
      _repo.deleteExpense(id, userId);
}
