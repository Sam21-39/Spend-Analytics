import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spend_analytics/core/routes/app_routes.dart';
import 'package:spend_analytics/features/analytics/analytics_controller.dart';
import 'package:spend_analytics/shared/widgets/liquid_glass_surface.dart';
import 'package:spend_analytics/shared/widgets/liquid_page_scaffold.dart';

class AnalyticsScreen extends GetView<AnalyticsController> {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return LiquidPageScaffold(
      title: 'Analytics',
      activeRoute: AppRoutes.analytics,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Your financial overview for this month',
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(color: scheme.onSurfaceVariant),
          ),
          const SizedBox(height: 14),
          Obx(() {
            final trend = controller.monthlyTrend;
            final total = trend.fold<double>(0, (sum, value) => sum + value);
            return LiquidGlassSurface(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Total Spent',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: <Widget>[
                      SizedBox(
                        width: 128,
                        height: 128,
                        child: PieChart(
                          PieChartData(
                            centerSpaceRadius: 34,
                            sectionsSpace: 2,
                            sections: _buildSections(total),
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Text(
                          '₹${(total / 1000).toStringAsFixed(1)}k\n12% vs last month',
                          style: Theme.of(
                            context,
                          ).textTheme.headlineSmall?.copyWith(
                            color: scheme.onSurface,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 10,
                    runSpacing: 8,
                    children: const <Widget>[
                      _Legend(color: Color(0xFF4B8EFF), label: 'Housing 45%'),
                      _Legend(color: Color(0xFF8382FF), label: 'Food 30%'),
                      _Legend(color: Color(0xFFDE0541), label: 'Transport 15%'),
                      _Legend(color: Color(0x66FFFFFF), label: 'Other 10%'),
                    ],
                  ),
                ],
              ),
            );
          }),
          const SizedBox(height: 14),
          Obx(
            () => LiquidGlassSurface(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Daily Spending',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 14),
                  SizedBox(
                    height: 180,
                    child: BarChart(
                      BarChartData(
                        borderData: FlBorderData(show: false),
                        gridData: const FlGridData(show: false),
                        titlesData: FlTitlesData(
                          leftTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          rightTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          topTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: (value, _) {
                                const labels = <String>[
                                  'M',
                                  'T',
                                  'W',
                                  'T',
                                  'F',
                                  'S',
                                ];
                                final index = value.toInt();
                                if (index < 0 || index >= labels.length) {
                                  return const SizedBox.shrink();
                                }
                                return Text(
                                  labels[index],
                                  style: Theme.of(context).textTheme.labelSmall,
                                );
                              },
                            ),
                          ),
                        ),
                        barGroups: controller.monthlyTrend
                            .asMap()
                            .entries
                            .map(
                              (e) => BarChartGroupData(
                                x: e.key,
                                barRods: <BarChartRodData>[
                                  BarChartRodData(
                                    toY: e.value,
                                    width: 16,
                                    borderRadius: BorderRadius.circular(8),
                                    color:
                                        e.key == 4
                                            ? const Color(0xFF8382FF)
                                            : const Color(0xCC4B8EFF),
                                  ),
                                ],
                              ),
                            )
                            .toList(growable: false),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 14),
          LiquidGlassSurface(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Top Transactions',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 10),
                ...const <
                  ({
                    IconData icon,
                    String title,
                    String subtitle,
                    String amount,
                  })
                >[
                  (
                    icon: Icons.shopping_cart_rounded,
                    title: 'Amazon Pantry',
                    subtitle: 'Oct 12 • Groceries',
                    amount: '-₹4,500',
                  ),
                  (
                    icon: Icons.restaurant_rounded,
                    title: 'Taj Mahal Palace',
                    subtitle: 'Oct 10 • Dining',
                    amount: '-₹3,200',
                  ),
                  (
                    icon: Icons.bolt_rounded,
                    title: 'MSEB Bill',
                    subtitle: 'Oct 05 • Utilities',
                    amount: '-₹2,150',
                  ),
                ].map(
                  (item) => ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: CircleAvatar(
                      backgroundColor: Colors.white.withValues(alpha: 0.08),
                      child: Icon(item.icon, color: scheme.primary),
                    ),
                    title: Text(item.title),
                    subtitle: Text(item.subtitle),
                    trailing: Text(item.amount),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> _buildSections(double total) {
    if (total <= 0) {
      return <PieChartSectionData>[
        PieChartSectionData(
          value: 100,
          color: const Color(0x33FFFFFF),
          showTitle: false,
          radius: 18,
        ),
      ];
    }

    return <PieChartSectionData>[
      PieChartSectionData(
        value: 45,
        color: const Color(0xFF4B8EFF),
        showTitle: false,
        radius: 18,
      ),
      PieChartSectionData(
        value: 30,
        color: const Color(0xFF8382FF),
        showTitle: false,
        radius: 18,
      ),
      PieChartSectionData(
        value: 15,
        color: const Color(0xFFDE0541),
        showTitle: false,
        radius: 18,
      ),
      PieChartSectionData(
        value: 10,
        color: const Color(0x55FFFFFF),
        showTitle: false,
        radius: 18,
      ),
    ];
  }
}

class _Legend extends StatelessWidget {
  const _Legend({required this.color, required this.label});

  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 6),
        Text(label, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }
}
