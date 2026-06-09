import 'package:flutter/material.dart';

class AnalyticsCategorySlice {
  const AnalyticsCategorySlice({
    required this.name,
    required this.color,
    required this.pct,
    required this.amount,
  });

  final String name;
  final Color color;
  final double pct;
  final double amount;
}

class AnalyticsMerchant {
  const AnalyticsMerchant({
    required this.name,
    required this.category,
    required this.txns,
    required this.amount,
    required this.icon,
    required this.color,
  });

  final String name;
  final String category;
  final int txns;
  final double amount;
  final IconData icon;
  final Color color;
}

class ReportsData {
  const ReportsData({
    required this.selectedRange,
    required this.trendValues,
    required this.trendLabels,
    required this.categorySlices,
    required this.topMerchants,
    required this.insightText,
    required this.totalSpent,
    required this.totalIncome,
    required this.netFlow,
    required this.deltaPct,
    required this.deltaIsUp,
  });

  final String selectedRange;
  final List<double> trendValues;
  final List<String> trendLabels;
  final List<AnalyticsCategorySlice> categorySlices;
  final List<AnalyticsMerchant> topMerchants;
  final String insightText;
  final double totalSpent;
  final double totalIncome;
  final double netFlow;
  final double deltaPct;
  final bool deltaIsUp;

  static ReportsData empty(String range) => ReportsData(
        selectedRange: range,
        trendValues: const [],
        trendLabels: const [],
        categorySlices: const [],
        topMerchants: const [],
        insightText: '',
        totalSpent: 0,
        totalIncome: 0,
        netFlow: 0,
        deltaPct: 0,
        deltaIsUp: true,
      );
}
