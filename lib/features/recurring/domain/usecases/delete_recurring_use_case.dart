import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:spend_analytics/core/error/failures.dart';
import 'package:spend_analytics/features/recurring/domain/repositories/i_recurring_repository.dart';

@injectable
class DeleteRecurringUseCase {
  const DeleteRecurringUseCase(this._repo);
  final IRecurringRepository _repo;

  Future<Either<Failure, void>> call({
    required String id,
    required String userId,
  }) =>
      _repo.deleteRecurring(id, userId);
}
