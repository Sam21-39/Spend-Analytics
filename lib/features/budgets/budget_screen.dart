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

    return LiquidPageScaffold(
      title: 'Budgets',
      activeRoute: AppRoutes.budgets,
      actions: <Widget>[
        IconButton(
          onPressed: () => _showAddBudgetSheet(context),
          icon: const Icon(Icons.add_rounded),
        ),
      ],
      child: Obx(
        () => Column(
          children: controller.categoryBudgets.entries
              .map((entry) {
                final spent = controller.categorySpend[entry.key] ?? 0;
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

  Future<void> _showAddBudgetSheet(BuildContext context) async {
    final categoryCtrl = TextEditingController();
    final amountCtrl = TextEditingController();

    try {
      await showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (bottomSheetContext) {
          return Padding(
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
              top: 16,
              bottom: MediaQuery.of(bottomSheetContext).viewInsets.bottom + 16,
            ),
            child: LiquidGlassSurface(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Add / Update Budget',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: categoryCtrl,
                    decoration: const InputDecoration(
                      labelText: 'Category',
                      hintText: 'Food',
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: amountCtrl,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    decoration: const InputDecoration(
                      labelText: 'Monthly limit',
                      hintText: '4000',
                    ),
                  ),
                  const SizedBox(height: 14),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: () async {
                        final category = categoryCtrl.text.trim();
                        final amount = double.tryParse(amountCtrl.text.trim());
                        if (category.isEmpty || amount == null || amount <= 0) {
                          Get.snackbar(
                            'Invalid Input',
                            'Enter a valid category and amount.',
                          );
                          return;
                        }
                        await controller.upsertBudget(category, amount);
                        if (bottomSheetContext.mounted) {
                          Navigator.of(bottomSheetContext).pop();
                        }
                      },
                      child: const Text('Save'),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    } finally {
      categoryCtrl.dispose();
      amountCtrl.dispose();
    }
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
