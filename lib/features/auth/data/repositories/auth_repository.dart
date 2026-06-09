import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:spend_analytics/core/error/failures.dart';
import 'package:spend_analytics/features/auth/domain/entities/user_entity.dart';
import 'package:spend_analytics/features/auth/domain/repositories/i_auth_repository.dart';

// TODO(Phase 6): Replace with full Firebase Auth implementation.
@LazySingleton(as: IAuthRepository)
class AuthRepository implements IAuthRepository {
  @override
  Stream<UserEntity?> watchAuthState() => const Stream.empty();

  @override
  Future<Either<Failure, UserEntity>> signInWithGoogle() async =>
      Left(const Failure.auth('Not implemented'));

  @override
  Future<Either<Failure, UserEntity>> signInAnonymously() async =>
      Left(const Failure.auth('Not implemented'));

  @override
  Future<Either<Failure, UserEntity>> linkGoogleAccount() async =>
      Left(const Failure.auth('Not implemented'));

  @override
  Future<Either<Failure, void>> signOut() async =>
      Left(const Failure.auth('Not implemented'));

  @override
  UserEntity? get currentUser => null;
}
