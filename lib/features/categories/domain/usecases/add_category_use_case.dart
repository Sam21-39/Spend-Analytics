import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:spend_analytics/core/error/failures.dart';
import 'package:spend_analytics/features/categories/domain/entities/category_entity.dart';
import 'package:spend_analytics/features/categories/domain/repositories/i_category_repository.dart';

@injectable
class AddCategoryUseCase {
  const AddCategoryUseCase(this._repo);
  final ICategoryRepository _repo;

  Future<Either<Failure, void>> call(CategoryEntity category) async {
    if (category.name.trim().isEmpty) {
      return Left(Failure.validation('Category name cannot be empty'));
    }
    return _repo.addCategory(category);
  }
}
