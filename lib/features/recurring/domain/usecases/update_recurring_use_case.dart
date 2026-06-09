import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:spend_analytics/core/error/failures.dart';
import 'package:spend_analytics/features/recurring/domain/entities/recurring_entity.dart';
import 'package:spend_analytics/features/recurring/domain/repositories/i_recurring_repository.dart';

@injectable
class UpdateRecurringUseCase {
  const UpdateRecurringUseCase(this._repo);
  final IRecurringRepository _repo;

  Future<Either<Failure, void>> call(RecurringEntity item) async {
    if (item.amount <= 0) {
      return Left(Failure.validation('Amount must be positive'));
    }
    return _repo.updateRecurring(item);
  }
}
