import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spend_analytics/core/routes/app_routes.dart';
import 'package:spend_analytics/features/budgets/budget_controller.dart';
import 'package:spend_analytics/shared/utils/currency_formatter.dart';
import 'package:spend_analytics/shared/widgets/liquid_glass_surface.dart';
import 'package:spend_analytics/shared/widgets/liquid_page_scaffold.dart';

class BudgetScreen extends GetView<BudgetController> {
  const BudgetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    const spending = <String, double>{
      'Food': 3520,
      'Transport': 1200,
      'Shopping': 2100,
    };

    return LiquidPageScaffold(
      title: 'Budgets',
      activeRoute: AppRoutes.budgets,
      child: Obx(
        () => Column(
          children: controller.categoryBudgets.entries
              .map((entry) {
                final spent = spending[entry.key] ?? 0;
                final limit = entry.value;
                final usage = limit == 0 ? 0.0 : (spent / limit);
                final progress = usage.clamp(0.0, 1.0);

                Color accent;
                IconData statusIcon;
                String status;

                if (usage >= 1) {
                  accent = const Color(0xFFFF6B6B);
                  statusIcon = Icons.error_rounded;
                  status = '${formatInr(spent - limit)} over budget';
                } else if (usage >= 0.8) {
                  accent = const Color(0xFFFFB74D);
                  statusIcon = Icons.warning_amber_rounded;
                  status = '${formatInr(limit - spent)} left';
                } else {
                  accent = const Color(0xFF3FDF95);
                  statusIcon = Icons.check_circle_rounded;
                  status = '${formatInr(limit - spent)} left';
                }

                return Padding(
                  padding: const EdgeInsets.only(bottom: 14),
                  child: LiquidGlassSurface(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            CircleAvatar(
                              backgroundColor: accent.withValues(alpha: 0.2),
                              child: Icon(
                                _iconForCategory(entry.key),
                                color: accent,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                entry.key,
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              '${formatInr(spent)} of ${formatInr(limit)}',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            Row(
                              children: <Widget>[
                                Icon(statusIcon, size: 16, color: accent),
                                const SizedBox(width: 4),
                                Text(
                                  status,
                                  style: Theme.of(context).textTheme.bodySmall
                                      ?.copyWith(color: accent),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(999),
                          child: LinearProgressIndicator(
                            value: progress,
                            minHeight: 10,
                            backgroundColor: Colors.white.withValues(
                              alpha: 0.08,
                            ),
                            valueColor: AlwaysStoppedAnimation<Color>(accent),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            '${(progress * 100).toStringAsFixed(0)}% used',
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(color: scheme.onSurfaceVariant),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              })
              .toList(growable: false),
        ),
      ),
    );
  }

  IconData _iconForCategory(String category) {
    final value = category.toLowerCase();
    if (value.contains('food')) {
      return Icons.restaurant_rounded;
    }
    if (value.contains('transport')) {
      return Icons.directions_car_rounded;
    }
    if (value.contains('shop')) {
      return Icons.shopping_bag_rounded;
    }
    return Icons.wallet_rounded;
  }
}
