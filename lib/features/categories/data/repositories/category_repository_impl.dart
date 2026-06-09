import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:spend_analytics/core/error/failures.dart';
import 'package:spend_analytics/core/services/sync_service.dart';
import 'package:spend_analytics/features/categories/data/datasources/local/category_local_datasource.dart';
import 'package:spend_analytics/features/categories/data/models/category_model.dart';
import 'package:spend_analytics/features/categories/domain/entities/category_entity.dart';
import 'package:spend_analytics/features/categories/domain/repositories/i_category_repository.dart';
import 'package:uuid/uuid.dart';

@LazySingleton(as: ICategoryRepository)
class CategoryRepositoryImpl implements ICategoryRepository {
  const CategoryRepositoryImpl(this._local, this._sync);

  final CategoryLocalDataSource _local;
  final SyncService _sync;

  @override
  Future<Either<Failure, List<CategoryEntity>>> getCategories(
    String userId, {
    String? type,
  }) async {
    final result = await _local.getCategories(userId, type: type);
    return result.map((models) => models.map((m) => m.toEntity()).toList());
  }

  @override
  Stream<Either<Failure, List<CategoryEntity>>> watchCategories(
    String userId, {
    String? type,
  }) {
    return _local
        .watchCategories(userId, type: type)
        .map((r) => r.map((models) => models.map((m) => m.toEntity()).toList()));
  }

  @override
  Future<Either<Failure, void>> addCategory(CategoryEntity category) async {
    final model = CategoryModel.fromEntity(category);
    final result = await _local.saveCategory(model);
    if (result.isLeft()) return result;
    await _sync.enqueueUpsert(
      entityType: 'categories',
      entityId: model.id,
      userId: model.userId,
      payload: model.toFirestoreMap(),
    );
    return const Right(null);
  }

  @override
  Future<Either<Failure, void>> reorderCategories(
    List<CategoryEntity> categories,
  ) async {
    final now = DateTime.now().toUtc();
    final models = categories.asMap().entries.map((e) {
      final m = CategoryModel.fromEntity(e.value);
      return m..sortOrder = e.key..updatedAt = now;
    }).toList();

    final result = await _local.saveAll(models);
    if (result.isLeft()) return result;

    for (final m in models) {
      await _sync.enqueueUpsert(
        entityType: 'categories',
        entityId: m.id,
        userId: m.userId,
        payload: m.toFirestoreMap(),
      );
    }
    return const Right(null);
  }

  @override
  Future<Either<Failure, void>> seedDefaults(String userId) =>
      _local.seedDefaults(userId);

  // Migrates legacy SharedPreferences category order to Hive CE.
  Future<void> migrateFromPrefs(
    String userId,
    Map<String, List<String>> typeToNames,
  ) async {
    final existing = await _local.getCategories(userId);
    if (existing.isRight() &&
        (existing as Right).value.isNotEmpty) {
      return; // already migrated
    }

    final now = DateTime.now().toUtc();
    const uuid = Uuid();
    final models = <CategoryModel>[];

    for (final entry in typeToNames.entries) {
      for (var i = 0; i < entry.value.length; i++) {
        models.add(
          CategoryModel(
            id: uuid.v4(),
            userId: userId,
            name: entry.value[i],
            type: entry.key,
            sortOrder: i,
            createdAt: now,
            updatedAt: now,
          ),
        );
      }
    }

    await _local.saveAll(models);
  }
}
