import 'package:dartz/dartz.dart';
import 'package:hive_ce/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:spend_analytics/core/constants/hive_box_names.dart';
import 'package:spend_analytics/core/error/failures.dart';
import 'package:spend_analytics/features/recurring/data/models/recurring_model.dart';

@lazySingleton
class RecurringLocalDataSource {
  Box<RecurringModel> get _box =>
      Hive.box<RecurringModel>(HiveBoxNames.recurring);

  Future<Either<Failure, void>> saveRecurring(RecurringModel model) async {
    try {
      await _box.put(model.id, model);
      return const Right(null);
    } on HiveError catch (e) {
      return Left(Failure.local(e.message));
    }
  }

  Future<Either<Failure, void>> deleteRecurring(
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

  Future<Either<Failure, List<RecurringModel>>> getRecurring(
    String userId,
  ) async {
    try {
      final results = _box.values
          .where((r) => r.userId == userId && !r.isDeleted)
          .toList()
        ..sort((a, b) => a.nextDueDate.compareTo(b.nextDueDate));
      return Right(results);
    } on HiveError catch (e) {
      return Left(Failure.local(e.message));
    }
  }

  Future<Either<Failure, List<RecurringModel>>> getDueItems(
    String userId,
  ) async {
    try {
      final today = DateTime.now();
      final results = _box.values
          .where(
            (r) =>
                r.userId == userId &&
                !r.isDeleted &&
                r.isActive &&
                !r.nextDueDate.isAfter(today),
          )
          .toList()
        ..sort((a, b) => a.nextDueDate.compareTo(b.nextDueDate));
      return Right(results);
    } on HiveError catch (e) {
      return Left(Failure.local(e.message));
    }
  }

  Stream<Either<Failure, List<RecurringModel>>> watchRecurring(
    String userId,
  ) {
    return Stream.multi((controller) {
      Either<Failure, List<RecurringModel>> snap() {
        try {
          final results = _box.values
              .where((r) => r.userId == userId && !r.isDeleted)
              .toList()
            ..sort((a, b) => a.nextDueDate.compareTo(b.nextDueDate));
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
