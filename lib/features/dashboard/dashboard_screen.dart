import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:spend_analytics/core/routes/app_routes.dart';
import 'package:spend_analytics/features/dashboard/dashboard_controller.dart';
import 'package:spend_analytics/shared/models/transaction_model.dart';
import 'package:spend_analytics/shared/utils/currency_formatter.dart';
import 'package:spend_analytics/shared/widgets/liquid_glass_surface.dart';
import 'package:spend_analytics/shared/widgets/liquid_page_scaffold.dart';

class DashboardScreen extends GetView<DashboardController> {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const monthlyBudget = 20000.0;
    final scheme = Theme.of(context).colorScheme;

    return Obx(() {
      final spend = controller.monthlySpend.value;
      final remaining =
          (monthlyBudget - spend).clamp(0.0, monthlyBudget).toDouble();
      final usage =
          monthlyBudget == 0 ? 0.0 : (spend / monthlyBudget).clamp(0.0, 1.0);
      final categories = _categoryBreakdown(controller.transactions);

      return LiquidPageScaffold(
        title: 'Dashboard',
        activeRoute: AppRoutes.dashboard,
        actions: <Widget>[
          IconButton(
            onPressed: () => Get.toNamed(AppRoutes.settings),
            icon: const Icon(Icons.settings_rounded),
            color: scheme.onSurfaceVariant,
          ),
        ],
        floatingActionButton: FloatingActionButton(
          onPressed: () => Get.toNamed(AppRoutes.addTxn),
          backgroundColor: scheme.primaryContainer,
          foregroundColor: scheme.onPrimaryContainer,
          child: const Icon(Icons.add_rounded),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        child: Column(
          children: <Widget>[
            if (controller.isGuestMode.value) ...<Widget>[
              LiquidGlassSurface(
                child: Row(
                  children: <Widget>[
                    const Icon(Icons.cloud_off_rounded),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Guest mode active. Sign in with Google to sync and backup your data.',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                    TextButton(
                      onPressed: () => Get.offAllNamed(AppRoutes.login),
                      child: const Text('Sync Now'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
            ],
            LiquidGlassSurface(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    DateFormat('MMMM yyyy').format(DateTime.now()),
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      letterSpacing: 1.1,
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    formatInr(spend),
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      color: scheme.primary,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    'spent so far',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(999),
                    child: LinearProgressIndicator(
                      value: usage,
                      minHeight: 10,
                      backgroundColor: Colors.white.withValues(alpha: 0.08),
                      valueColor: AlwaysStoppedAnimation<Color>(
                        scheme.primaryContainer,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        '${(usage * 100).toStringAsFixed(0)}% used',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: scheme.onSurfaceVariant,
                        ),
                      ),
                      Text(
                        '${formatInr(remaining)} remaining',
                        style: Theme.of(
                          context,
                        ).textTheme.titleMedium?.copyWith(
                          color: scheme.tertiary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            Row(
              children: <Widget>[
                Expanded(
                  child: _RuleBadge(
                    icon: Icons.warning_amber_rounded,
                    title: 'Food budget 88%',
                    subtitle: 'Approaching category cap',
                    accent: scheme.error,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _RuleBadge(
                    icon: Icons.trending_up_rounded,
                    title: 'Shopping x2',
                    subtitle: 'Unusual weekly spike',
                    accent: scheme.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            LiquidGlassSurface(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => Get.toNamed(AppRoutes.notifications),
                      icon: const Icon(Icons.notifications_active_rounded),
                      label: const Text('Notifications'),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => Get.toNamed(AppRoutes.voiceReview),
                      icon: const Icon(Icons.mic_rounded),
                      label: const Text('Voice Review'),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            LiquidGlassSurface(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Spending by Category',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 10),
                  if (categories.isEmpty)
                    Text(
                      'No expense data yet.',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: scheme.onSurfaceVariant,
                      ),
                    )
                  else
                    ...categories.entries.take(4).map((entry) {
                      final amount = entry.value;
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: Row(
                          children: <Widget>[
                            Container(
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(
                                color: scheme.primary,
                                borderRadius: BorderRadius.circular(999),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                entry.key,
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            ),
                            Text(
                              formatInr(amount),
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                          ],
                        ),
                      );
                    }),
                ],
              ),
            ),
            const SizedBox(height: 14),
            LiquidGlassSurface(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                        'Recent Transactions',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () => Get.toNamed(AppRoutes.txns),
                        child: const Text('View all'),
                      ),
                    ],
                  ),
                  if (controller.transactions.isEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        'No transactions yet. Add one to start tracking.',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: scheme.onSurfaceVariant,
                        ),
                      ),
                    )
                  else
                    ...controller.transactions
                        .take(4)
                        .map(
                          (txn) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  width: 38,
                                  height: 38,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(alpha: 0.08),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    _iconForCategory(txn.category),
                                    size: 19,
                                    color: scheme.onSurfaceVariant,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        txn.category,
                                        style:
                                            Theme.of(
                                              context,
                                            ).textTheme.bodyLarge,
                                      ),
                                      Text(
                                        DateFormat(
                                          'dd MMM',
                                        ).format(txn.transactionDate),
                                        style: Theme.of(
                                          context,
                                        ).textTheme.bodySmall?.copyWith(
                                          color: scheme.onSurfaceVariant,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  '-${formatInr(txn.amount)}',
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                              ],
                            ),
                          ),
                        ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  Map<String, double> _categoryBreakdown(List<TransactionModel> txns) {
    final totals = <String, double>{};
    for (final txn in txns) {
      if (txn.type != 'expense') {
        continue;
      }
      totals.update(
        txn.category,
        (value) => value + txn.amount,
        ifAbsent: () => txn.amount,
      );
    }
    return Map<String, double>.fromEntries(
      totals.entries.toList()..sort((a, b) => b.value.compareTo(a.value)),
    );
  }

  IconData _iconForCategory(String category) {
    final normalized = category.toLowerCase();
    if (normalized.contains('food') || normalized.contains('dining')) {
      return Icons.restaurant_rounded;
    }
    if (normalized.contains('transport') || normalized.contains('petrol')) {
      return Icons.directions_car_rounded;
    }
    if (normalized.contains('shop')) {
      return Icons.shopping_bag_rounded;
    }
    if (normalized.contains('rent') || normalized.contains('bill')) {
      return Icons.receipt_long_rounded;
    }
    return Icons.paid_rounded;
  }
}

class _RuleBadge extends StatelessWidget {
  const _RuleBadge({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.accent,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return LiquidGlassSurface(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(icon, color: accent),
          const SizedBox(height: 8),
          Text(title, style: Theme.of(context).textTheme.titleSmall),
          const SizedBox(height: 2),
          Text(
            subtitle,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
