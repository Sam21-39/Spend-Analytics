import 'package:flutter/material.dart';
import 'package:spend_analytics/core/theme/liquid_glass_tokens.dart';

ColorScheme lightColorScheme() {
  return const ColorScheme(
    brightness: Brightness.light,
    primary: LiquidGlassColors.primary,
    onPrimary: Color(0xFF002E69),
    secondary: LiquidGlassColors.secondary,
    onSecondary: Color(0xFF680019),
    error: LiquidGlassColors.error,
    onError: Color(0xFF690005),
    surface: LiquidGlassColors.surface,
    onSurface: LiquidGlassColors.onSurface,
    surfaceContainerHighest: LiquidGlassColors.surfaceContainerHighest,
    onSurfaceVariant: LiquidGlassColors.onSurfaceVariant,
    outline: LiquidGlassColors.outline,
  );
}

ColorScheme darkColorScheme() {
  return const ColorScheme(
    brightness: Brightness.dark,
    primary: LiquidGlassColors.primary,
    onPrimary: Color(0xFF002E69),
    secondary: LiquidGlassColors.secondary,
    onSecondary: Color(0xFF680019),
    error: LiquidGlassColors.error,
    onError: Color(0xFF690005),
    surface: LiquidGlassColors.surface,
    onSurface: LiquidGlassColors.onSurface,
    surfaceContainerHighest: LiquidGlassColors.surfaceContainerHighest,
    onSurfaceVariant: LiquidGlassColors.onSurfaceVariant,
    outline: LiquidGlassColors.outline,
  );
}
