import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:spend_analytics/core/error/failures.dart';
import 'package:spend_analytics/features/expense/domain/repositories/i_expense_repository.dart';

@injectable
class GetMonthlyTotalsUseCase {
  const GetMonthlyTotalsUseCase(this._repo);
  final IExpenseRepository _repo;

  /// Returns category → total spent for the given month.
  Future<Either<Failure, Map<String, double>>> call({
    required String userId,
    required int month,
    required int year,
  }) =>
      _repo.getCategorySpendForMonth(userId: userId, month: month, year: year);
}
