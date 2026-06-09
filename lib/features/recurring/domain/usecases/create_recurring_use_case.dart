import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:spend_analytics/core/error/failures.dart';
import 'package:spend_analytics/features/recurring/domain/entities/recurring_entity.dart';
import 'package:spend_analytics/features/recurring/domain/repositories/i_recurring_repository.dart';

@injectable
class CreateRecurringUseCase {
  const CreateRecurringUseCase(this._repo);
  final IRecurringRepository _repo;

  Future<Either<Failure, void>> call(RecurringEntity item) async {
    if (item.amount <= 0) {
      return Left(Failure.validation('Amount must be positive'));
    }
    if (item.title.trim().isEmpty) {
      return Left(Failure.validation('Title cannot be empty'));
    }
    return _repo.addRecurring(item);
  }
}
