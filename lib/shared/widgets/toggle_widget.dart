import 'package:flutter/material.dart';

/// iOS-style toggle switch matching the design's `Toggle` component.
///
/// ```dart
/// SAToggle(value: true, onChanged: (v) => setState(() => on = v))
/// ```
class SAToggle extends StatelessWidget {
  const SAToggle({
    required this.value,
    super.key,
    this.onChanged,
  });

  final bool value;
  final ValueChanged<bool>? onChanged;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final trackColor = value ? scheme.tertiary : Colors.white.withValues(alpha: 0.25);
    final glowColor  = value ? scheme.tertiary.withValues(alpha: 0.4) : Colors.transparent;

    return GestureDetector(
      onTap: onChanged == null ? null : () => onChanged!(!value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOutCubic,
        width:  44,
        height: 26,
        decoration: BoxDecoration(
          color:        trackColor,
          borderRadius: BorderRadius.circular(999),
          boxShadow: <BoxShadow>[
            BoxShadow(color: glowColor, blurRadius: 12),
            BoxShadow(
              color: trackColor.withValues(alpha: 0.5),
              blurRadius: 0,
              spreadRadius: 0.5,
            ),
          ],
        ),
        child: Stack(
          children: <Widget>[
            AnimatedPositioned(
              duration: const Duration(milliseconds: 220),
              curve: Curves.easeOutCubic,
              top:  2,
              left: value ? 20 : 2,
              child: Container(
                width:  22,
                height: 22,
                decoration: BoxDecoration(
                  color:        Colors.white,
                  shape:        BoxShape.circle,
                  boxShadow: const <BoxShadow>[
                    BoxShadow(
                      color:      Color(0x4D000000),
                      blurRadius: 6,
                      offset:     Offset(0, 2),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
