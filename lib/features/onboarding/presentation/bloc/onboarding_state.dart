import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:spend_analytics/core/error/failures.dart';

part 'onboarding_state.freezed.dart';

@freezed
abstract class OnboardingState with _$OnboardingState {
  const factory OnboardingState({
    @Default(0) int step,
    @Default(4) int totalSteps,
    @Default(false) bool isCompleting,
    @Default(false) bool isComplete,
    Failure? failure,
  }) = _OnboardingState;
}
