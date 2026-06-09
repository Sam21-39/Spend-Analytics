import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:spend_analytics/core/error/failures.dart';
import 'package:spend_analytics/features/rules/domain/entities/rule_entity.dart';
import 'package:spend_analytics/features/rules/domain/repositories/i_rules_repository.dart';

@injectable
class LoadRulesUseCase {
  const LoadRulesUseCase(this._repo);
  final IRulesRepository _repo;

  Future<Either<Failure, List<RuleEntity>>> call(String userId) =>
      _repo.getRules(userId);
}
