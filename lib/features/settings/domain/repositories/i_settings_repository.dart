import 'package:dartz/dartz.dart';
import 'package:spend_analytics/core/error/failures.dart';
import 'package:spend_analytics/features/settings/domain/entities/settings_entity.dart';

abstract interface class ISettingsRepository {
  Future<Either<Failure, SettingsEntity>> getSettings(String userId);
  Future<Either<Failure, void>> updateSettings(
    String userId,
    SettingsEntity settings,
  );
  Future<Either<Failure, void>> clearAllData(String userId);
}
