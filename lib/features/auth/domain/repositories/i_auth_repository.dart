import 'package:dartz/dartz.dart';
import 'package:spend_analytics/core/error/failures.dart';
import 'package:spend_analytics/features/auth/domain/entities/user_entity.dart';

abstract interface class IAuthRepository {
  Stream<UserEntity?> watchAuthState();
  Future<Either<Failure, UserEntity>> signInWithGoogle();
  Future<Either<Failure, UserEntity>> signInAnonymously();
  Future<Either<Failure, UserEntity>> linkGoogleAccount();
  Future<Either<Failure, void>> signOut();
  UserEntity? get currentUser;
}
