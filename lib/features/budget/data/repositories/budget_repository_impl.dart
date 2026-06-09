import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:spend_analytics/core/error/failures.dart';
import 'package:spend_analytics/core/services/sync_service.dart';
import 'package:spend_analytics/features/budget/data/datasources/local/budget_local_datasource.dart';
import 'package:spend_analytics/features/budget/data/models/budget_model.dart';
import 'package:spend_analytics/features/budget/domain/entities/budget_entity.dart';
import 'package:spend_analytics/features/budget/domain/repositories/i_budget_repository.dart';

@LazySingleton(as: IBudgetRepository)
class BudgetRepositoryImpl implements IBudgetRepository {
  const BudgetRepositoryImpl(this._local, this._sync);

  final BudgetLocalDataSource _local;
  final SyncService _sync;

  @override
  Future<Either<Failure, void>> upsertBudget(BudgetEntity budget) async {
    final model = BudgetModel.fromEntity(budget);
    final result = await _local.saveBudget(model);
    if (result.isLeft()) return result;
    await _sync.enqueueUpsert(
      entityType: 'budgets',
      entityId: model.id,
      userId: model.userId,
      payload: model.toFirestoreMap(),
    );
    return const Right(null);
  }

  @override
  Future<Either<Failure, void>> archiveBudget(
    String id,
    String userId,
  ) async {
    final result = await _local.archiveBudget(id, userId);
    if (result.isLeft()) return result;
    await _sync.enqueueDelete(
      entityType: 'budgets',
      entityId: id,
      userId: userId,
    );
    return const Right(null);
  }

  @override
  Future<Either<Failure, List<BudgetEntity>>> getBudgetsForMonth({
    required String userId,
    required int month,
    required int year,
  }) async {
    final result = await _local.getForMonth(
      userId: userId,
      month: month,
      year: year,
    );
    return result.map((models) => models.map((m) => m.toEntity()).toList());
  }

  @override
  Stream<Either<Failure, List<BudgetEntity>>> watchBudgetsForMonth({
    required String userId,
    required int month,
    required int year,
  }) {
    return _local
        .watchForMonth(userId: userId, month: month, year: year)
        .map((r) => r.map((models) => models.map((m) => m.toEntity()).toList()));
  }
}
