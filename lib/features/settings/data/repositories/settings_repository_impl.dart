import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:spend_analytics/core/error/failures.dart';
import 'package:spend_analytics/features/settings/data/datasources/local/settings_local_datasource.dart';
import 'package:spend_analytics/features/settings/data/models/settings_model.dart';
import 'package:spend_analytics/features/settings/domain/entities/settings_entity.dart';
import 'package:spend_analytics/features/settings/domain/repositories/i_settings_repository.dart';

@LazySingleton(as: ISettingsRepository)
class SettingsRepositoryImpl implements ISettingsRepository {
  const SettingsRepositoryImpl(this._local);

  final SettingsLocalDataSource _local;

  @override
  Future<Either<Failure, SettingsEntity>> getSettings(String userId) async {
    final result = await _local.getSettings(userId);
    return result.map((m) => m.toEntity());
  }

  @override
  Future<Either<Failure, void>> updateSettings(
    String userId,
    SettingsEntity settings,
  ) async {
    final model = SettingsModel.fromEntity(settings);
    return _local.saveSettings(userId, model);
  }

  @override
  Future<Either<Failure, void>> clearAllData(String userId) async {
    return _local.saveSettings(userId, SettingsModel());
  }
}
