import 'package:flutter/material.dart';

/// Tinted rounded-square icon container — direct Flutter port of the
/// design's `IconBox` primitive.
///
/// ```dart
/// IconBox(icon: Icons.coffee_rounded, color: Color(0xFFFF9F40));
/// ```
class IconBox extends StatelessWidget {
  const IconBox({
    required this.icon,
    required this.color,
    super.key,
    this.size = 36,
    this.radius = 10,
    this.tint = 0.14,
    this.iconSize,
  });

  final IconData icon;
  final Color    color;
  final double   size;
  final double   radius;
  final double   tint;
  final double?  iconSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      width:  size,
      height: size,
      decoration: BoxDecoration(
        color:        color.withValues(alpha: tint),
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(
          color: color.withValues(alpha: 0.25),
          width: 0.5,
        ),
      ),
      alignment: Alignment.center,
      child: Icon(
        icon,
        size:  iconSize ?? (size * 0.55),
        color: color,
      ),
    );
  }
}
