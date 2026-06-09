import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:spend_analytics/features/settings/domain/repositories/i_settings_repository.dart';

import 'theme_state.dart';

@lazySingleton
class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit(this._settingsRepo) : super(const ThemeState());

  final ISettingsRepository _settingsRepo;

  Future<void> load(String userId) async {
    final result = await _settingsRepo.getSettings(userId);
    result.fold(
      (_) {},
      (settings) => emit(ThemeState(mode: settings.themeMode)),
    );
  }

  Future<void> setTheme(ThemeMode mode, String userId) async {
    emit(ThemeState(mode: mode));
    final current = await _settingsRepo.getSettings(userId);
    current.fold(
      (_) {},
      (settings) => _settingsRepo.updateSettings(
        userId,
        settings.copyWith(themeMode: mode),
      ),
    );
  }
}
