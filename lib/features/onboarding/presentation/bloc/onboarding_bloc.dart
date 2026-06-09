import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:spend_analytics/features/budget/domain/usecases/seed_default_budgets_use_case.dart';
import 'package:spend_analytics/features/settings/domain/usecases/get_settings_use_case.dart';
import 'package:spend_analytics/features/settings/domain/usecases/update_settings_use_case.dart';

import 'onboarding_event.dart';
import 'onboarding_state.dart';

@injectable
class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  OnboardingBloc(
    this._getSettings,
    this._updateSettings,
    this._seedDefaults,
  ) : super(const OnboardingState()) {
    on<OnboardingNextStep>(_onNextStep);
    on<OnboardingSkip>(_onSkip);
    on<OnboardingComplete>(_onComplete);
  }

  final GetSettingsUseCase _getSettings;
  final UpdateSettingsUseCase _updateSettings;
  final SeedDefaultBudgetsUseCase _seedDefaults;

  void _onNextStep(OnboardingNextStep event, Emitter<OnboardingState> emit) {
    final next = state.step + 1;
    if (next < state.totalSteps) {
      emit(state.copyWith(step: next));
    }
  }

  void _onSkip(OnboardingSkip event, Emitter<OnboardingState> emit) {
    emit(state.copyWith(isComplete: true));
  }

  Future<void> _onComplete(
      OnboardingComplete event, Emitter<OnboardingState> emit) async {
    emit(state.copyWith(isCompleting: true));
    final now = DateTime.now();
    await _seedDefaults(
      userId: event.userId,
      month: now.month,
      year: now.year,
    );
    final settingsResult = await _getSettings(event.userId);
    await settingsResult.fold(
      (_) async {},
      (settings) async => _updateSettings(
        userId: event.userId,
        settings: settings.copyWith(
          hasCompletedOnboarding: true,
          privacyAccepted: true,
        ),
      ),
    );
    emit(state.copyWith(isCompleting: false, isComplete: true));
  }
}
