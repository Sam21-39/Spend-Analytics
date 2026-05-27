import 'package:flutter/material.dart';
import 'package:spend_analytics/core/theme/liquid_glass_tokens.dart';

/// Full-screen ambient glow backdrop.
///
/// In **dark mode**: deep blue-black base with electric-toned glow orbs
/// (blue top-left, mint bottom-right, purple mid).
///
/// In **light mode**: soft cool-white base with subtle pastel glow orbs
/// of the same hue family but significantly reduced intensity.
class LiquidGlassBackground extends StatelessWidget {
  const LiquidGlassBackground({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark  = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? SADark.background : SALight.background;
    final glowA   = isDark ? SADark.glowBlue   : SALight.glowBlue;
    final glowB   = isDark ? SADark.glowPurple  : SALight.glowPurple;
    final glowC   = isDark ? SADark.glowMint    : SALight.glowMint;

    return IgnorePointer(
      child: ColoredBox(
        color: bgColor,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            // Top-left: blue orb
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: const Alignment(-0.80, -0.72),
                  radius: 0.90,
                  colors: <Color>[glowA, Colors.transparent],
                ),
              ),
            ),
            // Bottom-right: mint orb
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: const Alignment(0.88, 0.82),
                  radius: 0.95,
                  colors: <Color>[glowC, Colors.transparent],
                ),
              ),
            ),
            // Mid: purple accent
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: const Alignment(0.35, -0.10),
                  radius: 0.70,
                  colors: <Color>[glowB, Colors.transparent],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
