import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:spend_analytics/core/error/failures.dart';
import 'package:spend_analytics/core/services/sync_service.dart';
import 'package:spend_analytics/features/expense/data/datasources/local/expense_local_datasource.dart';
import 'package:spend_analytics/features/expense/data/datasources/remote/expense_remote_datasource.dart';
import 'package:spend_analytics/features/expense/data/models/expense_model.dart';
import 'package:spend_analytics/features/expense/domain/entities/expense_entity.dart';
import 'package:spend_analytics/features/expense/domain/repositories/i_expense_repository.dart';

@LazySingleton(as: IExpenseRepository)
class ExpenseRepositoryImpl implements IExpenseRepository {
  const ExpenseRepositoryImpl(this._local, this._remote, this._sync);

  final ExpenseLocalDataSource _local;
  final ExpenseRemoteDataSource _remote;
  final SyncService _sync;

  @override
  Future<Either<Failure, void>> addExpense(ExpenseEntity expense) async {
    final model = ExpenseModel.fromEntity(expense);
    final result = await _local.saveExpense(model);
    if (result.isLeft()) return result;
    await _sync.enqueueUpsert(
      entityType: 'expenses',
      entityId: model.id,
      userId: model.userId,
      payload: model.toFirestoreMap(),
    );
    return const Right(null);
  }

  @override
  Future<Either<Failure, void>> updateExpense(ExpenseEntity expense) =>
      addExpense(expense);

  @override
  Future<Either<Failure, void>> deleteExpense(
    String id,
    String userId,
  ) async {
    final result = await _local.deleteExpense(id, userId);
    if (result.isLeft()) return result;
    await _sync.enqueueDelete(
      entityType: 'expenses',
      entityId: id,
      userId: userId,
    );
    return const Right(null);
  }

  @override
  Stream<Either<Failure, List<ExpenseEntity>>> watchExpenses(
    String userId,
  ) {
    return _local
        .watchExpenses(userId)
        .map((r) => r.map((models) => models.map((m) => m.toEntity()).toList()));
  }

  @override
  Future<Either<Failure, ExpenseEntity?>> getExpenseById(String id) async {
    final result = await _local.getById(id);
    return result.map((m) => m?.toEntity());
  }

  @override
  Future<Either<Failure, List<ExpenseEntity>>> getExpensesForMonth({
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
  Future<Either<Failure, Map<String, double>>> getCategorySpendForMonth({
    required String userId,
    required int month,
    required int year,
  }) async {
    final result = await _local.getForMonth(
      userId: userId,
      month: month,
      year: year,
    );
    return result.map((models) {
      final totals = <String, double>{};
      for (final m in models) {
        if (m.expenseType.value == 'expense') {
          totals.update(
            m.category,
            (v) => v + m.amount,
            ifAbsent: () => m.amount,
          );
        }
      }
      return totals;
    });
  }

  // Pull-all is called on first login to recover cloud data after reinstall.
  Future<void> pullAllFromCloud(String userId) async {
    final result = await _remote.fetchAll(userId);
    result.fold(
      (_) {},
      (models) async {
        for (final m in models) {
          await _local.saveExpense(m);
        }
      },
    );
  }
}
