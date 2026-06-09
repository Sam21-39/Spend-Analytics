import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:spend_analytics/core/error/failures.dart';
import 'package:spend_analytics/features/auth/domain/entities/user_entity.dart';
import 'package:spend_analytics/features/auth/domain/repositories/i_auth_repository.dart';

@injectable
class LinkGoogleAccountUseCase {
  const LinkGoogleAccountUseCase(this._repo);
  final IAuthRepository _repo;

  Future<Either<Failure, UserEntity>> call() => _repo.linkGoogleAccount();
}
