import 'package:flutter/material.dart';
import 'package:spend_analytics/core/theme/liquid_glass_tokens.dart';

/// Light color scheme — bright, high-contrast iOS-style palette.
ColorScheme lightColorScheme() => const ColorScheme(
  brightness: Brightness.light,

  // Surfaces
  surface:                 SALight.surface,
  onSurface:               SALight.onSurface,
  surfaceContainerHighest: SALight.surfaceContainerHighest,
  onSurfaceVariant:        SALight.onSurfaceVariant,

  // Primary
  primary:            SALight.primary,
  onPrimary:          SALight.onPrimary,
  primaryContainer:   SALight.primaryContainer,
  onPrimaryContainer: SALight.onPrimaryContainer,

  // Secondary
  secondary:            SALight.secondary,
  onSecondary:          SALight.onSecondary,
  secondaryContainer:   SALight.secondaryContainer,
  onSecondaryContainer: SALight.onSecondaryContainer,

  // Tertiary
  tertiary:             SALight.tertiary,
  onTertiary:           SALight.onTertiary,
  tertiaryContainer:    SALight.tertiaryContainer,
  onTertiaryContainer:  SALight.onTertiaryContainer,

  // Error
  error:                SALight.error,
  onError:              SALight.onError,
  errorContainer:       SALight.errorContainer,
  onErrorContainer:     SALight.onErrorContainer,

  // Borders
  outline:        SALight.outline,
  outlineVariant: SALight.outlineVariant,
);

/// Dark color scheme — deep, electric, iOS-inspired dark palette.
ColorScheme darkColorScheme() => const ColorScheme(
  brightness: Brightness.dark,

  // Surfaces
  surface:                 SADark.surface,
  onSurface:               SADark.onSurface,
  surfaceContainerHighest: SADark.surfaceContainerHighest,
  onSurfaceVariant:        SADark.onSurfaceVariant,

  // Primary
  primary:            SADark.primary,
  onPrimary:          SADark.onPrimary,
  primaryContainer:   SADark.primaryContainer,
  onPrimaryContainer: SADark.onPrimaryContainer,

  // Secondary
  secondary:            SADark.secondary,
  onSecondary:          SADark.onSecondary,
  secondaryContainer:   SADark.secondaryContainer,
  onSecondaryContainer: SADark.onSecondaryContainer,

  // Tertiary
  tertiary:             SADark.tertiary,
  onTertiary:           SADark.onTertiary,
  tertiaryContainer:    SADark.tertiaryContainer,
  onTertiaryContainer:  SADark.onTertiaryContainer,

  // Error
  error:                SADark.error,
  onError:              SADark.onError,
  errorContainer:       SADark.errorContainer,
  onErrorContainer:     SADark.onErrorContainer,

  // Borders
  outline:        SADark.outline,
  outlineVariant: SADark.outlineVariant,
);
