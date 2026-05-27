import 'dart:math' as math;

import 'package:flutter/material.dart';

/// Circular progress ring — SVG-style arc drawn with CustomPainter.
///
/// ```dart
/// RingProgress(size: 84, value: 0.72, stroke: 9, color: scheme.primary)
/// ```
class RingProgress extends StatelessWidget {
  const RingProgress({
    super.key,
    this.size   = 48,
    this.value  = 0,
    this.stroke = 5,
    this.color,
  }) : assert(value >= 0 && value <= 1, 'value must be 0..1');

  final double size;
  final double value;
  final double stroke;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final c = color ?? Theme.of(context).colorScheme.primary;
    return SizedBox(
      width:  size,
      height: size,
      child: CustomPaint(
        painter: _RingPainter(value: value.clamp(0.0, 1.0), stroke: stroke, color: c),
      ),
    );
  }
}

class _RingPainter extends CustomPainter {
  const _RingPainter({
    required this.value,
    required this.stroke,
    required this.color,
  });

  final double value;
  final double stroke;
  final Color  color;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - stroke) / 2;
    const startAngle = -math.pi / 2;   // 12 o'clock
    final sweepAngle = 2 * math.pi * value;

    // Track
    canvas.drawCircle(
      center,
      radius,
      Paint()
        ..color       = Colors.white.withValues(alpha: 0.18)
        ..strokeWidth = stroke
        ..style       = PaintingStyle.stroke,
    );

    if (value > 0) {
      // Fill arc with glow
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        false,
        Paint()
          ..color       = color
          ..strokeWidth = stroke
          ..style       = PaintingStyle.stroke
          ..strokeCap   = StrokeCap.round
          ..maskFilter  = const MaskFilter.blur(BlurStyle.normal, 3),
      );
      // Solid arc on top
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        false,
        Paint()
          ..color       = color
          ..strokeWidth = stroke
          ..style       = PaintingStyle.stroke
          ..strokeCap   = StrokeCap.round,
      );
    }
  }

  @override
  bool shouldRepaint(_RingPainter old) =>
      old.value != value || old.color != color || old.stroke != stroke;
}
