import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:spend_analytics/core/error/failures.dart';

part 'biometric_state.freezed.dart';

@freezed
sealed class BiometricState with _$BiometricState {
  const factory BiometricState.unlocked() = BiometricUnlocked;
  const factory BiometricState.locked() = BiometricLocked;
  const factory BiometricState.unlocking() = BiometricUnlocking;
  const factory BiometricState.error({required Failure failure}) =
      BiometricError;
}
