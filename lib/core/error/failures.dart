import 'package:freezed_annotation/freezed_annotation.dart';

part 'failures.freezed.dart';

@freezed
sealed class Failure with _$Failure {
  const factory Failure.local(String message) = LocalFailure;
  const factory Failure.network(String message, {int? statusCode}) = NetworkFailure;
  const factory Failure.auth(String message) = AuthFailure;
  const factory Failure.permission(String message) = PermissionFailure;
  const factory Failure.notFound(String message) = NotFoundFailure;
  const factory Failure.validation(String message) = ValidationFailure;
  const factory Failure.payment(String message) = PaymentFailure;
  const factory Failure.migration(String message, {@Default(null) Object? cause}) = MigrationFailure;
  const factory Failure.unknown(String message, {@Default(null) Object? cause}) = UnknownFailure;
}
