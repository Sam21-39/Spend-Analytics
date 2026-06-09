import 'package:dartz/dartz.dart';
import 'package:hive_ce/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:spend_analytics/core/constants/hive_box_names.dart';
import 'package:spend_analytics/core/error/failures.dart';
import 'package:spend_analytics/features/rules/data/models/rule_model.dart';

@lazySingleton
class RulesLocalDataSource {
  Box<RuleModel> get _box => Hive.box<RuleModel>(HiveBoxNames.rules);

  Future<Either<Failure, void>> saveRule(RuleModel model) async {
    try {
      await _box.put(model.id, model);
      return const Right(null);
    } on HiveError catch (e) {
      return Left(Failure.local(e.message));
    }
  }

  Future<Either<Failure, void>> deleteRule(String id, String userId) async {
    try {
      final model = _box.get(id);
      if (model == null) return const Right(null);
      model.isDeleted = true;
      await _box.put(id, model);
      return const Right(null);
    } on HiveError catch (e) {
      return Left(Failure.local(e.message));
    }
  }

  Future<Either<Failure, List<RuleModel>>> getRules(String userId) async {
    try {
      final results = _box.values
          .where((r) => r.userId == userId && !r.isDeleted)
          .toList()
        ..sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
      return Right(results);
    } on HiveError catch (e) {
      return Left(Failure.local(e.message));
    }
  }

  Stream<Either<Failure, List<RuleModel>>> watchRules(String userId) {
    return Stream.multi((controller) {
      Either<Failure, List<RuleModel>> snap() {
        try {
          final results = _box.values
              .where((r) => r.userId == userId && !r.isDeleted)
              .toList()
            ..sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
          return Right(results);
        } on HiveError catch (e) {
          return Left(Failure.local(e.message));
        }
      }

      controller.add(snap());
      final sub = _box.watch().listen((_) => controller.add(snap()));
      controller.onCancel = sub.cancel;
    });
  }
}
