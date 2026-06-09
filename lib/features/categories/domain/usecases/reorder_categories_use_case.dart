import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:spend_analytics/core/error/failures.dart';
import 'package:spend_analytics/features/categories/domain/entities/category_entity.dart';
import 'package:spend_analytics/features/categories/domain/repositories/i_category_repository.dart';

@injectable
class ReorderCategoriesUseCase {
  const ReorderCategoriesUseCase(this._repo);
  final ICategoryRepository _repo;

  Future<Either<Failure, void>> call(List<CategoryEntity> categories) =>
      _repo.reorderCategories(categories);
}
