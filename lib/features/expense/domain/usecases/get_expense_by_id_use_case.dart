import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:spend_analytics/core/error/failures.dart';
import 'package:spend_analytics/features/expense/domain/entities/expense_entity.dart';
import 'package:spend_analytics/features/expense/domain/repositories/i_expense_repository.dart';

@injectable
class GetExpenseByIdUseCase {
  const GetExpenseByIdUseCase(this._repo);
  final IExpenseRepository _repo;

  Future<Either<Failure, ExpenseEntity?>> call(String id) =>
      _repo.getExpenseById(id);
}
