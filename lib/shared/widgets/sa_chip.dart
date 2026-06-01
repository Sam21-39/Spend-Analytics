import 'package:flutter/material.dart';

/// Tappable filter chip — matches the design `Chip` primitive.
///
/// ```dart
/// SAChip(label: 'Food', active: true, color: scheme.primary)
/// ```
class SAChip extends StatelessWidget {
  const SAChip({
    required this.label,
    super.key,
    this.active   = false,
    this.color,
    this.icon,
    this.onTap,
  });

  final String    label;
  final bool      active;
  final Color?    color;
  final IconData? icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isDark  = Theme.of(context).brightness == Brightness.dark;
    final c       = color ?? scheme.primary;
    final bg      = active
        ? c.withValues(alpha: 0.18)
        : (isDark
            ? Colors.white.withValues(alpha: 0.08)
            : Colors.black.withValues(alpha: 0.05));
    final border  = active
        ? c.withValues(alpha: 0.4)
        : (isDark
            ? Colors.white.withValues(alpha: 0.12)
            : Colors.black.withValues(alpha: 0.10));

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        curve: Curves.easeOutCubic,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color:        bg,
          borderRadius: BorderRadius.circular(999),
          border:       Border.all(color: border, width: 0.5),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            if (icon != null) ...<Widget>[
              Icon(
                icon,
                size:  14,
                color: active ? c : scheme.onSurfaceVariant,
              ),
              const SizedBox(width: 6),
            ],
            Text(
              label,
              style: TextStyle(
                fontSize:   13,
                fontWeight: FontWeight.w700,
                color:      active ? c : scheme.onSurface,
                height:     1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
