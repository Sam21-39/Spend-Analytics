import 'dart:ui';

import 'package:flutter/material.dart';

class LiquidGlassSurface extends StatelessWidget {
  const LiquidGlassSurface({
    required this.child,
    super.key,
    this.padding = const EdgeInsets.all(16),
    this.margin,
    this.borderRadius = const BorderRadius.all(Radius.circular(20)),
    this.opacity = 0.34,
    this.blur = 22,
    this.borderOpacity = 0.2,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry? margin;
  final BorderRadius borderRadius;
  final double opacity;
  final double blur;
  final double borderOpacity;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        border: Border.all(
          color: Colors.white.withValues(alpha: borderOpacity),
        ),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.22),
            blurRadius: 32,
            offset: Offset(0, 14),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: borderRadius,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
          child: Container(
            padding: padding,
            decoration: BoxDecoration(
              borderRadius: borderRadius,
              color: Colors.white.withValues(alpha: opacity),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[
                  Colors.white.withValues(alpha: opacity + 0.06),
                  Colors.white.withValues(alpha: opacity - 0.16),
                ],
              ),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
