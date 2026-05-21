import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spend_analytics/features/analytics/analytics_controller.dart';

class AnalyticsScreen extends GetView<AnalyticsController> {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Analytics')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Obx(
          () => LineChart(
            LineChartData(
              lineBarsData: <LineChartBarData>[
                LineChartBarData(
                  spots: controller.monthlyTrend
                      .asMap()
                      .entries
                      .map((e) => FlSpot(e.key.toDouble(), e.value))
                      .toList(),
                  isCurved: true,
                  barWidth: 3,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
