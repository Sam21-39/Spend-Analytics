import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:spend_analytics/core/constants/app_constants.dart';
import 'package:spend_analytics/core/error/failures.dart';
import 'package:spend_analytics/features/rules/domain/entities/rule_entity.dart';
import 'package:spend_analytics/features/rules/domain/repositories/i_rules_repository.dart';

@injectable
class CreateRuleUseCase {
  const CreateRuleUseCase(this._repo);
  final IRulesRepository _repo;

  Future<Either<Failure, void>> call(RuleEntity rule) async {
    final existing = await _repo.getRules(rule.userId);
    if (existing.isLeft()) return existing.map((_) => null);

    final activeCount = existing
        .getOrElse(() => [])
        .where((r) => r.isActive && !r.isDeleted)
        .length;
    if (activeCount >= AppConstants.maxFreeRules) {
      return Left(
        Failure.permission(
          'Free tier allows up to ${AppConstants.maxFreeRules} active rules. '
          'Upgrade to Premium for unlimited rules.',
        ),
      );
    }
    return _repo.addRule(rule);
  }
}
