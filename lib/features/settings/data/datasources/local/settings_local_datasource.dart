import 'package:dartz/dartz.dart';
import 'package:hive_ce/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:spend_analytics/core/constants/hive_box_names.dart';
import 'package:spend_analytics/core/error/failures.dart';
import 'package:spend_analytics/features/settings/data/models/settings_model.dart';

@lazySingleton
class SettingsLocalDataSource {
  Box<SettingsModel> get _box =>
      Hive.box<SettingsModel>(HiveBoxNames.settings);

  Future<Either<Failure, SettingsModel>> getSettings(String userId) async {
    try {
      final model = _box.get(userId) ?? SettingsModel();
      return Right(model);
    } on HiveError catch (e) {
      return Left(Failure.local(e.message));
    }
  }

  Future<Either<Failure, void>> saveSettings(
    String userId,
    SettingsModel model,
  ) async {
    try {
      await _box.put(userId, model);
      return const Right(null);
    } on HiveError catch (e) {
      return Left(Failure.local(e.message));
    }
  }
}
