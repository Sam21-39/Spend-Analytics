import 'package:flutter/material.dart';

/// Gradient linear progress bar — matches the design `ProgressBar` primitive.
///
/// The bar glows with a drop-shadow in the fill color.
class SAProgressBar extends StatelessWidget {
  const SAProgressBar({
    required this.value,
    super.key,
    this.color,
    this.height = 6,
  }) : assert(value >= 0 && value <= 1, 'value must be 0..1');

  /// Progress 0.0 → 1.0 (clamped internally).
  final double  value;
  final Color?  color;
  final double  height;

  @override
  Widget build(BuildContext context) {
    final c = color ?? Theme.of(context).colorScheme.primary;
    return LayoutBuilder(
      builder: (_, constraints) {
        final w = constraints.maxWidth;
        final fillW = (value.clamp(0.0, 1.0) * w).clamp(0.0, w);
        return Container(
          height: height,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.18),
            borderRadius: BorderRadius.circular(999),
          ),
          child: Stack(
            children: <Widget>[
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOutCubic,
                width:  fillW,
                height: height,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: <Color>[c, c.withValues(alpha: 0.7)],
                  ),
                  borderRadius: BorderRadius.circular(999),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color:      c.withValues(alpha: 0.5),
                      blurRadius: 8,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
