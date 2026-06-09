import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:spend_analytics/core/error/failures.dart';
import 'package:spend_analytics/features/categories/domain/repositories/i_category_repository.dart';

@injectable
class SyncCategoriesUseCase {
  const SyncCategoriesUseCase(this._repo);
  final ICategoryRepository _repo;

  /// Seeds default categories for [userId] if none exist yet.
  Future<Either<Failure, void>> call(String userId) async {
    final existing = await _repo.getCategories(userId);
    if (existing.isLeft()) return existing.map((_) => null);

    if (existing.getOrElse(() => []).isNotEmpty) return const Right(null);

    return _repo.seedDefaults(userId);
  }
}
