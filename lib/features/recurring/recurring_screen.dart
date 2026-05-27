import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spend_analytics/features/recurring/recurring_controller.dart';
import 'package:spend_analytics/shared/widgets/icon_box.dart';
import 'package:spend_analytics/shared/widgets/liquid_glass_surface.dart';
import 'package:spend_analytics/shared/widgets/liquid_page_scaffold.dart';
import 'package:spend_analytics/shared/widgets/sa_progress_bar.dart';

class RecurringScreen extends GetView<RecurringController> {
  const RecurringScreen({super.key});

  static const _icons = <String, IconData>{
    'Netflix':          Icons.play_circle_outline_rounded,
    'Rent':             Icons.home_rounded,
    'Phone Recharge':   Icons.phone_android_rounded,
    'Spotify':          Icons.music_note_rounded,
    'Amazon Prime':     Icons.local_shipping_rounded,
    'Electricity Bill': Icons.bolt_rounded,
  };

  static const _colors = <String, Color>{
    'Netflix':          Color(0xFFFF6B6B),
    'Rent':             Color(0xFF5B9FFF),
    'Phone Recharge':   Color(0xFF3FDDA0),
    'Spotify':          Color(0xFF3FDDA0),
    'Amazon Prime':     Color(0xFFFF9F40),
    'Electricity Bill': Color(0xFFFFB860),
  };

  static const _amounts = <String, int>{
    'Netflix':          649,
    'Rent':             15000,
    'Phone Recharge':   299,
    'Spotify':          119,
    'Amazon Prime':     1499,
    'Electricity Bill': 1200,
  };

  String _baseName(String item) => item.contains('•')
      ? item.split('•').first.trim()
      : item;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isDark  = Theme.of(context).brightness == Brightness.dark;

    // Month progress
    final now       = DateTime.now();
    final daysInMonth = DateTime(now.year, now.month + 1, 0).day;
    final monthPct  = now.day / daysInMonth;

    return LiquidPageScaffold(
      title:         'Recurring',
      showBottomNav: false,
      onBack:        () => Get.back<void>(),
      actions: <Widget>[
        BarActionButton(
          icon:  Icons.add_rounded,
          onTap: () => Get.snackbar(
            'Coming soon',
            'Add recurring will be available soon.',
            duration: const Duration(seconds: 2),
          ),
        ),
      ],
      child: Obx(() {
        final items = controller.recurringItems;

        // Compute total monthly recurring
        int totalMonthly = 0;
        for (final item in items) {
          final base = _baseName(item);
          totalMonthly += _amounts[base] ?? 0;
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[

            // ── Summary card ─────────────────────────────────
            LiquidGlassSurface(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Monthly Recurring',
                        style: TextStyle(
                          fontSize:   12,
                          fontWeight: FontWeight.w700,
                          color:      scheme.onSurfaceVariant,
                        ),
                      ),
                      Text(
                        '${now.day}/${daysInMonth} days',
                        style: TextStyle(
                          fontSize: 12,
                          color:    scheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '₹$totalMonthly',
                    style: TextStyle(
                      fontSize:   32,
                      fontWeight: FontWeight.w800,
                      color:      scheme.onSurface,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${items.length} active subscriptions',
                    style: TextStyle(
                      fontSize: 13,
                      color:    scheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Month progress bar
                  SAProgressBar(
                    value:  monthPct,
                    color:  scheme.primary,
                    height: 6,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '${(monthPct * 100).toStringAsFixed(0)}% through month',
                    style: TextStyle(
                      fontSize: 11,
                      color:    scheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            Text(
              'SUBSCRIPTIONS',
              style: TextStyle(
                fontSize:      11,
                fontWeight:    FontWeight.w700,
                letterSpacing: 0.8,
                color:         scheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 10),

            // ── Recurring items list ──────────────────────────
            LiquidGlassSurface(
              padding: EdgeInsets.zero,
              child: Column(
                children: List<Widget>.generate(items.length, (i) {
                  final item   = items[i];
                  final base   = _baseName(item);
                  final isLast = i == items.length - 1;
                  final color  = _colors[base] ?? const Color(0xFF5B9FFF);
                  final icon   = _icons[base]  ?? Icons.repeat_rounded;
                  final amount = _amounts[base] ?? 0;

                  // Days until next billing (mock: renews on day 1 of next month)
                  final daysLeft = daysInMonth - now.day + 1;

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
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical:   14,
                    ),
                    child: Row(
                      children: <Widget>[
                        IconBox(icon: icon, color: color, size: 42),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                base,
                                style: TextStyle(
                                  fontSize:   14,
                                  fontWeight: FontWeight.w700,
                                  color:      scheme.onSurface,
                                ),
                              ),
                              const SizedBox(height: 3),
                              Text(
                                'Renews in $daysLeft days • Monthly',
                                style: TextStyle(
                                  fontSize: 12,
                                  color:    scheme.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              '₹$amount',
                              style: TextStyle(
                                fontSize:   15,
                                fontWeight: FontWeight.w800,
                                color:      scheme.onSurface,
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              '/month',
                              style: TextStyle(
                                fontSize: 11,
                                color:    scheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ),

            const SizedBox(height: 20),
          ],
        );
      }),
    );
  }
}
