import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spend_analytics/core/routes/app_routes.dart';
import 'package:spend_analytics/shared/widgets/liquid_glass_surface.dart';

class LiquidBottomNav extends StatelessWidget {
  const LiquidBottomNav({required this.activeRoute, super.key});

  final String activeRoute;

  @override
  Widget build(BuildContext context) {
    final items = <({String route, IconData icon, String label})>[
      (route: AppRoutes.dashboard, icon: Icons.home_rounded, label: 'Home'),
      (
        route: AppRoutes.analytics,
        icon: Icons.analytics_rounded,
        label: 'Analytics',
      ),
      (
        route: AppRoutes.budgets,
        icon: Icons.account_balance_wallet_rounded,
        label: 'Budgets',
      ),
      (route: AppRoutes.rules, icon: Icons.rule_rounded, label: 'Rules'),
    ];

    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 0, 18, 24),
      child: LiquidGlassSurface(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        borderRadius: const BorderRadius.all(Radius.circular(999)),
        opacity: 0.22,
        blur: 28,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: items
              .map((item) {
                final isActive = item.route == activeRoute;
                return IconButton(
                  onPressed: () {
                    if (!isActive) {
                      Get.offAllNamed(item.route);
                    }
                  },
                  icon: Icon(item.icon),
                  color:
                      isActive
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(
                            context,
                          ).colorScheme.onSurface.withValues(alpha: 0.5),
                  tooltip: item.label,
                );
              })
              .toList(growable: false),
        ),
      ),
    );
  }
}
