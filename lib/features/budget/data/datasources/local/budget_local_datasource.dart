import 'package:dartz/dartz.dart';
import 'package:hive_ce/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:spend_analytics/core/constants/hive_box_names.dart';
import 'package:spend_analytics/core/error/failures.dart';
import 'package:spend_analytics/features/budget/data/models/budget_model.dart';

@lazySingleton
class BudgetLocalDataSource {
  Box<BudgetModel> get _box => Hive.box<BudgetModel>(HiveBoxNames.budgets);

  Future<Either<Failure, void>> saveBudget(BudgetModel model) async {
    try {
      await _box.put(model.id, model);
      return const Right(null);
    } on HiveError catch (e) {
      return Left(Failure.local(e.message));
    }
  }

  Future<Either<Failure, void>> archiveBudget(
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

  Future<Either<Failure, List<BudgetModel>>> getForMonth({
    required String userId,
    required int month,
    required int year,
  }) async {
    try {
      final results = _box.values
          .where(
            (b) =>
                b.userId == userId &&
                !b.isDeleted &&
                b.month == month &&
                b.year == year,
          )
          .toList()
        ..sort((a, b) => a.category.compareTo(b.category));
      return Right(results);
    } on HiveError catch (e) {
      return Left(Failure.local(e.message));
    }
  }

  Stream<Either<Failure, List<BudgetModel>>> watchForMonth({
    required String userId,
    required int month,
    required int year,
  }) {
    return Stream.multi((controller) {
      Either<Failure, List<BudgetModel>> snap() {
        try {
          final results = _box.values
              .where(
                (b) =>
                    b.userId == userId &&
                    !b.isDeleted &&
                    b.month == month &&
                    b.year == year,
              )
              .toList()
            ..sort((a, b) => a.category.compareTo(b.category));
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
