import 'package:dartz/dartz.dart';
import 'package:spend_analytics/core/error/failures.dart';
import 'package:spend_analytics/features/categories/domain/entities/category_entity.dart';

abstract interface class ICategoryRepository {
  Future<Either<Failure, List<CategoryEntity>>> getCategories(
    String userId, {
    String? type,
  });
  Stream<Either<Failure, List<CategoryEntity>>> watchCategories(
    String userId, {
    String? type,
  });
  Future<Either<Failure, void>> addCategory(CategoryEntity category);
  Future<Either<Failure, void>> reorderCategories(
    List<CategoryEntity> categories,
  );
  Future<Either<Failure, void>> seedDefaults(String userId);
}
