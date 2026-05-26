import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spend_analytics/core/routes/app_routes.dart';
import 'package:spend_analytics/features/rules/rules_controller.dart';
import 'package:spend_analytics/shared/widgets/liquid_glass_surface.dart';
import 'package:spend_analytics/shared/widgets/liquid_page_scaffold.dart';

class RulesScreen extends GetView<RulesController> {
  const RulesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return LiquidPageScaffold(
      title: 'My Smart Rules',
      activeRoute: AppRoutes.rules,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Automate your financial discipline with smart alerts.',
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(color: scheme.onSurfaceVariant),
          ),
          const SizedBox(height: 14),
          Obx(() {
            if (controller.rules.isEmpty) {
              return LiquidGlassSurface(
                child: Text(
                  'No active rules yet.',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              );
            }

            return Column(
              children: controller.rules
                  .map(
                    (rule) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: LiquidGlassSurface(
                        child: Row(
                          children: <Widget>[
                            CircleAvatar(
                              backgroundColor: Colors.white.withValues(
                                alpha: 0.09,
                              ),
                              child: Icon(
                                _iconForRule(rule.ruleType),
                                color: _accentForRule(rule.ruleType),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    rule.title,
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                  const SizedBox(height: 3),
                                  Text(
                                    rule.subtitle,
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodySmall?.copyWith(
                                      color: scheme.onSurfaceVariant,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Switch.adaptive(
                              value: rule.isActive,
                              onChanged:
                                  (value) =>
                                      controller.toggleRule(rule.id, value),
                              activeTrackColor: scheme.primary.withValues(
                                alpha: 0.45,
                              ),
                              thumbColor: WidgetStatePropertyAll<Color?>(
                                scheme.primary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                  .toList(growable: false),
            );
          }),
          const SizedBox(height: 4),
          OutlinedButton.icon(
            onPressed: () async {
              await controller.addDailyLimitRule();
              Get.snackbar('Added', 'A new daily-limit rule is now active.');
            },
            icon: const Icon(Icons.add_circle_outline_rounded),
            label: const Text('Add New Rule'),
          ),
        ],
      ),
    );
  }

  IconData _iconForRule(String ruleType) {
    switch (ruleType) {
      case 'budget_threshold':
        return Icons.account_balance_wallet_rounded;
      case 'daily_limit':
        return Icons.payments_rounded;
      case 'category_spike':
        return Icons.trending_up_rounded;
      case 'recurring_due':
        return Icons.refresh_rounded;
      default:
        return Icons.notifications_active_rounded;
    }
  }

  Color _accentForRule(String ruleType) {
    switch (ruleType) {
      case 'budget_threshold':
        return const Color(0xFFFF6B6B);
      case 'daily_limit':
        return const Color(0xFFADC6FF);
      case 'category_spike':
        return const Color(0xFF8382FF);
      case 'recurring_due':
        return const Color(0xFF3FDF95);
      default:
        return const Color(0xFFFFB74D);
    }
  }
}
