import 'package:freezed_annotation/freezed_annotation.dart';

part 'onboarding_event.freezed.dart';

@freezed
sealed class OnboardingEvent with _$OnboardingEvent {
  const factory OnboardingEvent.nextStep() = OnboardingNextStep;
  const factory OnboardingEvent.skip() = OnboardingSkip;
  const factory OnboardingEvent.complete({required String userId}) =
      OnboardingComplete;
}
