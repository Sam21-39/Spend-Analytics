import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spend_analytics/core/theme/color_schemes.dart';
import 'package:spend_analytics/core/theme/liquid_glass_tokens.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get light => _build(lightColorScheme(), Brightness.light);
  static ThemeData get dark  => _build(darkColorScheme(),  Brightness.dark);

  static ThemeData _build(ColorScheme scheme, Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    final base   = GoogleFonts.interTextTheme();

    // ─── Typography ─────────────────────────────────────────────────────────
    final textTheme = base.copyWith(
      displayLarge:   base.displayLarge?.copyWith(fontWeight: FontWeight.w800, letterSpacing: -2.0),
      displayMedium:  base.displayMedium?.copyWith(fontWeight: FontWeight.w800, letterSpacing: -1.4),
      displaySmall:   base.displaySmall?.copyWith(fontWeight: FontWeight.w700, letterSpacing: -0.8),
      headlineLarge:  base.headlineLarge?.copyWith(fontWeight: FontWeight.w800, letterSpacing: -0.8),
      headlineMedium: base.headlineMedium?.copyWith(fontWeight: FontWeight.w700, letterSpacing: -0.5),
      headlineSmall:  base.headlineSmall?.copyWith(fontWeight: FontWeight.w700, letterSpacing: -0.3),
      titleLarge:     base.titleLarge?.copyWith(fontWeight: FontWeight.w700),
      titleMedium:    base.titleMedium?.copyWith(fontWeight: FontWeight.w600),
      titleSmall:     base.titleSmall?.copyWith(fontWeight: FontWeight.w600),
      bodyLarge:      base.bodyLarge?.copyWith(height: 1.45),
      bodyMedium:     base.bodyMedium?.copyWith(height: 1.45),
      labelLarge:     base.labelLarge?.copyWith(fontWeight: FontWeight.w600, letterSpacing: 0.3),
    );

    return ThemeData(
      useMaterial3:           true,
      colorScheme:            scheme,
      brightness:             brightness,
      scaffoldBackgroundColor: isDark ? SADark.background : SALight.background,
      textTheme:              textTheme,

      // ── App Bar ────────────────────────────────────────────────────────────
      appBarTheme: AppBarTheme(
        centerTitle:         false,
        backgroundColor:     Colors.transparent,
        foregroundColor:     scheme.onSurface,
        elevation:           0,
        scrolledUnderElevation: 0,
        systemOverlayStyle: isDark
            ? SystemUiOverlayStyle.light
            : SystemUiOverlayStyle.dark,
        titleTextStyle: textTheme.titleLarge?.copyWith(
          color:       scheme.onSurface,
          fontWeight:  FontWeight.w800,
          fontSize:    22,
        ),
      ),

      // ── Cards ──────────────────────────────────────────────────────────────
      cardTheme: CardThemeData(
        elevation: 0,
        color:     Colors.transparent,
        shape:     RoundedRectangleBorder(borderRadius: SARadius.lg),
        margin:    EdgeInsets.zero,
      ),

      // ── Chips ──────────────────────────────────────────────────────────────
      chipTheme: ChipThemeData(
        backgroundColor: isDark
            ? Colors.white.withValues(alpha: 0.08)
            : Colors.black.withValues(alpha: 0.05),
        selectedColor: scheme.primaryContainer,
        labelStyle: textTheme.labelLarge?.copyWith(color: scheme.onSurface),
        secondaryLabelStyle: textTheme.labelLarge?.copyWith(
          color: scheme.onPrimaryContainer,
        ),
        shape:   const StadiumBorder(),
        side: BorderSide(
          color: isDark
              ? Colors.white.withValues(alpha: 0.10)
              : Colors.black.withValues(alpha: 0.07),
          width: 0.8,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      ),

      // ── Filled Button ──────────────────────────────────────────────────────
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: scheme.primary,
          foregroundColor: scheme.onPrimary,
          shape:     RoundedRectangleBorder(borderRadius: SARadius.sm),
          textStyle: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
          padding:   const EdgeInsets.symmetric(horizontal: 22, vertical: 15),
          elevation: 0,
        ),
      ),

      // ── Outlined Button ────────────────────────────────────────────────────
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: scheme.primary,
          side:      BorderSide(color: scheme.outline),
          shape:     RoundedRectangleBorder(borderRadius: SARadius.sm),
          textStyle: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
          padding:   const EdgeInsets.symmetric(horizontal: 18, vertical: 13),
        ),
      ),

      // ── Text Button ────────────────────────────────────────────────────────
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: scheme.primary,
          textStyle: textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w700),
        ),
      ),

      // ── Icon Button ────────────────────────────────────────────────────────
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          foregroundColor: scheme.onSurfaceVariant,
        ),
      ),

      // ── Input ──────────────────────────────────────────────────────────────
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: isDark
            ? Colors.white.withValues(alpha: 0.06)
            : Colors.black.withValues(alpha: 0.04),
        border: OutlineInputBorder(
          borderRadius: SARadius.sm,
          borderSide: BorderSide(
            color: isDark
                ? Colors.white.withValues(alpha: 0.12)
                : Colors.black.withValues(alpha: 0.10),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: SARadius.sm,
          borderSide: BorderSide(
            color: isDark
                ? Colors.white.withValues(alpha: 0.12)
                : Colors.black.withValues(alpha: 0.10),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: SARadius.sm,
          borderSide: BorderSide(color: scheme.primary, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: SARadius.sm,
          borderSide: BorderSide(color: scheme.error, width: 1.5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: SARadius.sm,
          borderSide: BorderSide(color: scheme.error, width: 1.8),
        ),
        labelStyle: TextStyle(color: scheme.onSurfaceVariant),
        hintStyle:  TextStyle(
          color: scheme.onSurfaceVariant.withValues(alpha: 0.55),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),

      // ── Switch ─────────────────────────────────────────────────────────────
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return scheme.primary;
          return scheme.onSurfaceVariant.withValues(alpha: 0.50);
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return scheme.primary.withValues(alpha: 0.25);
          }
          return scheme.onSurfaceVariant.withValues(alpha: 0.14);
        }),
      ),

      // ── Divider ────────────────────────────────────────────────────────────
      dividerTheme: DividerThemeData(
        color: isDark
            ? Colors.white.withValues(alpha: 0.08)
            : Colors.black.withValues(alpha: 0.06),
        thickness: 0.8,
        space:     0.8,
      ),

      // ── List Tile ──────────────────────────────────────────────────────────
      listTileTheme: ListTileThemeData(
        contentPadding: EdgeInsets.zero,
        iconColor: scheme.onSurfaceVariant,
        titleTextStyle: textTheme.bodyLarge?.copyWith(
          color:       scheme.onSurface,
          fontWeight:  FontWeight.w500,
        ),
        subtitleTextStyle: textTheme.bodySmall?.copyWith(
          color: scheme.onSurfaceVariant,
        ),
      ),

      // ── Progress Indicator ─────────────────────────────────────────────────
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color:              scheme.primary,
        linearTrackColor:   scheme.primary.withValues(alpha: 0.15),
        linearMinHeight:    8,
        circularTrackColor: scheme.primary.withValues(alpha: 0.15),
        borderRadius:       BorderRadius.circular(999),
      ),

      // ── FAB ────────────────────────────────────────────────────────────────
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: scheme.primaryContainer,
        foregroundColor: scheme.onPrimaryContainer,
        elevation:       0,
        shape:           const CircleBorder(),
      ),

      // ── Snack Bar ──────────────────────────────────────────────────────────
      snackBarTheme: SnackBarThemeData(
        behavior:        SnackBarBehavior.floating,
        backgroundColor: isDark ? SADark.surfaceContainerHigh : SALight.onSurface,
        contentTextStyle: textTheme.bodyMedium?.copyWith(
          color:       isDark ? SADark.onSurface : SALight.surface,
          fontWeight:  FontWeight.w500,
        ),
        shape: RoundedRectangleBorder(borderRadius: SARadius.md),
        elevation: 4,
      ),

      // ── Bottom Sheet ───────────────────────────────────────────────────────
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor:      Colors.transparent,
        modalBackgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
      ),

      // ── Dialog ─────────────────────────────────────────────────────────────
      dialogTheme: DialogThemeData(
        backgroundColor: isDark ? SADark.surfaceContainer : SALight.surface,
        shape:           RoundedRectangleBorder(borderRadius: SARadius.xl),
        titleTextStyle: textTheme.titleLarge?.copyWith(color: scheme.onSurface),
        contentTextStyle: textTheme.bodyMedium?.copyWith(
          color: scheme.onSurfaceVariant,
        ),
        elevation: 0,
      ),

      // ── Icon ───────────────────────────────────────────────────────────────
      iconTheme: IconThemeData(color: scheme.onSurface, size: 22),
    );
  }
}
