import 'package:dartz/dartz.dart';
import 'package:spend_analytics/core/error/failures.dart';
import 'package:spend_analytics/features/rules/domain/entities/rule_entity.dart';

abstract interface class IRulesRepository {
  Future<Either<Failure, List<RuleEntity>>> getRules(String userId);
  Future<Either<Failure, List<RuleEntity>>> getActiveRules(String userId);
  Stream<Either<Failure, List<RuleEntity>>> watchRules(String userId);
  Future<Either<Failure, void>> addRule(RuleEntity rule);
  Future<Either<Failure, void>> updateRule(RuleEntity rule);
  Future<Either<Failure, void>> deleteRule(String id, String userId);
  Future<Either<Failure, void>> toggleRule(
    String id,
    String userId, {
    required bool isActive,
  });
}
