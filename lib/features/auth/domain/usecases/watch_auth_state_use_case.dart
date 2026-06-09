import 'package:injectable/injectable.dart';
import 'package:spend_analytics/features/auth/domain/entities/user_entity.dart';
import 'package:spend_analytics/features/auth/domain/repositories/i_auth_repository.dart';

@injectable
class WatchAuthStateUseCase {
  const WatchAuthStateUseCase(this._repo);
  final IAuthRepository _repo;

  Stream<UserEntity?> call() => _repo.watchAuthState();
}
