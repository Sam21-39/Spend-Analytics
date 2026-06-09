import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:spend_analytics/core/error/failures.dart';
import 'package:spend_analytics/features/auth/domain/repositories/i_auth_repository.dart';

@injectable
class SignOutUseCase {
  const SignOutUseCase(this._repo);
  final IAuthRepository _repo;

  Future<Either<Failure, void>> call() => _repo.signOut();
}
