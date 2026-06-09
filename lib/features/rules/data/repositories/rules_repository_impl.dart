import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:spend_analytics/core/error/failures.dart';
import 'package:spend_analytics/core/services/sync_service.dart';
import 'package:spend_analytics/features/rules/data/datasources/local/rules_local_datasource.dart';
import 'package:spend_analytics/features/rules/data/models/rule_model.dart';
import 'package:spend_analytics/features/rules/domain/entities/rule_entity.dart';
import 'package:spend_analytics/features/rules/domain/repositories/i_rules_repository.dart';

@LazySingleton(as: IRulesRepository)
class RulesRepositoryImpl implements IRulesRepository {
  const RulesRepositoryImpl(this._local, this._sync);

  final RulesLocalDataSource _local;
  final SyncService _sync;

  @override
  Future<Either<Failure, List<RuleEntity>>> getRules(String userId) async {
    final result = await _local.getRules(userId);
    return result.map((models) => models.map((m) => m.toEntity()).toList());
  }

  @override
  Future<Either<Failure, List<RuleEntity>>> getActiveRules(
    String userId,
  ) async {
    final result = await _local.getRules(userId);
    return result.map(
      (models) => models
          .where((m) => m.isActive)
          .map((m) => m.toEntity())
          .toList(),
    );
  }

  @override
  Stream<Either<Failure, List<RuleEntity>>> watchRules(String userId) {
    return _local
        .watchRules(userId)
        .map((r) => r.map((models) => models.map((m) => m.toEntity()).toList()));
  }

  @override
  Future<Either<Failure, void>> addRule(RuleEntity rule) async {
    final model = RuleModel.fromEntity(rule);
    final result = await _local.saveRule(model);
    if (result.isLeft()) return result;
    await _sync.enqueueUpsert(
      entityType: 'rules',
      entityId: model.id,
      userId: model.userId,
      payload: model.toFirestoreMap(),
    );
    return const Right(null);
  }

  @override
  Future<Either<Failure, void>> updateRule(RuleEntity rule) => addRule(rule);

  @override
  Future<Either<Failure, void>> deleteRule(String id, String userId) async {
    final result = await _local.deleteRule(id, userId);
    if (result.isLeft()) return result;
    await _sync.enqueueDelete(
      entityType: 'rules',
      entityId: id,
      userId: userId,
    );
    return const Right(null);
  }

  @override
  Future<Either<Failure, void>> toggleRule(
    String id,
    String userId, {
    required bool isActive,
  }) async {
    final rules = await _local.getRules(userId);
    return rules.fold(
      Left.new,
      (models) async {
        final model = models.firstWhere(
          (m) => m.id == id,
          orElse: () => throw StateError('Rule $id not found'),
        );
        model.isActive = isActive;
        model.updatedAt = DateTime.now().toUtc();
        final result = await _local.saveRule(model);
        if (result.isLeft()) return result;
        await _sync.enqueueUpsert(
          entityType: 'rules',
          entityId: id,
          userId: userId,
          payload: model.toFirestoreMap(),
        );
        return const Right(null);
      },
    );
  }
}
