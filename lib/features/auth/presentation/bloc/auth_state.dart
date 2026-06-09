import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:spend_analytics/core/error/failures.dart';
import 'package:spend_analytics/features/auth/domain/entities/user_entity.dart';

part 'auth_state.freezed.dart';

@freezed
sealed class AuthState with _$AuthState {
  const factory AuthState.initial() = AuthInitial;
  const factory AuthState.loading() = AuthLoading;
  const factory AuthState.anonymous({required String uid}) = AuthAnonymous;
  const factory AuthState.authenticated({required UserEntity user}) =
      AuthAuthenticated;
  const factory AuthState.unauthenticated() = AuthUnauthenticated;
  const factory AuthState.failure({required Failure failure}) = AuthFailureState;
}
