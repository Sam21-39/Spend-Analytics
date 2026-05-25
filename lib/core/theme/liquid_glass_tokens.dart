import 'package:flutter/material.dart';

class LiquidGlassColors {
  static const Color background = Color(0xFF121317);
  static const Color surface = Color(0xFF121317);
  static const Color surfaceContainer = Color(0xFF1E1F23);
  static const Color surfaceContainerHigh = Color(0xFF292A2E);
  static const Color surfaceContainerHighest = Color(0xFF343539);
  static const Color surfaceVariant = Color(0xFF343539);
  static const Color onSurface = Color(0xFFE3E2E7);
  static const Color onSurfaceVariant = Color(0xFFC1C6D7);
  static const Color outline = Color(0xFF8B90A0);
  static const Color outlineVariant = Color(0xFF414755);

  static const Color primary = Color(0xFFADC6FF);
  static const Color primaryContainer = Color(0xFF4B8EFF);
  static const Color onPrimaryContainer = Color(0xFF00285C);

  static const Color secondary = Color(0xFFFFB3B5);
  static const Color secondaryContainer = Color(0xFFDE0541);

  static const Color tertiary = Color(0xFFC2C1FF);
  static const Color tertiaryContainer = Color(0xFF8382FF);

  static const Color error = Color(0xFFFFB4AB);
  static const Color errorContainer = Color(0xFF93000A);
}

class LiquidGlassDecor {
  static const BorderRadius cardRadius = BorderRadius.all(Radius.circular(24));
  static const BorderRadius chipRadius = BorderRadius.all(Radius.circular(999));

  static const BoxShadow glowPrimary = BoxShadow(
    color: Color.fromRGBO(173, 198, 255, 0.22),
    blurRadius: 24,
    spreadRadius: 0,
    offset: Offset(0, 0),
  );

  static const BoxShadow glowSoft = BoxShadow(
    color: Color.fromRGBO(173, 198, 255, 0.10),
    blurRadius: 28,
    offset: Offset(0, 14),
  );

  static LinearGradient appGlowGradient() {
    return const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: <Color>[
        Color.fromRGBO(75, 142, 255, 0.18),
        Color.fromRGBO(63, 223, 165, 0.12),
        Color.fromRGBO(222, 5, 65, 0.08),
      ],
      stops: <double>[0.0, 0.55, 1.0],
    );
  }
}
