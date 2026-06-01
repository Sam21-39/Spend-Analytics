import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spend_analytics/core/routes/app_routes.dart';
import 'package:spend_analytics/shared/widgets/liquid_glass_surface.dart';

/// Floating pill bottom nav + gradient FAB — matches the design's BottomNav.
///
/// Layout: [← tabs pill ─────────────] [FAB]
/// The entire row sits 28 px above the device bottom (safe area aware).
class LiquidBottomNav extends StatelessWidget {
  const LiquidBottomNav({
    required this.activeRoute,
    super.key,
    this.showFab     = true,
    this.onAddPressed,
  });

  final String        activeRoute;
  final bool          showFab;
  final VoidCallback? onAddPressed;

  static const _items = <
      ({
        String   route,
        IconData icon,
        IconData iconActive,
        String   label,
      })>[
    (
      route:      AppRoutes.dashboard,
      icon:       Icons.home_outlined,
      iconActive: Icons.home_rounded,
      label:      'Home',
    ),
    (
      route:      AppRoutes.analytics,
      icon:       Icons.bar_chart_outlined,
      iconActive: Icons.bar_chart_rounded,
      label:      'Stats',
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
    final scheme = Theme.of(context).colorScheme;
    final isDark  = Theme.of(context).brightness == Brightness.dark;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 28),
        child: Row(
          children: <Widget>[
            // ── Tab pill ──────────────────────────────────────────
            Expanded(
              child: LiquidGlassSurface(
                padding:      EdgeInsets.zero,
                borderRadius: const BorderRadius.all(Radius.circular(999)),
                blur:         32,
                fillOpacity:  isDark ? 0.13 : 0.70,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
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
              ),
            ),

            // ── FAB ──────────────────────────────────────────────
            if (showFab) ...<Widget>[
              const SizedBox(width: 12),
              GestureDetector(
                onTap: onAddPressed ?? () => Get.toNamed(AppRoutes.addTxn),
                child: Container(
                  width:  60,
                  height: 60,
                  decoration: BoxDecoration(
                    shape:    BoxShape.circle,
                    gradient: LinearGradient(
                      begin:  Alignment.topLeft,
                      end:    Alignment.bottomRight,
                      colors: <Color>[scheme.primary, scheme.secondary],
                    ),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color:      scheme.primary.withValues(alpha: 0.5),
                        blurRadius: 24,
                        offset:     const Offset(0, 8),
                      ),
                      const BoxShadow(
                        color:      Color(0x19FFFFFF),
                        blurRadius: 0,
                        spreadRadius: -1,
                      ),
                    ],
                  ),
                  alignment: Alignment.center,
                  child: const Icon(
                    Icons.add_rounded,
                    color: Colors.white,
                    size:  26,
                  ),
                ),
              ),
            ],
          ],
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

  final IconData     icon;
  final String       label;
  final bool         isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final color  = isActive
        ? scheme.primary
        : scheme.onSurfaceVariant.withValues(alpha: 0.55);

    return GestureDetector(
      onTap:    onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve:    Curves.easeOutCubic,
        padding:  const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(999),
          color: isActive
              ? scheme.primary.withValues(alpha: 0.14)
              : Colors.transparent,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(icon, color: color, size: 20),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontSize:   10,
                fontWeight: FontWeight.w700,
                color:      color,
                letterSpacing: 0.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
