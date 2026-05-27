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
import 'package:spend_analytics/shared/widgets/txn_row.dart';

class DashboardScreen extends GetView<DashboardController> {
  const DashboardScreen({super.key});

  static const double _budget = 40000;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return LiquidPageScaffold(
      title:        'Spend Analytics',
      activeRoute:  AppRoutes.dashboard,
      actions: <Widget>[
        BarActionButton(
          icon:  Icons.notifications_outlined,
          onTap: () => Get.toNamed(AppRoutes.notifications),
        ),
        const SizedBox(width: 4),
        BarActionButton(
          icon:  Icons.settings_outlined,
          onTap: () => Get.toNamed(AppRoutes.settings),
        ),
      ],
      child: Obx(() {
        final spend     = controller.monthlySpend.value;
        final remaining = (_budget - spend).clamp(0.0, _budget);
        final usage     = (_budget == 0 ? 0.0 : spend / _budget).clamp(0.0, 1.0);
        final txns      = controller.transactions;

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
                      icon:  Icons.cloud_off_rounded,
                      color: scheme.error.withValues(alpha: 0.8),
                      size:  36,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('Guest mode', style: Theme.of(context).textTheme.titleSmall),
                          Text(
                            'Sign in to sync to your other devices.',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: scheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                    FilledButton(
                      onPressed: () => Get.offAllNamed(AppRoutes.login),
                      style: FilledButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                        shape: const StadiumBorder(),
                        textStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
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
                    'Good morning ☕',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    "You're tracking nicely.",
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color:      scheme.onSurface,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),

            // ── Hero balance card ─────────────────────────────────
            LiquidGlassSurface(
              padding:      const EdgeInsets.all(20),
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
                            'MAY 2026 · SPENT',
                            style: TextStyle(
                              fontSize:      10,
                              fontWeight:    FontWeight.w700,
                              letterSpacing: 1.1,
                              color:         scheme.onSurfaceVariant,
                            ),
                          ),
                          const SizedBox(height: 6),
                          RichText(
                            text: TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                                  text: formatInr(spend),
                                  style: TextStyle(
                                    fontSize:   38,
                                    fontWeight: FontWeight.w800,
                                    color:      scheme.onSurface,
                                    letterSpacing: -1.2,
                                    fontFeatures: const <FontFeature>[FontFeature.tabularFigures()],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SAPill(
                        label: '12%',
                        color: scheme.tertiary,
                        icon:  Icons.arrow_downward_rounded,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SAProgressBar(value: usage, color: scheme.primary, height: 8),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        '${(usage * 100).toStringAsFixed(0)}% of ${formatInr(_budget)} budget',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: scheme.onSurfaceVariant,
                        ),
                      ),
                      Text(
                        '${formatInr(remaining)} left',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color:      scheme.tertiary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 14),

            // ── Quick stat row ────────────────────────────────────
            Row(
              children: <Widget>[
                Expanded(
                  child: _StatCard(
                    icon:  Icons.trending_up_rounded,
                    color: scheme.tertiary,
                    label: 'Income',
                    value: '₹85,000',
                    sub:   'May',
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _StatCard(
                    icon:  Icons.receipt_long_rounded,
                    color: scheme.secondary,
                    label: 'Avg/day',
                    value: '₹820',
                    sub:   'last 7d',
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // ── Quick add ─────────────────────────────────────────
            _SectionHeader(title: 'Quick add'),
            const SizedBox(height: 10),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: Row(
                children: <Widget>[
                  _QuickAdd(icon: Icons.mic_rounded,       label: 'Voice',     color: scheme.primary,   onTap: () => Get.toNamed(AppRoutes.voiceInput)),
                  const SizedBox(width: 10),
                  _QuickAdd(icon: Icons.qr_code_scanner_rounded, label: 'Scan QR', color: scheme.secondary, onTap: () {}),
                  const SizedBox(width: 10),
                  _QuickAdd(icon: Icons.receipt_long_rounded, label: 'Receipt',  color: scheme.tertiary,  onTap: () {}),
                  const SizedBox(width: 10),
                  _QuickAdd(icon: Icons.repeat_rounded,    label: 'Recurring', color: const Color(0xFFFFB860), onTap: () => Get.toNamed(AppRoutes.recurring)),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // ── Recent transactions ───────────────────────────────
            _SectionHeader(title: 'Today', action: 'See all', onAction: () => Get.toNamed(AppRoutes.txns)),
            const SizedBox(height: 10),
            LiquidGlassSurface(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: txns.isEmpty
                  ? Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Text(
                        'No transactions yet. Add one to start tracking.',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: scheme.onSurfaceVariant,
                        ),
                      ),
                    )
                  : Column(
                      children: List<Widget>.generate(
                        txns.take(4).length,
                        (i) {
                          final txn    = txns[i];
                          final isLast = i == txns.take(4).length - 1;
                          return TxnRow(
                            data: TransactionRowData(
                              merchant:  txn.category,
                              category:  txn.category,
                              icon:      _iconFor(txn.category),
                              iconColor: _colorFor(txn.category),
                              amount:    txn.amount,
                              time:      _formatTime(txn.transactionDate),
                              isIncome:  txn.type == 'income',
                              mode:      txn.paymentMode,
                            ),
                            showDivider: !isLast,
                            onTap: () => Get.toNamed(
                              AppRoutes.txnDetail,
                              arguments: txn,
                            ),
                          );
                        },
                      ),
                    ),
            ),

            const SizedBox(height: 20),

            // ── Top budgets ───────────────────────────────────────
            _SectionHeader(title: 'Top budgets', action: 'Manage', onAction: () => Get.toNamed(AppRoutes.budgets)),
            const SizedBox(height: 10),
            LiquidGlassSurface(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: <_BudgetRow>[
                  _BudgetRow(icon: Icons.coffee_rounded,         color: const Color(0xFFFF9F40), name: 'Food',      used: 2840, limit: 4000),
                  _BudgetRow(icon: Icons.directions_car_rounded, color: const Color(0xFF5B9FFF), name: 'Transport', used: 1620, limit: 2500),
                  _BudgetRow(icon: Icons.shopping_bag_rounded,   color: const Color(0xFFB0A0FF), name: 'Shopping',  used: 3450, limit: 3000, isLast: true),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }

  IconData _iconFor(String category) {
    switch (category.toLowerCase()) {
      case 'food':      return Icons.coffee_rounded;
      case 'transport': return Icons.directions_car_rounded;
      case 'shopping':  return Icons.shopping_bag_rounded;
      case 'health':    return Icons.favorite_rounded;
      case 'bills':     return Icons.bolt_rounded;
      case 'income':    return Icons.arrow_downward_rounded;
      default:          return Icons.paid_rounded;
    }
  }

  Color _colorFor(String category) {
    switch (category.toLowerCase()) {
      case 'food':      return const Color(0xFFFF9F40);
      case 'transport': return const Color(0xFF5B9FFF);
      case 'shopping':  return const Color(0xFFB0A0FF);
      case 'health':    return const Color(0xFFFF6B6B);
      case 'bills':     return const Color(0xFFFFB860);
      case 'income':    return const Color(0xFF3FDDA0);
      default:          return const Color(0xFF5B9FFF);
    }
  }

  String _formatTime(DateTime d) {
    final h  = d.hour % 12 == 0 ? 12 : d.hour % 12;
    final m  = d.minute.toString().padLeft(2, '0');
    final ap = d.hour < 12 ? 'AM' : 'PM';
    return '$h:$m $ap';
  }
}

// ── Sub-widgets ───────────────────────────────────────────────────────────────

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title, this.action, this.onAction});
  final String   title;
  final String?  action;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Row(
      children: <Widget>[
        Text(
          title.toUpperCase(),
          style: TextStyle(
            fontSize:      12,
            fontWeight:    FontWeight.w700,
            letterSpacing: 0.8,
            color:         scheme.onSurfaceVariant,
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
                    fontSize:   12,
                    fontWeight: FontWeight.w700,
                    color:      scheme.primary,
                  ),
                ),
                Icon(Icons.chevron_right_rounded, size: 14, color: scheme.primary),
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
  final Color    color;
  final String   label;
  final String   value;
  final String   sub;

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
              Icon(Icons.chevron_right_rounded, size: 14, color: scheme.onSurfaceVariant),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            label.toUpperCase(),
            style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, letterSpacing: 1.1, color: scheme.onSurfaceVariant),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: TextStyle(
              fontSize:   22,
              fontWeight: FontWeight.w800,
              color:      scheme.onSurface,
              letterSpacing: -0.5,
              fontFeatures: const <FontFeature>[FontFeature.tabularFigures()],
            ),
          ),
          Text(
            sub,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(color: scheme.onSurfaceVariant),
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
  final IconData     icon;
  final String       label;
  final Color        color;
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
                  fontSize:   12,
                  fontWeight: FontWeight.w700,
                  color:      scheme.onSurface,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BudgetRow extends StatelessWidget {
  const _BudgetRow({
    required this.icon,
    required this.color,
    required this.name,
    required this.used,
    required this.limit,
    this.isLast = false,
  });
  final IconData icon;
  final Color    color;
  final String   name;
  final double   used;
  final double   limit;
  final bool     isLast;

  @override
  Widget build(BuildContext context) {
    final scheme  = Theme.of(context).colorScheme;
    final isDark   = Theme.of(context).brightness == Brightness.dark;
    final pct      = (used / limit).clamp(0.0, 1.1);
    final barColor = pct >= 1.0 ? scheme.error : pct > 0.8 ? scheme.error.withValues(alpha: 0.7) : scheme.tertiary;

    return Container(
      decoration: isLast
          ? null
          : BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: isDark
                      ? Colors.white.withValues(alpha: 0.08)
                      : Colors.black.withValues(alpha: 0.06),
                  width: 0.5,
                ),
              ),
            ),
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: <Widget>[
          IconBox(icon: icon, color: color, size: 32),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      name,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color:      scheme.onSurface,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      '${formatInr(used)} / ${formatInr(limit)}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                SAProgressBar(value: pct.clamp(0.0, 1.0), color: barColor),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
