import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:spend_analytics/core/error/failures.dart';
import 'package:spend_analytics/features/settings/domain/repositories/i_settings_repository.dart';

@injectable
class ClearDataUseCase {
  const ClearDataUseCase(this._repo);
  final ISettingsRepository _repo;

  Future<Either<Failure, void>> call(String userId) =>
      _repo.clearAllData(userId);
}
