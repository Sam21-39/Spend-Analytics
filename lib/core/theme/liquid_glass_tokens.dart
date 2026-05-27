import 'package:flutter/material.dart';

// ─── Geometry Tokens ──────────────────────────────────────────────────────────

/// Shared border-radius scale used across every component in Spend Analytics.
abstract final class SARadius {
  static const BorderRadius xs   = BorderRadius.all(Radius.circular(10));
  static const BorderRadius sm   = BorderRadius.all(Radius.circular(14));
  static const BorderRadius md   = BorderRadius.all(Radius.circular(20));
  static const BorderRadius lg   = BorderRadius.all(Radius.circular(24));
  static const BorderRadius xl   = BorderRadius.all(Radius.circular(28));
  static const BorderRadius full = BorderRadius.all(Radius.circular(999));
}

/// Animation durations and curves.
abstract final class SAAnimation {
  static const Duration fast     = Duration(milliseconds: 160);
  static const Duration standard = Duration(milliseconds: 260);
  static const Duration slow     = Duration(milliseconds: 400);
  static const Curve    spring   = Curves.easeOutCubic;
  static const Curve    ease     = Curves.easeInOut;
}

// ─── Glass Rendering Parameters ───────────────────────────────────────────────

/// Glass surface constants — consumed by [LiquidGlassSurface].
/// These are defaults; individual surfaces may override them.
abstract final class SAGlass {
  /// White fill opacity for dark-mode panels.
  static const double darkFillOpacity    = 0.09;

  /// White fill opacity for light-mode panels (much higher — classic iOS frosted).
  static const double lightFillOpacity   = 0.64;

  static const double darkBorderOpacity  = 0.15;
  static const double lightBorderOpacity = 0.09;

  /// Default backdrop blur sigma (applied symmetrically on X and Y).
  static const double blurSigma = 26.0;
}

// ─── Dark Mode Palette ────────────────────────────────────────────────────────

/// Dark-mode design tokens.
abstract final class SADark {
  // ── Backgrounds ─────────────────────────────────────────────────────────────
  static const Color background              = Color(0xFF080A10);
  static const Color surface                 = Color(0xFF0E1018);
  static const Color surfaceContainer        = Color(0xFF181A26);
  static const Color surfaceContainerHigh    = Color(0xFF22263C);
  static const Color surfaceContainerHighest = Color(0xFF2C3050);

  // ── Background glow orbs ────────────────────────────────────────────────────
  static const Color glowBlue   = Color.fromRGBO( 80, 158, 255, 0.22);
  static const Color glowPurple = Color.fromRGBO(130,  95, 255, 0.16);
  static const Color glowMint   = Color.fromRGBO( 55, 220, 150, 0.16);

  // ── Primary ─────────────────────────────────────────────────────────────────
  static const Color primary              = Color(0xFF5B9FFF);
  static const Color onPrimary            = Color(0xFF001843);
  static const Color primaryContainer     = Color(0xFF0A3A7A);
  static const Color onPrimaryContainer   = Color(0xFFB0D0FF);

  // ── Secondary ───────────────────────────────────────────────────────────────
  static const Color secondary            = Color(0xFFB0A0FF);
  static const Color onSecondary          = Color(0xFF20006E);
  static const Color secondaryContainer   = Color(0xFF3A1890);
  static const Color onSecondaryContainer = Color(0xFFE2D9FF);

  // ── Tertiary ────────────────────────────────────────────────────────────────
  static const Color tertiary             = Color(0xFF3FDDA0);
  static const Color onTertiary           = Color(0xFF003826);
  static const Color tertiaryContainer    = Color(0xFF00552A);
  static const Color onTertiaryContainer  = Color(0xFFB5F5D8);

  // ── Error ───────────────────────────────────────────────────────────────────
  static const Color error                = Color(0xFFFF6B6B);
  static const Color onError              = Color(0xFF600000);
  static const Color errorContainer       = Color(0xFF8B0000);
  static const Color onErrorContainer     = Color(0xFFFFDAD6);

  // ── Text / Icon ─────────────────────────────────────────────────────────────
  static const Color onSurface        = Color(0xFFEEF0F8);
  static const Color onSurfaceVariant = Color(0xFF8890AA);
  static const Color outline          = Color(0xFF3E4460);
  static const Color outlineVariant   = Color(0xFF282C42);

  // ── Semantic ────────────────────────────────────────────────────────────────
  static const Color success = Color(0xFF3FDDA0);
  static const Color warning = Color(0xFFFFB860);
  static const Color info    = Color(0xFF5B9FFF);
}

// ─── Light Mode Palette ───────────────────────────────────────────────────────

/// Light-mode design tokens.
abstract final class SALight {
  // ── Backgrounds ─────────────────────────────────────────────────────────────
  static const Color background              = Color(0xFFEDF0FA);
  static const Color surface                 = Color(0xFFF4F6FE);
  static const Color surfaceContainer        = Color(0xFFE6EAF8);
  static const Color surfaceContainerHigh    = Color(0xFFDADFF2);
  static const Color surfaceContainerHighest = Color(0xFFCED4EC);

  // ── Background glow orbs (softer pastel tones for light mode) ───────────────
  static const Color glowBlue   = Color.fromRGBO( 26, 111, 255, 0.13);
  static const Color glowPurple = Color.fromRGBO(123,  87, 255, 0.09);
  static const Color glowMint   = Color.fromRGBO(  0, 184, 130, 0.09);

  // ── Primary ─────────────────────────────────────────────────────────────────
  static const Color primary              = Color(0xFF1A6FFF);
  static const Color onPrimary            = Color(0xFFFFFFFF);
  static const Color primaryContainer     = Color(0xFFD4E7FF);
  static const Color onPrimaryContainer   = Color(0xFF002E7A);

  // ── Secondary ───────────────────────────────────────────────────────────────
  static const Color secondary            = Color(0xFF7B57FF);
  static const Color onSecondary          = Color(0xFFFFFFFF);
  static const Color secondaryContainer   = Color(0xFFE8E1FF);
  static const Color onSecondaryContainer = Color(0xFF30008A);

  // ── Tertiary ────────────────────────────────────────────────────────────────
  static const Color tertiary             = Color(0xFF00B882);
  static const Color onTertiary           = Color(0xFFFFFFFF);
  static const Color tertiaryContainer    = Color(0xFFCCF4E6);
  static const Color onTertiaryContainer  = Color(0xFF003826);

  // ── Error ───────────────────────────────────────────────────────────────────
  static const Color error                = Color(0xFFD32F2F);
  static const Color onError              = Color(0xFFFFFFFF);
  static const Color errorContainer       = Color(0xFFFFDAD6);
  static const Color onErrorContainer     = Color(0xFF680000);

  // ── Text / Icon ─────────────────────────────────────────────────────────────
  static const Color onSurface        = Color(0xFF0D0F1C);
  static const Color onSurfaceVariant = Color(0xFF565C7A);
  static const Color outline          = Color(0xFFB0B6D0);
  static const Color outlineVariant   = Color(0xFFD8DCF0);

  // ── Semantic ────────────────────────────────────────────────────────────────
  static const Color success = Color(0xFF00A86B);
  static const Color warning = Color(0xFFE67E00);
  static const Color info    = Color(0xFF1A6FFF);
}
