import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:spend_analytics/core/error/failures.dart';
import 'package:spend_analytics/features/settings/domain/entities/settings_entity.dart';
import 'package:spend_analytics/features/settings/domain/repositories/i_settings_repository.dart';

@injectable
class GetSettingsUseCase {
  const GetSettingsUseCase(this._repo);
  final ISettingsRepository _repo;

  Future<Either<Failure, SettingsEntity>> call(String userId) =>
      _repo.getSettings(userId);
}
