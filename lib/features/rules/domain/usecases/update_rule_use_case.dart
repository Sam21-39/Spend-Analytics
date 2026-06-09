import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:spend_analytics/core/error/failures.dart';
import 'package:spend_analytics/features/rules/domain/entities/rule_entity.dart';
import 'package:spend_analytics/features/rules/domain/repositories/i_rules_repository.dart';

@injectable
class UpdateRuleUseCase {
  const UpdateRuleUseCase(this._repo);
  final IRulesRepository _repo;

  Future<Either<Failure, void>> call(RuleEntity rule) =>
      _repo.updateRule(rule);
}
