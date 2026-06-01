import 'package:flutter/material.dart';
import 'package:spend_analytics/shared/widgets/liquid_glass_surface.dart';

/// A glass metric card for displaying a key-value summary.
///
/// Renders an optional [icon] in a tinted circle, a [title] label,
/// a large [value] string, and an optional [subtitle].
///
/// Example:
/// ```dart
/// SpendCard(
///   title: 'Monthly Spend',
///   value: '₹12,450',
///   icon: Icons.wallet_rounded,
///   accentColor: scheme.primary,
///   subtitle: '↑ 8% vs last month',
/// )
/// ```
class SpendCard extends StatelessWidget {
  const SpendCard({
    required this.title,
    required this.value,
    super.key,
    this.icon,
    this.accentColor,
    this.subtitle,
    this.onTap,
  });

  final String    title;
  final String    value;
  final IconData? icon;
  final Color?    accentColor;
  final String?   subtitle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final accent = accentColor ?? scheme.primary;

    return GestureDetector(
      onTap:     onTap,
      behavior:  HitTestBehavior.opaque,
      child: LiquidGlassSurface(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize:       MainAxisSize.min,
          children: <Widget>[
            // ── Header row ────────────────────────────────────────────────
            Row(
              children: <Widget>[
                if (icon != null) ...<Widget>[
                  Container(
                    width:  36,
                    height: 36,
                    decoration: BoxDecoration(
                      color:        accent.withValues(alpha: 0.14),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(icon, color: accent, size: 18),
                  ),
                  const SizedBox(width: 10),
                ],
                Expanded(
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color:        scheme.onSurfaceVariant,
                      letterSpacing: 0.3,
                    ),
                  ),
                ),
                if (onTap != null)
                  Icon(
                    Icons.chevron_right_rounded,
                    size:  18,
                    color: scheme.onSurfaceVariant.withValues(alpha: 0.5),
                  ),
              ],
            ),
            const SizedBox(height: 12),

            // ── Value ────────────────────────────────────────────────────
            Text(
              value,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color:      scheme.onSurface,
                fontWeight: FontWeight.w800,
              ),
            ),

            // ── Subtitle ─────────────────────────────────────────────────
            if (subtitle != null) ...<Widget>[
              const SizedBox(height: 4),
              Text(
                subtitle!,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: scheme.onSurfaceVariant,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
