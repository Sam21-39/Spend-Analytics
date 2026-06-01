import 'package:flutter/material.dart';

/// Small colored label pill — used for budget status, sync state, tags, etc.
///
/// ```dart
/// SAPill(label: '12%', color: scheme.tertiary, icon: Icons.arrow_downward)
/// ```
class SAPill extends StatelessWidget {
  const SAPill({
    required this.label,
    super.key,
    this.color,
    this.icon,
    this.tint = 0.14,
  });

  final String   label;
  final Color?   color;
  final IconData? icon;
  final double   tint;

  @override
  Widget build(BuildContext context) {
    final c = color ?? Theme.of(context).colorScheme.primary;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color:        c.withValues(alpha: tint),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: c.withValues(alpha: 0.25), width: 0.5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if (icon != null) ...<Widget>[
            Icon(icon, size: 10, color: c),
            const SizedBox(width: 4),
          ],
          Text(
            label,
            style: TextStyle(
              fontSize:   11,
              fontWeight: FontWeight.w700,
              color:      c,
              height:     1,
            ),
          ),
        ],
      ),
    );
  }
}
