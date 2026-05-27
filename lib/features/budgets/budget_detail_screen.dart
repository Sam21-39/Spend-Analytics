import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spend_analytics/shared/utils/currency_formatter.dart';
import 'package:spend_analytics/shared/widgets/icon_box.dart';
import 'package:spend_analytics/shared/widgets/liquid_glass_surface.dart';
import 'package:spend_analytics/shared/widgets/liquid_page_scaffold.dart';
import 'package:spend_analytics/shared/widgets/sa_progress_bar.dart';
import 'package:spend_analytics/shared/widgets/txn_row.dart';

/// Budget detail — hero ring card, daily bar chart, recent transactions.
/// Expects a map via `Get.arguments`:
///   { 'name': String, 'icon': IconData, 'color': Color,
///     'used': double, 'limit': double }
class BudgetDetailScreen extends StatelessWidget {
  const BudgetDetailScreen({super.key});

  static const _dailyData = <double>[
    20, 12, 0, 35, 28, 12, 18, 24, 14, 26, 10, 16,
    32, 22, 18, 0,  28, 14, 18, 24, 16, 12, 20, 28, 14, 22, 0,
  ];

  @override
  Widget build(BuildContext context) {
    final args    = Get.arguments as Map<String, dynamic>? ?? <String, dynamic>{};
    final name    = args['name']  as String?   ?? 'Budget';
    final icon    = args['icon']  as IconData? ?? Icons.wallet_rounded;
    final color   = args['color'] as Color?    ?? Theme.of(context).colorScheme.primary;
    final used    = (args['used']  as num?)?.toDouble() ?? 0;
    final limit   = (args['limit'] as num?)?.toDouble() ?? 1;
    final pct     = (used / limit).clamp(0.0, 1.0);
    final daysLeft = 13;

    final scheme  = Theme.of(context).colorScheme;
    final barColor = pct >= 1.0 ? scheme.error
        : pct > 0.8 ? scheme.error.withValues(alpha: 0.8)
        : color;

    return LiquidPageScaffold(
      title:         '$name budget',
      showBottomNav: false,
      onBack:        () => Get.back<void>(),
      actions: <Widget>[
        BarActionButton(icon: Icons.edit_outlined, onTap: () {}),
        const SizedBox(width: 4),
        BarActionButton(icon: Icons.more_horiz_rounded, onTap: () {}),
      ],
      child: Column(
        children: <Widget>[
          // ── Hero card ─────────────────────────────────────────
          LiquidGlassSurface(
            padding:      const EdgeInsets.all(24),
            borderRadius: const BorderRadius.all(Radius.circular(24)),
            child: Column(
              children: <Widget>[
                IconBox(icon: icon, color: color, size: 56, radius: 18),
                const SizedBox(height: 14),
                Text(
                  'SPENT THIS MONTH',
                  style: TextStyle(
                    fontSize:      10,
                    fontWeight:    FontWeight.w700,
                    letterSpacing: 1.1,
                    color:         scheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  formatInr(used),
                  style: TextStyle(
                    fontSize:   40,
                    fontWeight: FontWeight.w800,
                    color:      scheme.onSurface,
                    letterSpacing: -1.2,
                    fontFeatures: const <FontFeature>[FontFeature.tabularFigures()],
                  ),
                ),
                const SizedBox(height: 4),
                RichText(
                  text: TextSpan(
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: scheme.onSurfaceVariant,
                    ),
                    children: <TextSpan>[
                      const TextSpan(text: 'of '),
                      TextSpan(
                        text: formatInr(limit),
                        style: TextStyle(
                          color:      scheme.onSurface,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      TextSpan(
                        text: ' · ${formatInr(limit - used)} left',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                SAProgressBar(value: pct, color: barColor, height: 10),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      '${(pct * 100).toStringAsFixed(0)}% used',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                    Text(
                      '$daysLeft days remaining',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // ── Daily bar chart ───────────────────────────────────
          LiquidGlassSurface(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "This month's daily spend",
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: scheme.onSurface,
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 80,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: List<Widget>.generate(
                      _dailyData.length,
                      (i) {
                        final v    = _dailyData[i];
                        final maxV = _dailyData.reduce((a, b) => a > b ? a : b);
                        final frac = maxV == 0 ? 0.0 : v / maxV;
                        return Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 1),
                            child: FractionallySizedBox(
                              alignment:   Alignment.bottomCenter,
                              heightFactor: frac.clamp(0.07, 1.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: i == 19
                                      ? scheme.primary
                                      : color.withValues(alpha: 0.5 + v / 70),
                                  borderRadius: BorderRadius.circular(3),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('1 May', style: Theme.of(context).textTheme.bodySmall?.copyWith(color: scheme.onSurfaceVariant)),
                    Text('15 May', style: Theme.of(context).textTheme.bodySmall?.copyWith(color: scheme.onSurfaceVariant)),
                    Text('27 May', style: Theme.of(context).textTheme.bodySmall?.copyWith(color: scheme.onSurfaceVariant)),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // ── Recent transactions header ─────────────────────────
          Row(
            children: <Widget>[
              Text(
                'RECENT TRANSACTIONS',
                style: TextStyle(
                  fontSize:      12,
                  fontWeight:    FontWeight.w700,
                  letterSpacing: 0.8,
                  color:         scheme.onSurfaceVariant,
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: () {},
                child: const Text('All'),
              ),
            ],
          ),

          LiquidGlassSurface(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              children: <Widget>[
                TxnRow(
                  data: TransactionRowData(
                    merchant:  'Blue Tokai',
                    category:  name,
                    icon:      icon,
                    iconColor: color,
                    amount:    320,
                    time:      '8:24 AM',
                    isIncome:  false,
                    mode:      'UPI',
                  ),
                ),
                TxnRow(
                  data: TransactionRowData(
                    merchant:  'Swiggy',
                    category:  name,
                    icon:      icon,
                    iconColor: color,
                    amount:    412,
                    time:      '8:50 PM',
                    isIncome:  false,
                    mode:      'UPI',
                  ),
                  showDivider: false,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
