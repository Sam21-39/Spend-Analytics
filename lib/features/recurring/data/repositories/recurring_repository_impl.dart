import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:spend_analytics/core/error/failures.dart';
import 'package:spend_analytics/core/services/sync_service.dart';
import 'package:spend_analytics/features/recurring/data/datasources/local/recurring_local_datasource.dart';
import 'package:spend_analytics/features/recurring/data/models/recurring_model.dart';
import 'package:spend_analytics/features/recurring/domain/entities/recurring_entity.dart';
import 'package:spend_analytics/features/recurring/domain/repositories/i_recurring_repository.dart';

@LazySingleton(as: IRecurringRepository)
class RecurringRepositoryImpl implements IRecurringRepository {
  const RecurringRepositoryImpl(this._local, this._sync);

  final RecurringLocalDataSource _local;
  final SyncService _sync;

  @override
  Stream<Either<Failure, List<RecurringEntity>>> watchRecurring(
    String userId,
  ) {
    return _local
        .watchRecurring(userId)
        .map((r) => r.map((models) => models.map((m) => m.toEntity()).toList()));
  }

  @override
  Future<Either<Failure, List<RecurringEntity>>> getRecurring(
    String userId,
  ) async {
    final result = await _local.getRecurring(userId);
    return result.map((models) => models.map((m) => m.toEntity()).toList());
  }

  @override
  Future<Either<Failure, List<RecurringEntity>>> getDueItems(
    String userId,
  ) async {
    final result = await _local.getDueItems(userId);
    return result.map((models) => models.map((m) => m.toEntity()).toList());
  }

  @override
  Future<Either<Failure, void>> addRecurring(RecurringEntity item) async {
    final model = RecurringModel.fromEntity(item);
    final result = await _local.saveRecurring(model);
    if (result.isLeft()) return result;
    await _sync.enqueueUpsert(
      entityType: 'recurring',
      entityId: model.id,
      userId: model.userId,
      payload: model.toFirestoreMap(),
    );
    return const Right(null);
  }

  @override
  Future<Either<Failure, void>> updateRecurring(
    RecurringEntity item,
  ) => addRecurring(item);

  @override
  Future<Either<Failure, void>> deleteRecurring(
    String id,
    String userId,
  ) async {
    final result = await _local.deleteRecurring(id, userId);
    if (result.isLeft()) return result;
    await _sync.enqueueDelete(
      entityType: 'recurring',
      entityId: id,
      userId: userId,
    );
    return const Right(null);
  }

  @override
  Future<Either<Failure, void>> advanceDueDate(
    String id,
    String userId,
  ) async {
    final items = await _local.getRecurring(userId);
    return items.fold(
      Left.new,
      (models) async {
        final model = models.firstWhere(
          (m) => m.id == id,
          orElse: () => throw StateError('Recurring $id not found'),
        );
        final next = _computeNextDue(model);
        model
          ..nextDueDate = next
          ..updatedAt = DateTime.now().toUtc();
        final result = await _local.saveRecurring(model);
        if (result.isLeft()) return result;
        await _sync.enqueueUpsert(
          entityType: 'recurring',
          entityId: id,
          userId: userId,
          payload: model.toFirestoreMap(),
        );
        return const Right(null);
      },
    );
  }

  DateTime _computeNextDue(RecurringModel model) {
    final current = model.nextDueDate;
    return switch (model.frequency.value) {
      'daily' => current.add(const Duration(days: 1)),
      'weekly' => current.add(const Duration(days: 7)),
      'yearly' => DateTime(
          current.year + 1,
          current.month,
          current.day,
        ),
      _ => DateTime(current.year, current.month + 1, current.day),
    };
  }
}
