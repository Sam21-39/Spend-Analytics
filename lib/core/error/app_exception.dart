import 'failures.dart';

class AppException implements Exception {
  const AppException(this.message, {this.cause});

  final String message;
  final Object? cause;

  Failure toFailure() => Failure.unknown(message, cause: cause);

  @override
  String toString() => 'AppException($message)${cause != null ? ': $cause' : ''}';
}

class LocalStorageException extends AppException {
  const LocalStorageException(super.message, {super.cause});

  @override
  Failure toFailure() => Failure.local(message);
}

class NetworkException extends AppException {
  const NetworkException(super.message, {super.cause, this.statusCode});

  final int? statusCode;

  @override
  Failure toFailure() => Failure.network(message, statusCode: statusCode);
}

class AuthException extends AppException {
  const AuthException(super.message, {super.cause});

  @override
  Failure toFailure() => Failure.auth(message);
}

class MigrationException extends AppException {
  const MigrationException(super.message, {super.cause});

  @override
  Failure toFailure() => Failure.migration(message, cause: cause);
}
