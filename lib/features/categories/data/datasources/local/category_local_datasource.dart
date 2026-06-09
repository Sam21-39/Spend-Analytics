import 'package:dartz/dartz.dart';
import 'package:hive_ce/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:spend_analytics/core/constants/app_constants.dart';
import 'package:spend_analytics/core/constants/hive_box_names.dart';
import 'package:spend_analytics/core/error/failures.dart';
import 'package:spend_analytics/features/categories/data/models/category_model.dart';
import 'package:uuid/uuid.dart';

@lazySingleton
class CategoryLocalDataSource {
  Box<CategoryModel> get _box =>
      Hive.box<CategoryModel>(HiveBoxNames.categories);

  Future<Either<Failure, void>> saveCategory(CategoryModel model) async {
    try {
      await _box.put(model.id, model);
      return const Right(null);
    } on HiveError catch (e) {
      return Left(Failure.local(e.message));
    }
  }

  Future<Either<Failure, List<CategoryModel>>> getCategories(
    String userId, {
    String? type,
  }) async {
    try {
      final results = _box.values
          .where(
            (c) =>
                c.userId == userId && (type == null || c.type == type),
          )
          .toList()
        ..sort((a, b) => a.sortOrder.compareTo(b.sortOrder));
      return Right(results);
    } on HiveError catch (e) {
      return Left(Failure.local(e.message));
    }
  }

  Future<Either<Failure, void>> saveAll(List<CategoryModel> models) async {
    try {
      final map = {for (final m in models) m.id: m};
      await _box.putAll(map);
      return const Right(null);
    } on HiveError catch (e) {
      return Left(Failure.local(e.message));
    }
  }

  Future<Either<Failure, void>> seedDefaults(String userId) async {
    try {
      final existing = _box.values.where((c) => c.userId == userId).toList();
      if (existing.isNotEmpty) return const Right(null);

      final now = DateTime.now().toUtc();
      const uuid = Uuid();
      final seeds = <CategoryModel>[];

      for (final type in ['expense', 'income', 'transfer']) {
        final defaults = switch (type) {
          'expense' => AppConstants.defaultExpenseCategories,
          'income' => AppConstants.defaultIncomeCategories,
          _ => AppConstants.defaultTransferCategories,
        };
        for (var i = 0; i < defaults.length; i++) {
          seeds.add(
            CategoryModel(
              id: uuid.v4(),
              userId: userId,
              name: defaults[i],
              type: type,
              sortOrder: i,
              createdAt: now,
              updatedAt: now,
            ),
          );
        }
      }

      final map = {for (final m in seeds) m.id: m};
      await _box.putAll(map);
      return const Right(null);
    } on HiveError catch (e) {
      return Left(Failure.local(e.message));
    }
  }

  Stream<Either<Failure, List<CategoryModel>>> watchCategories(
    String userId, {
    String? type,
  }) {
    return Stream.multi((controller) {
      Either<Failure, List<CategoryModel>> snap() {
        try {
          final results = _box.values
              .where(
                (c) =>
                    c.userId == userId && (type == null || c.type == type),
              )
              .toList()
            ..sort((a, b) => a.sortOrder.compareTo(b.sortOrder));
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
