import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:spend_analytics/core/theme/liquid_glass_tokens.dart';

/// iOS-style frosted-glass surface.
///
/// ### Dark mode behaviour
/// The panel is semi-transparent (≈9 % white fill) so the blurred
/// dark background glows through. A bright specular highlight gradient
/// runs top-left → bottom-right. Border is white at low opacity.
///
/// ### Light mode behaviour
/// The panel is heavily opaque (≈64 % white fill) — classic iOS frosted
/// glass. The specular highlight is more pronounced. Border is black at
/// very low opacity to define the edge without looking harsh.
///
/// ### Customisation
/// Every visual property can be overridden:
/// ```dart
/// LiquidGlassSurface(
///   fillOpacity: 0.20,   // darker tint in dark mode
///   blur: 40,            // more aggressive blur
///   borderRadius: SARadius.lg,
///   child: ...,
/// )
/// ```
class LiquidGlassSurface extends StatelessWidget {
  const LiquidGlassSurface({
    required this.child,
    super.key,
    this.padding   = const EdgeInsets.all(16),
    this.margin,
    this.borderRadius = const BorderRadius.all(Radius.circular(20)),
    this.blur         = SAGlass.blurSigma,
    this.fillOpacity,
  });

  final Widget child;
  final EdgeInsetsGeometry  padding;
  final EdgeInsetsGeometry? margin;
  final BorderRadius        borderRadius;

  /// Gaussian blur sigma applied as BackdropFilter.
  final double blur;

  /// White-fill opacity (0.0–1.0).
  /// `null` → auto: [SAGlass.darkFillOpacity] in dark, [SAGlass.lightFillOpacity] in light.
  final double? fillOpacity;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final double fill = fillOpacity ??
        (isDark ? SAGlass.darkFillOpacity : SAGlass.lightFillOpacity);

    // ── Border ──────────────────────────────────────────────────────────────
    final Color borderColor = isDark
        ? Colors.white.withValues(alpha: SAGlass.darkBorderOpacity)
        : Colors.black.withValues(alpha: SAGlass.lightBorderOpacity);

    // ── Specular gradient (top-left highlight → bottom-right shadow) ─────────
    final Color gradTop = isDark
        ? Colors.white.withValues(alpha: (fill + 0.07).clamp(0, 1))
        : Colors.white.withValues(alpha: (fill + 0.10).clamp(0, 1));
    final Color gradBot = isDark
        ? Colors.white.withValues(alpha: (fill - 0.04).clamp(0, 1))
        : Colors.white.withValues(alpha: (fill - 0.15).clamp(0, 1));

    // ── Drop shadow ──────────────────────────────────────────────────────────
    final BoxShadow shadow = isDark
        ? const BoxShadow(
            color:      Color.fromRGBO(0, 0, 0, 0.30),
            blurRadius: 32,
            offset:     Offset(0, 12),
          )
        : const BoxShadow(
            color:      Color.fromRGBO(0, 0, 0, 0.08),
            blurRadius: 20,
            offset:     Offset(0, 6),
          );

    return Container(
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        border:       Border.all(color: borderColor, width: 0.8),
        boxShadow:    <BoxShadow>[shadow],
      ),
      child: ClipRRect(
        borderRadius: borderRadius,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
          child: Container(
            padding: padding,
            decoration: BoxDecoration(
              borderRadius: borderRadius,
              gradient: LinearGradient(
                begin:  Alignment.topLeft,
                end:    Alignment.bottomRight,
                colors: <Color>[gradTop, gradBot],
              ),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
