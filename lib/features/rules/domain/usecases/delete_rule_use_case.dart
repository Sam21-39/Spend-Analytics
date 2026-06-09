import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:spend_analytics/core/error/failures.dart';
import 'package:spend_analytics/features/rules/domain/repositories/i_rules_repository.dart';

@injectable
class DeleteRuleUseCase {
  const DeleteRuleUseCase(this._repo);
  final IRulesRepository _repo;

  Future<Either<Failure, void>> call({
    required String id,
    required String userId,
  }) =>
      _repo.deleteRule(id, userId);
}
