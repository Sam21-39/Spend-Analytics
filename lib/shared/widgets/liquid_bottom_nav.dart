import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spend_analytics/core/routes/app_routes.dart';
import 'package:spend_analytics/shared/widgets/liquid_glass_surface.dart';

/// Floating pill-shaped bottom navigation bar with iOS-style glass treatment
/// and an animated active-item highlight pill.
class LiquidBottomNav extends StatelessWidget {
  const LiquidBottomNav({required this.activeRoute, super.key});

  final String activeRoute;

  static const _items = <
      ({
        String route,
        IconData icon,
        IconData iconActive,
        String label,
      })>[
    (
      route:      AppRoutes.dashboard,
      icon:       Icons.home_outlined,
      iconActive: Icons.home_rounded,
      label:      'Home',
    ),
    (
      route:      AppRoutes.analytics,
      icon:       Icons.analytics_outlined,
      iconActive: Icons.analytics_rounded,
      label:      'Analytics',
    ),
    (
      route:      AppRoutes.budgets,
      icon:       Icons.account_balance_wallet_outlined,
      iconActive: Icons.account_balance_wallet_rounded,
      label:      'Budgets',
    ),
    (
      route:      AppRoutes.rules,
      icon:       Icons.auto_awesome_outlined,
      iconActive: Icons.auto_awesome_rounded,
      label:      'Rules',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 28),
      child: LiquidGlassSurface(
        padding:      const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
        borderRadius: const BorderRadius.all(Radius.circular(999)),
        blur:         32,
        fillOpacity:  isDark ? 0.13 : 0.70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: _items.map((item) {
            final isActive = item.route == activeRoute;
            return _NavItem(
              icon:       isActive ? item.iconActive : item.icon,
              label:      item.label,
              isActive:   isActive,
              onTap: () {
                if (!isActive) Get.offAllNamed(item.route);
              },
            );
          }).toList(growable: false),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  final IconData      icon;
  final String        label;
  final bool          isActive;
  final VoidCallback  onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final color  = isActive
        ? scheme.primary
        : scheme.onSurfaceVariant.withValues(alpha: 0.55);

    return GestureDetector(
      onTap:     onTap,
      behavior:  HitTestBehavior.opaque,
      child: Tooltip(
        message: label,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve:    Curves.easeOutCubic,
          padding:  const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(999),
            color: isActive
                ? scheme.primary.withValues(alpha: 0.14)
                : Colors.transparent,
          ),
          child: Icon(icon, color: color, size: 22),
        ),
      ),
    );
  }
}
