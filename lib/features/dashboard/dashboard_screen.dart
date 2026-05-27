import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spend_analytics/core/routes/app_routes.dart';
import 'package:spend_analytics/features/dashboard/dashboard_controller.dart';
import 'package:spend_analytics/shared/utils/currency_formatter.dart';
import 'package:spend_analytics/shared/widgets/icon_box.dart';
import 'package:spend_analytics/shared/widgets/liquid_glass_surface.dart';
import 'package:spend_analytics/shared/widgets/liquid_page_scaffold.dart';
import 'package:spend_analytics/shared/widgets/sa_pill.dart';
import 'package:spend_analytics/shared/widgets/sa_progress_bar.dart';
import 'package:spend_analytics/shared/widgets/sa_shimmer.dart';
import 'package:spend_analytics/shared/widgets/txn_row.dart';

class DashboardScreen extends GetView<DashboardController> {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return LiquidPageScaffold(
      title: 'Spend Analytics',
      activeRoute: AppRoutes.dashboard,
      actions: <Widget>[
        BarActionButton(
          icon: Icons.notifications_outlined,
          onTap: () => Get.toNamed(AppRoutes.notifications),
        ),
        const SizedBox(width: 4),
        BarActionButton(
          icon: Icons.settings_outlined,
          onTap: () => Get.toNamed(AppRoutes.settings),
        ),
      ],
      child: Obx(() {
        if (controller.isLoading.value) {
          return const _DashboardLoadingSkeleton();
        }
        final now = DateTime.now();
        final txns = controller.transactions;
        final monthTxns = txns
            .where(
              (t) =>
                  t.transactionDate.month == now.month &&
                  t.transactionDate.year == now.year,
            )
            .toList(growable: false);
        final spend = monthTxns
            .where((t) => t.type == 'expense')
            .fold<double>(0, (sum, t) => sum + t.amount);
        final income = monthTxns
            .where((t) => t.type == 'income')
            .fold<double>(0, (sum, t) => sum + t.amount);
        final budgetBase = income > 0 ? income : (spend > 0 ? spend : 1);
        final remaining = (budgetBase - spend);
        final usage = (spend / budgetBase).clamp(0.0, 1.0);
        final daysInMonth = DateTime(now.year, now.month + 1, 0).day;
        final avgPerDay = now.day == 0 ? 0.0 : spend / now.day;
        final byCategory = <String, double>{};
        for (final txn in monthTxns.where((t) => t.type == 'expense')) {
          byCategory.update(
            txn.category,
            (value) => value + txn.amount,
            ifAbsent: () => txn.amount,
          );
        }
        final topCategories = byCategory.entries.toList(growable: false)
          ..sort((a, b) => b.value.compareTo(a.value));

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // ── Guest banner ──────────────────────────────────────
            if (controller.isGuestMode.value) ...<Widget>[
              LiquidGlassSurface(
                padding: const EdgeInsets.all(14),
                child: Row(
                  children: <Widget>[
                    IconBox(
                      icon: Icons.cloud_off_rounded,
                      color: scheme.error.withValues(alpha: 0.8),
                      size: 36,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Guest mode',
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          Text(
                            'Sign in to sync to your other devices.',
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(color: scheme.onSurfaceVariant),
                          ),
                        ],
                      ),
                    ),
                    FilledButton(
                      onPressed: () => Get.offAllNamed(AppRoutes.login),
                      style: FilledButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 8,
                        ),
                        shape: const StadiumBorder(),
                        textStyle: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      child: const Text('Sync now'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ],

            // ── Greeting ─────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.only(left: 4, bottom: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Dashboard overview',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '${_greetingForHour(now.hour)}, ${controller.firstName.value}',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: scheme.onSurface,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),

            // ── Hero balance card ─────────────────────────────────
            LiquidGlassSurface(
              padding: const EdgeInsets.all(20),
              borderRadius: const BorderRadius.all(Radius.circular(24)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            '${_monthLabel(now)} · SPENT',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1.1,
                              color: scheme.onSurfaceVariant,
                            ),
                          ),
                          const SizedBox(height: 6),
                          RichText(
                            text: TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                                  text: formatInr(spend),
                                  style: TextStyle(
                                    fontSize: 38,
                                    fontWeight: FontWeight.w800,
                                    color: scheme.onSurface,
                                    letterSpacing: -1.2,
                                    fontFeatures: const <FontFeature>[
                                      FontFeature.tabularFigures(),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SAPill(
                        label: '${monthTxns.length} txns',
                        color: scheme.primary,
                        icon: Icons.receipt_long_rounded,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SAProgressBar(value: usage, color: scheme.primary, height: 8),
                  const SizedBox(height: 10),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final leadText =
                          income > 0
                              ? '${(usage * 100).toStringAsFixed(0)}% of ${formatInr(income)} income'
                              : 'Track income to compare against spend';
                      final trailText =
                          remaining >= 0
                              ? '${formatInr(remaining)} left'
                              : '${formatInr(remaining.abs())} over';

                      if (constraints.maxWidth < 330) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              leadText,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(color: scheme.onSurfaceVariant),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              trailText,
                              style: Theme.of(
                                context,
                              ).textTheme.titleSmall?.copyWith(
                                color:
                                    remaining >= 0
                                        ? scheme.tertiary
                                        : scheme.error,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        );
                      }

                      return Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              leadText,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(color: scheme.onSurfaceVariant),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            trailText,
                            style: Theme.of(
                              context,
                            ).textTheme.titleSmall?.copyWith(
                              color:
                                  remaining >= 0
                                      ? scheme.tertiary
                                      : scheme.error,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 14),

            // ── Quick stat row ────────────────────────────────────
            LayoutBuilder(
              builder: (context, constraints) {
                final isWide = constraints.maxWidth >= 620;
                final incomeCard = _StatCard(
                  icon: Icons.trending_up_rounded,
                  color: scheme.tertiary,
                  label: 'Income',
                  value: formatInr(income),
                  sub: _monthLabel(now),
                );
                final avgCard = _StatCard(
                  icon: Icons.receipt_long_rounded,
                  color: scheme.secondary,
                  label: 'Avg/day',
                  value: formatInr(avgPerDay),
                  sub: '${now.day}/$daysInMonth days',
                );
                if (isWide) {
                  return Row(
                    children: <Widget>[
                      Expanded(child: incomeCard),
                      const SizedBox(width: 12),
                      Expanded(child: avgCard),
                    ],
                  );
                }
                return Column(
                  children: <Widget>[
                    incomeCard,
                    const SizedBox(height: 12),
                    avgCard,
                  ],
                );
              },
            ),

            const SizedBox(height: 20),

            // ── Quick add ─────────────────────────────────────────
            _SectionHeader(title: 'Quick add'),
            const SizedBox(height: 10),
            LayoutBuilder(
              builder: (context, constraints) {
                final options = <Widget>[
                  _QuickAdd(
                    icon: Icons.edit_note_rounded,
                    label: 'Manual',
                    color: scheme.primary,
                    onTap: () => Get.toNamed(AppRoutes.addTxn),
                  ),
                  _QuickAdd(
                    icon: Icons.mic_rounded,
                    label: 'Voice',
                    color: scheme.secondary,
                    onTap: () => Get.toNamed(AppRoutes.voiceReview),
                  ),
                  _QuickAdd(
                    icon: Icons.category_rounded,
                    label: 'Category',
                    color: scheme.tertiary,
                    onTap: () => Get.toNamed(AppRoutes.categories),
                  ),
                  _QuickAdd(
                    icon: Icons.repeat_rounded,
                    label: 'Recurring',
                    color: const Color(0xFFFFB860),
                    onTap: () => Get.toNamed(AppRoutes.recurring),
                  ),
                ];
                if (constraints.maxWidth < 500) {
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    child: Row(
                      children: options
                          .map(
                            (item) => Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: item,
                            ),
                          )
                          .toList(growable: false),
                    ),
                  );
                }
                return Wrap(spacing: 10, runSpacing: 10, children: options);
              },
            ),

            const SizedBox(height: 20),

            // ── Recent transactions ───────────────────────────────
            _SectionHeader(
              title: 'Today',
              action: 'See all',
              onAction: () => Get.toNamed(AppRoutes.txns),
            ),
            const SizedBox(height: 10),
            LiquidGlassSurface(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child:
                  txns.isEmpty
                      ? Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: Text(
                          'No transactions yet. Add one to start tracking.',
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(color: scheme.onSurfaceVariant),
                        ),
                      )
                      : Column(
                        children: List<Widget>.generate(txns.take(4).length, (
                          i,
                        ) {
                          final txn = txns[i];
                          final isLast = i == txns.take(4).length - 1;
                          return TxnRow(
                            data: TransactionRowData(
                              merchant: txn.category,
                              category: txn.category,
                              icon: _iconFor(txn.category),
                              iconColor: _colorFor(txn.category),
                              amount: txn.amount,
                              time: _formatTime(txn.transactionDate),
                              isIncome: txn.type == 'income',
                              mode: txn.paymentMode,
                            ),
                            showDivider: !isLast,
                            onTap:
                                () => Get.toNamed(
                                  AppRoutes.txnDetail,
                                  arguments: txn,
                                ),
                          );
                        }),
                      ),
            ),

            const SizedBox(height: 20),

            // ── Top categories ────────────────────────────────────
            _SectionHeader(
              title: 'Top categories',
              action: 'Manage budgets',
              onAction: () => Get.toNamed(AppRoutes.budgets),
            ),
            const SizedBox(height: 10),
            LiquidGlassSurface(
              padding: const EdgeInsets.all(16),
              child:
                  topCategories.isEmpty
                      ? Text(
                        'No category spends yet for this month.',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: scheme.onSurfaceVariant,
                        ),
                      )
                      : Column(
                        children: List<Widget>.generate(
                          topCategories.take(3).length,
                          (i) {
                            final item = topCategories[i];
                            final isLast =
                                i == topCategories.take(3).length - 1;
                            return Container(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              decoration:
                                  isLast
                                      ? null
                                      : BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                            color: scheme.outline.withValues(
                                              alpha: 0.2,
                                            ),
                                            width: 0.5,
                                          ),
                                        ),
                                      ),
                              child: Row(
                                children: <Widget>[
                                  IconBox(
                                    icon: _iconFor(item.key),
                                    color: _colorFor(item.key),
                                    size: 32,
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      item.key,
                                      style: Theme.of(
                                        context,
                                      ).textTheme.titleSmall?.copyWith(
                                        color: scheme.onSurface,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    formatInr(item.value),
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodyMedium?.copyWith(
                                      color: scheme.onSurfaceVariant,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
            ),
          ],
        );
      }),
    );
  }

  IconData _iconFor(String category) {
    switch (category.toLowerCase()) {
      case 'food':
        return Icons.coffee_rounded;
      case 'transport':
        return Icons.directions_car_rounded;
      case 'shopping':
        return Icons.shopping_bag_rounded;
      case 'health':
        return Icons.favorite_rounded;
      case 'bills':
        return Icons.bolt_rounded;
      case 'income':
        return Icons.arrow_downward_rounded;
      default:
        return Icons.paid_rounded;
    }
  }

  Color _colorFor(String category) {
    switch (category.toLowerCase()) {
      case 'food':
        return const Color(0xFFFF9F40);
      case 'transport':
        return const Color(0xFF5B9FFF);
      case 'shopping':
        return const Color(0xFFB0A0FF);
      case 'health':
        return const Color(0xFFFF6B6B);
      case 'bills':
        return const Color(0xFFFFB860);
      case 'income':
        return const Color(0xFF3FDDA0);
      default:
        return const Color(0xFF5B9FFF);
    }
  }

  String _formatTime(DateTime d) {
    final h = d.hour % 12 == 0 ? 12 : d.hour % 12;
    final m = d.minute.toString().padLeft(2, '0');
    final ap = d.hour < 12 ? 'AM' : 'PM';
    return '$h:$m $ap';
  }

  String _greetingForHour(int hour) {
    if (hour < 12) return 'Good morning';
    if (hour < 17) return 'Good afternoon';
    if (hour < 21) return 'Good evening';
    return 'Good night';
  }

  String _monthLabel(DateTime d) {
    const months = <String>[
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${months[d.month - 1]} ${d.year}';
  }
}

// ── Sub-widgets ───────────────────────────────────────────────────────────────

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title, this.action, this.onAction});
  final String title;
  final String? action;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Row(
      children: <Widget>[
        Text(
          title.toUpperCase(),
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.8,
            color: scheme.onSurfaceVariant,
          ),
        ),
        const Spacer(),
        if (action != null)
          GestureDetector(
            onTap: onAction,
            child: Row(
              children: <Widget>[
                Text(
                  action!,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: scheme.primary,
                  ),
                ),
                Icon(
                  Icons.chevron_right_rounded,
                  size: 14,
                  color: scheme.primary,
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.icon,
    required this.color,
    required this.label,
    required this.value,
    required this.sub,
  });
  final IconData icon;
  final Color color;
  final String label;
  final String value;
  final String sub;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return LiquidGlassSurface(
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconBox(icon: icon, color: color, size: 32),
              Icon(
                Icons.chevron_right_rounded,
                size: 14,
                color: scheme.onSurfaceVariant,
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            label.toUpperCase(),
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.1,
              color: scheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: scheme.onSurface,
              letterSpacing: -0.5,
              fontFeatures: const <FontFeature>[FontFeature.tabularFigures()],
            ),
          ),
          Text(
            sub,
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: scheme.onSurfaceVariant),
          ),
        ],
      ),
    );
  }
}

class _QuickAdd extends StatelessWidget {
  const _QuickAdd({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: onTap,
      child: LiquidGlassSurface(
        padding: const EdgeInsets.all(12),
        child: SizedBox(
          width: 76,
          child: Column(
            children: <Widget>[
              IconBox(icon: icon, color: color, size: 36),
              const SizedBox(height: 8),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: scheme.onSurface,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DashboardLoadingSkeleton extends StatelessWidget {
  const _DashboardLoadingSkeleton();

  @override
  Widget build(BuildContext context) {
    return SAShimmer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: const <Widget>[
          SAShimmerBox(height: 20, width: 180, radius: 8),
          SizedBox(height: 8),
          SAShimmerBox(height: 32, width: 260, radius: 10),
          SizedBox(height: 12),
          SAShimmerBox(height: 210, radius: 24),
          SizedBox(height: 14),
          SAShimmerBox(height: 110, radius: 20),
          SizedBox(height: 12),
          SAShimmerBox(height: 110, radius: 20),
          SizedBox(height: 20),
          SAShimmerBox(height: 16, width: 120, radius: 8),
          SizedBox(height: 10),
          SAShimmerBox(height: 88, radius: 18),
          SizedBox(height: 10),
          SAShimmerBox(height: 88, radius: 18),
        ],
      ),
    );
  }
}
