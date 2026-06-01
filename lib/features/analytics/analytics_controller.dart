import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spend_analytics/core/local_db/app_database.dart';
import 'package:spend_analytics/core/supabase/supabase_service.dart';
import 'package:spend_analytics/shared/models/transaction_model.dart';
import 'package:spend_analytics/shared/utils/category_visuals.dart';

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

class AnalyticsController extends GetxController {
  final AppDatabase _db = Get.find<AppDatabase>();
  final SupabaseService _supabase = Get.find<SupabaseService>();
  StreamSubscription<List<TransactionModel>>? _sub;
  late final String _activeUserId;

  static const ranges = <String>['Week', 'Month', '3 Months', 'Year', 'All'];

  final selectedRange = 'Month'.obs;
  final trendValues = <double>[].obs;
  final trendLabels = <String>[].obs;
  final categorySlices = <AnalyticsCategorySlice>[].obs;
  final topMerchants = <AnalyticsMerchant>[].obs;
  final insightText = ''.obs;

  final totalSpent = 0.0.obs;
  final totalIncome = 0.0.obs;
  final netFlow = 0.0.obs;
  final deltaPct = 0.0.obs;
  final deltaIsUp = true.obs;
  final isLoading = true.obs;

  final _allTransactions = <TransactionModel>[];

  @override
  void onInit() {
    super.onInit();
    _activeUserId =
        _supabase.isAuthenticated ? _supabase.currentUserId! : 'guest';
    _sub = _db.watchTransactionsForUser(_activeUserId).listen((rows) {
      _allTransactions
        ..clear()
        ..addAll(rows);
      _recompute();
      isLoading.value = false;
    });
  }

  void setRange(String range) {
    if (!ranges.contains(range) || selectedRange.value == range) {
      return;
    }
    selectedRange.value = range;
    _recompute();
  }

  void _recompute() {
    final now = DateTime.now();
    final current = _filteredTransactions(now);
    final previous = _filteredTransactions(_previousEndDate(now));

    final expenses = current.where((t) => t.type == 'expense').toList();
    final incomes = current.where((t) => t.type == 'income').toList();

    totalSpent.value = expenses.fold<double>(0, (s, t) => s + t.amount);
    totalIncome.value = incomes.fold<double>(0, (s, t) => s + t.amount);
    netFlow.value = totalIncome.value - totalSpent.value;

    final prevExpenses = previous
        .where((t) => t.type == 'expense')
        .fold<double>(0, (s, t) => s + t.amount);
    if (prevExpenses > 0) {
      final pct = ((totalSpent.value - prevExpenses) / prevExpenses) * 100;
      deltaPct.value = pct.abs();
      deltaIsUp.value = pct >= 0;
    } else {
      deltaPct.value = 0;
      deltaIsUp.value = true;
    }

    _computeTrend(current, now);
    _computeCategorySlices(expenses);
    _computeTopMerchants(expenses);
    _computeInsight(expenses, previous);
  }

  DateTime _previousEndDate(DateTime now) {
    final start = _rangeStart(now);
    final span = now.difference(start).inDays + 1;
    return start
        .subtract(const Duration(days: 1))
        .subtract(Duration(days: math.max(0, span - 1)));
  }

  List<TransactionModel> _filteredTransactions(DateTime now) {
    final start = _rangeStart(now);
    return _allTransactions
        .where((t) => !t.transactionDate.isBefore(start))
        .toList(growable: false);
  }

  DateTime _rangeStart(DateTime now) {
    switch (selectedRange.value) {
      case 'Week':
        final day = DateTime(now.year, now.month, now.day);
        return day.subtract(const Duration(days: 6));
      case 'Month':
        return DateTime(now.year, now.month, 1);
      case '3 Months':
        return DateTime(now.year, now.month - 2, 1);
      case 'Year':
        return DateTime(now.year, 1, 1);
      case 'All':
        if (_allTransactions.isEmpty) {
          return DateTime(now.year, now.month, 1);
        }
        final oldest = _allTransactions
            .map((t) => t.transactionDate)
            .reduce((a, b) => a.isBefore(b) ? a : b);
        return DateTime(oldest.year, oldest.month, 1);
    }
    return DateTime(now.year, now.month, 1);
  }

  void _computeTrend(List<TransactionModel> rows, DateTime now) {
    if (rows.isEmpty) {
      trendValues.assignAll(const <double>[0, 0, 0, 0, 0]);
      trendLabels.assignAll(const <String>['', '', '', '', '']);
      return;
    }

    if (selectedRange.value == 'Year' || selectedRange.value == 'All') {
      final start =
          selectedRange.value == 'Year'
              ? DateTime(now.year, 1, 1)
              : DateTime(now.year, now.month - 11, 1);
      final buckets = List<double>.filled(12, 0);
      for (final t in rows) {
        final monthIndex =
            (t.transactionDate.year - start.year) * 12 +
            (t.transactionDate.month - start.month);
        if (monthIndex < 0 || monthIndex >= 12) {
          continue;
        }
        final signed = t.type == 'income' ? t.amount : -t.amount;
        buckets[monthIndex] += signed;
      }
      trendValues.assignAll(
        buckets.map((v) => v.abs()).toList(growable: false),
      );
      trendLabels.assignAll(<String>[
        _monthShort(start.month),
        _monthShort(((start.month + 2 - 1) % 12) + 1),
        _monthShort(((start.month + 5 - 1) % 12) + 1),
        _monthShort(((start.month + 8 - 1) % 12) + 1),
        _monthShort(((start.month + 11 - 1) % 12) + 1),
      ]);
      return;
    }

    final start = _rangeStart(now);
    final dayCount =
        selectedRange.value == 'Week'
            ? 7
            : selectedRange.value == 'Month'
            ? now.day
            : 13 * 7;
    final points = selectedRange.value == '3 Months' ? 13 : dayCount;
    final buckets = List<double>.filled(points, 0);

    for (final t in rows) {
      final diff = t.transactionDate.difference(start).inDays;
      if (diff < 0) {
        continue;
      }
      final idx = selectedRange.value == '3 Months' ? (diff ~/ 7) : diff;
      if (idx < 0 || idx >= points) {
        continue;
      }
      final signed = t.type == 'income' ? t.amount : -t.amount;
      buckets[idx] += signed;
    }

    trendValues.assignAll(buckets.map((v) => v.abs()).toList(growable: false));
    trendLabels.assignAll(<String>[
      '${1}',
      '${math.max(1, points ~/ 4)}',
      '${math.max(1, points ~/ 2)}',
      '${math.max(1, (points * 3) ~/ 4)}',
      '$points',
    ]);
  }

  void _computeCategorySlices(List<TransactionModel> expenses) {
    if (expenses.isEmpty) {
      categorySlices.clear();
      return;
    }
    final totals = <String, double>{};
    for (final t in expenses) {
      totals.update(t.category, (v) => v + t.amount, ifAbsent: () => t.amount);
    }
    final total = totals.values.fold<double>(0, (s, v) => s + v);
    final slices = totals.entries
      .map(
        (e) => AnalyticsCategorySlice(
          name: e.key,
          color: _colorFor(e.key),
          pct: total > 0 ? e.value / total : 0,
          amount: e.value,
        ),
      )
      .toList(growable: false)..sort((a, b) => b.amount.compareTo(a.amount));
    categorySlices.assignAll(slices);
  }

  void _computeTopMerchants(List<TransactionModel> expenses) {
    if (expenses.isEmpty) {
      topMerchants.clear();
      return;
    }
    final grouped = <String, List<TransactionModel>>{};
    for (final t in expenses) {
      final merchant = _merchantNameFor(t);
      grouped.putIfAbsent(merchant, () => <TransactionModel>[]).add(t);
    }
    final items = grouped.entries
      .map((entry) {
        final txns = entry.value;
        final amount = txns.fold<double>(0, (s, t) => s + t.amount);
        final primaryCategory = txns.first.category;
        return AnalyticsMerchant(
          name: entry.key,
          category: primaryCategory,
          txns: txns.length,
          amount: amount,
          icon: _iconFor(primaryCategory),
          color: _colorFor(primaryCategory),
        );
      })
      .toList(growable: false)..sort((a, b) => b.amount.compareTo(a.amount));

    topMerchants.assignAll(items.take(4));
  }

  void _computeInsight(
    List<TransactionModel> currentExpenses,
    List<TransactionModel> previousPeriodTransactions,
  ) {
    if (currentExpenses.isEmpty) {
      insightText.value =
          'No spending data yet. Add transactions to see trends.';
      return;
    }
    final byCategory = <String, double>{};
    for (final t in currentExpenses) {
      byCategory.update(
        t.category,
        (v) => v + t.amount,
        ifAbsent: () => t.amount,
      );
    }
    final top = byCategory.entries.reduce((a, b) => a.value >= b.value ? a : b);

    final prevCategorySpend = previousPeriodTransactions
        .where((t) => t.type == 'expense' && t.category == top.key)
        .fold<double>(0, (s, t) => s + t.amount);

    if (prevCategorySpend <= 0) {
      insightText.value =
          '${top.key} is your top spend category at ${top.value.toStringAsFixed(0)} this period.';
      return;
    }

    final changePct =
        ((top.value - prevCategorySpend) / prevCategorySpend) * 100;
    final direction = changePct >= 0 ? 'more' : 'less';
    insightText.value =
        'You spent ${changePct.abs().toStringAsFixed(0)}% $direction on ${top.key} vs the previous period.';
  }

  String _merchantNameFor(TransactionModel t) {
    final note = t.note?.trim();
    if (note == null || note.isEmpty) {
      return t.category;
    }
    final first = note.split('·').first.trim();
    if (first.isEmpty) {
      return t.category;
    }
    return first;
  }

  static IconData _iconFor(String category) {
    return CategoryVisuals.iconFor(category);
  }

  static Color _colorFor(String category) {
    return CategoryVisuals.colorFor(category);
  }

  String _monthShort(int month) {
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
    return months[month - 1];
  }

  @override
  void onClose() {
    _sub?.cancel();
    super.onClose();
  }
}
