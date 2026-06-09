import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:spend_analytics/core/error/failures.dart';
import 'package:spend_analytics/features/recurring/domain/entities/recurring_entity.dart';
import 'package:spend_analytics/features/recurring/domain/repositories/i_recurring_repository.dart';

@injectable
class LoadRecurringUseCase {
  const LoadRecurringUseCase(this._repo);
  final IRecurringRepository _repo;

  Future<Either<Failure, List<RecurringEntity>>> call(String userId) =>
      _repo.getRecurring(userId);
}
