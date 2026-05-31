import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:screenx/screenx.dart';
import 'package:spend_analytics/core/local_db/app_database.dart';
import 'package:spend_analytics/core/routes/app_routes.dart';
import 'package:spend_analytics/features/auth/auth_controller.dart';
import 'package:spend_analytics/shared/models/transaction_model.dart';
import 'package:spend_analytics/shared/utils/currency_formatter.dart';
import 'package:spend_analytics/shared/widgets/liquid_glass_surface.dart';
import 'package:spend_analytics/shared/widgets/liquid_page_scaffold.dart';
import 'package:spend_analytics/shared/widgets/sa_chip.dart';
import 'package:spend_analytics/shared/widgets/sa_shimmer.dart';
import 'package:spend_analytics/shared/widgets/txn_row.dart';

class TransactionListScreen extends StatefulWidget {
  const TransactionListScreen({super.key});

  @override
  State<TransactionListScreen> createState() => _TransactionListScreenState();
}

class _TransactionListScreenState extends State<TransactionListScreen> {
  String _filter = 'All';

  static const _filters = <String>['All', 'Expense', 'Income', 'Food', 'Transport', 'Shopping'];

  static IconData _iconFor(String category) {
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

  static Color _colorFor(String category) {
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

  static String _formatTime(DateTime d) {
    final h = d.hour % 12 == 0 ? 12 : d.hour % 12;
    final m = d.minute.toString().padLeft(2, '0');
    final ap = d.hour < 12 ? 'AM' : 'PM';
    return '$h:$m $ap';
  }

  static String _dayLabel(DateTime d) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final date = DateTime(d.year, d.month, d.day);
    final diff = today.difference(date).inDays;
    if (diff == 0) return 'Today';
    if (diff == 1) return 'Yesterday';
    return '${d.day} ${_months[d.month - 1]}';
  }

  static const _months = <String>[
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

  List<TransactionModel> _applyFilter(List<TransactionModel> all) {
    if (_filter == 'All') return all;
    if (_filter == 'Expense') return all.where((t) => t.type == 'expense').toList();
    if (_filter == 'Income') return all.where((t) => t.type == 'income').toList();
    return all.where((t) => t.category == _filter).toList();
  }

  @override
  Widget build(BuildContext context) {
    final db = Get.find<AppDatabase>();
    final auth = Get.find<AuthController>();
    final userId = auth.resolveActiveUserId();
    final scheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return LiquidPageScaffold(
      title: 'Transactions',
      activeRoute: AppRoutes.txns,
      showFab: true,
      onBack: () => Get.back<void>(),
      actions: <Widget>[
        BarActionButton(
          icon: Icons.search_rounded,
          onTap: () => Get.snackbar('Search', 'Search in transactions is coming soon.'),
        ),
        const SizedBox(width: 4),
        BarActionButton(
          icon: Icons.filter_list_rounded,
          onTap: () => Get.snackbar('Filters', 'Use the filter chips below for now.'),
        ),
      ],
      child: StreamBuilder<List<TransactionModel>>(
        stream: db.watchTransactionsForUser(userId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting && !snapshot.hasData) {
            return const _TransactionsLoadingSkeleton();
          }
          final all = snapshot.data ?? const <TransactionModel>[];
          final filtered = _applyFilter(all);

          // Totals
          double spent = 0;
          double received = 0;
          for (final t in all) {
            if (t.type == 'expense')
              spent += t.amount;
            else
              received += t.amount;
          }
          final net = received - spent;

          // Group by day
          final grouped = <String, List<TransactionModel>>{};
          for (final t in filtered) {
            final label = _dayLabel(t.transactionDate);
            (grouped[label] ??= <TransactionModel>[]).add(t);
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // ── Filter chips ─────────────────────────────────
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                child: Row(
                  children:
                      _filters.map((f) {
                        return Padding(
                          padding: EdgeInsets.only(right: ScreenX.dp(8)),
                          child: SAChip(
                            label: f,
                            active: f == _filter,
                            onTap: () => setState(() => _filter = f),
                          ),
                        );
                      }).toList(),
                ),
              ),

              SizedBox(height: ScreenX.dp(14)),

              // ── Summary card ─────────────────────────────────
              LiquidGlassSurface(
                padding: EdgeInsets.all(ScreenX.dp(16)),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    if (constraints.maxWidth >= 520) {
                      return Row(
                        children: <Widget>[
                          _SumCol(
                            label: 'SPENT',
                            value: formatInr(spent),
                            color: scheme.onSurface,
                            headerTextColor: scheme.onSurface,
                          ),
                          _Divider(isDark: isDark),
                          _SumCol(
                            label: 'RECEIVED',
                            value: '+${formatInr(received)}',
                            color: scheme.tertiary,
                            headerTextColor: scheme.onSurface,
                          ),
                          _Divider(isDark: isDark),
                          _SumCol(
                            label: 'NET',
                            value: formatInr(net.abs()),
                            color: scheme.onSurface,
                            headerTextColor: scheme.onSurface,
                          ),
                        ],
                      );
                    }
                    return Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            _SumCol(
                              label: 'SPENT',
                              value: formatInr(spent),
                              color: scheme.onSurface,
                              headerTextColor: scheme.onSurface,
                            ),
                            SizedBox(width: ScreenX.dp(10)),
                            _SumCol(
                              label: 'RECEIVED',
                              value: '+${formatInr(received)}',
                              color: scheme.tertiary,
                              headerTextColor: scheme.onSurface,
                            ),
                          ],
                        ),
                        SizedBox(height: ScreenX.dp(12)),
                        Row(
                          children: <Widget>[
                            _SumCol(
                              label: 'NET',
                              value: formatInr(net.abs()),
                              color: scheme.onSurface,
                              headerTextColor: scheme.onSurface,
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ),

              SizedBox(height: ScreenX.dp(16)),

              // ── Grouped transaction lists ─────────────────────
              if (filtered.isEmpty)
                Padding(
                  padding: EdgeInsets.only(top: ScreenX.dp(32)),
                  child: Center(
                    child: Text(
                      'No transactions match this filter.',
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium?.copyWith(color: scheme.onSurfaceVariant),
                    ),
                  ),
                )
              else
                ...grouped.entries.map((entry) {
                  final label = entry.key;
                  final txns = entry.value;
                  final dayTotal = txns.fold<double>(
                    0,
                    (sum, t) => sum + (t.type == 'expense' ? -t.amount : t.amount),
                  );

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                          ScreenX.dp(4),
                          0,
                          ScreenX.dp(4),
                          ScreenX.dp(8),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              label.toUpperCase(),
                              style: TextStyle(
                                fontSize: ScreenX.sp(11),
                                fontWeight: FontWeight.w700,
                                letterSpacing: 1.1,
                                color: scheme.onSurfaceVariant,
                              ),
                            ),
                            Text(
                              '${dayTotal >= 0 ? '+' : '−'}${formatInr(dayTotal.abs())}',
                              style: Theme.of(
                                context,
                              ).textTheme.bodyMedium?.copyWith(color: scheme.onSurfaceVariant),
                            ),
                          ],
                        ),
                      ),
                      LiquidGlassSurface(
                        padding: EdgeInsets.symmetric(horizontal: ScreenX.dp(12)),
                        child: Column(
                          children: List<Widget>.generate(txns.length, (i) {
                            final t = txns[i];
                            final isLast = i == txns.length - 1;
                            return TxnRow(
                              data: TransactionRowData(
                                merchant: t.category,
                                category: t.category,
                                icon: _iconFor(t.category),
                                iconColor: _colorFor(t.category),
                                amount: t.amount,
                                time: _formatTime(t.transactionDate),
                                isIncome: t.type == 'income',
                                mode: t.paymentMode,
                              ),
                              showDivider: !isLast,
                              onTap: () => Get.toNamed(AppRoutes.txnDetail, arguments: t),
                            );
                          }),
                        ),
                      ),
                      SizedBox(height: ScreenX.dp(14)),
                    ],
                  );
                }),
            ],
          );
        },
      ),
    );
  }
}

class _TransactionsLoadingSkeleton extends StatelessWidget {
  const _TransactionsLoadingSkeleton();

  @override
  Widget build(BuildContext context) {
    return SAShimmer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: const <Widget>[
          SAShimmerBox(height: 36, radius: 16),
          SizedBox(height: 14),
          SAShimmerBox(height: 94, radius: 20),
          SizedBox(height: 16),
          SAShimmerBox(height: 16, width: 110, radius: 8),
          SizedBox(height: 8),
          SAShimmerBox(height: 82, radius: 16),
          SizedBox(height: 12),
          SAShimmerBox(height: 16, width: 130, radius: 8),
          SizedBox(height: 8),
          SAShimmerBox(height: 82, radius: 16),
          SizedBox(height: 12),
          SAShimmerBox(height: 16, width: 100, radius: 8),
          SizedBox(height: 8),
          SAShimmerBox(height: 82, radius: 16),
        ],
      ),
    );
  }
}

class _SumCol extends StatelessWidget {
  const _SumCol({
    required this.label,
    required this.value,
    required this.color,
    required this.headerTextColor,
  });
  final String label;
  final String value;
  final Color color;
  final Color headerTextColor;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: <Widget>[
          Text(
            label,
            style: TextStyle(
              color: headerTextColor,
              fontSize: ScreenX.sp(10),
              fontWeight: FontWeight.w700,
              letterSpacing: 1,
            ),
          ),
          SizedBox(height: ScreenX.dp(4)),
          Text(
            value,
            style: TextStyle(
              fontSize: ScreenX.sp(15),
              fontWeight: FontWeight.w800,
              color: color,
              fontFeatures: const <FontFeature>[FontFeature.tabularFigures()],
            ),
          ),
        ],
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider({required this.isDark});
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 40,
      color: isDark ? Colors.white.withValues(alpha: 0.12) : Colors.black.withValues(alpha: 0.08),
    );
  }
}
