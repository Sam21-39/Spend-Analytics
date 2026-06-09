import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';
import 'package:spend_analytics/core/constants/app_constants.dart';
import 'package:spend_analytics/core/error/failures.dart';
import 'package:spend_analytics/features/budget/domain/entities/budget_entity.dart';
import 'package:spend_analytics/features/budget/domain/repositories/i_budget_repository.dart';

@injectable
class SeedDefaultBudgetsUseCase {
  const SeedDefaultBudgetsUseCase(this._repo);
  final IBudgetRepository _repo;
  static const _uuid = Uuid();

  /// Seeds AppConstants.defaultBudgets for [userId] in the given month/year.
  /// Skips if budgets already exist for that period.
  Future<Either<Failure, void>> call({
    required String userId,
    required int month,
    required int year,
  }) async {
    final existing = await _repo.getBudgetsForMonth(
      userId: userId,
      month: month,
      year: year,
    );
    if (existing.isLeft()) return existing.map((_) => null);

    if (existing.getOrElse(() => []).isNotEmpty) return const Right(null);

    final now = DateTime.now().toUtc();
    for (final seed in AppConstants.defaultBudgets) {
      final budget = BudgetEntity(
        id: _uuid.v4(),
        userId: userId,
        category: seed.category,
        limitAmount: seed.amountInr,
        month: month,
        year: year,
        createdAt: now,
        updatedAt: now,
      );
      final result = await _repo.upsertBudget(budget);
      if (result.isLeft()) return result;
    }
    return const Right(null);
  }
}
