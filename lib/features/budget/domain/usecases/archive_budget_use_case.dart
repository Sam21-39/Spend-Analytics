import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:spend_analytics/core/error/failures.dart';
import 'package:spend_analytics/features/budget/domain/repositories/i_budget_repository.dart';

@injectable
class ArchiveBudgetUseCase {
  const ArchiveBudgetUseCase(this._repo);
  final IBudgetRepository _repo;

  Future<Either<Failure, void>> call({
    required String id,
    required String userId,
  }) =>
      _repo.archiveBudget(id, userId);
}
