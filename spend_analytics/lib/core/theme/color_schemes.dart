import 'package:flutter/material.dart';

class AppColors {
  static const primary = Color(0xFF1A73E8);
  static const accent = Color(0xFF00C48C);
  static const warning = Color(0xFFFF6B35);
  static const lightSurface = Color(0xFFF8F9FE);
  static const darkSurface = Color(0xFF0F1117);
}

ColorScheme lightColorScheme() {
  return ColorScheme.fromSeed(
    seedColor: AppColors.primary,
    brightness: Brightness.light,
    surface: AppColors.lightSurface,
    secondary: AppColors.accent,
    error: AppColors.warning,
  );
}

ColorScheme darkColorScheme() {
  return ColorScheme.fromSeed(
    seedColor: AppColors.primary,
    brightness: Brightness.dark,
    surface: AppColors.darkSurface,
    secondary: AppColors.accent,
    error: AppColors.warning,
  );
}
