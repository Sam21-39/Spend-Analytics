import 'package:dartz/dartz.dart';
import 'package:hive_ce/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:spend_analytics/core/constants/hive_box_names.dart';
import 'package:spend_analytics/core/error/failures.dart';
import 'package:spend_analytics/features/expense/data/models/expense_model.dart';

@lazySingleton
class ExpenseLocalDataSource {
  Box<ExpenseModel> get _box =>
      Hive.box<ExpenseModel>(HiveBoxNames.expenses);

  Future<Either<Failure, void>> saveExpense(ExpenseModel model) async {
    try {
      await _box.put(model.id, model);
      return const Right(null);
    } on HiveError catch (e) {
      return Left(Failure.local(e.message));
    }
  }

  Future<Either<Failure, void>> deleteExpense(
    String id,
    String userId,
  ) async {
    try {
      final model = _box.get(id);
      if (model == null) return const Right(null);
      model
        ..isDeleted = true
        ..deletedAt = DateTime.now().toUtc();
      await _box.put(id, model);
      return const Right(null);
    } on HiveError catch (e) {
      return Left(Failure.local(e.message));
    }
  }

  Future<Either<Failure, ExpenseModel?>> getById(String id) async {
    try {
      return Right(_box.get(id));
    } on HiveError catch (e) {
      return Left(Failure.local(e.message));
    }
  }

  Future<Either<Failure, List<ExpenseModel>>> getForMonth({
    required String userId,
    required int month,
    required int year,
  }) async {
    try {
      final results = _box.values
          .where(
            (e) =>
                e.userId == userId &&
                !e.isDeleted &&
                e.transactionDate.month == month &&
                e.transactionDate.year == year,
          )
          .toList()
        ..sort(
          (a, b) => b.transactionDate.compareTo(a.transactionDate),
        );
      return Right(results);
    } on HiveError catch (e) {
      return Left(Failure.local(e.message));
    }
  }

  Stream<Either<Failure, List<ExpenseModel>>> watchExpenses(String userId) {
    return Stream.multi((controller) {
      Either<Failure, List<ExpenseModel>> snap() {
        try {
          final results = _box.values
              .where((e) => e.userId == userId && !e.isDeleted)
              .toList()
            ..sort(
              (a, b) => b.transactionDate.compareTo(a.transactionDate),
            );
          return Right(results);
        } on HiveError catch (e) {
          return Left(Failure.local(e.message));
        }
      }

      controller.add(snap());
      final sub = _box.watch().listen((_) => controller.add(snap()));
      controller.onCancel = sub.cancel;
    });
  }
}
