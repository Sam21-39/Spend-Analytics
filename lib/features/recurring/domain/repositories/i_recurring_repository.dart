import 'package:dartz/dartz.dart';
import 'package:spend_analytics/core/error/failures.dart';
import 'package:spend_analytics/features/recurring/domain/entities/recurring_entity.dart';

abstract interface class IRecurringRepository {
  Stream<Either<Failure, List<RecurringEntity>>> watchRecurring(String userId);
  Future<Either<Failure, List<RecurringEntity>>> getRecurring(String userId);
  Future<Either<Failure, List<RecurringEntity>>> getDueItems(String userId);
  Future<Either<Failure, void>> addRecurring(RecurringEntity item);
  Future<Either<Failure, void>> updateRecurring(RecurringEntity item);
  Future<Either<Failure, void>> deleteRecurring(String id, String userId);
  Future<Either<Failure, void>> advanceDueDate(String id, String userId);
}
