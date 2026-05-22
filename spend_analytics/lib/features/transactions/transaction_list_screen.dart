import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:spend_analytics/core/local_db/app_database.dart';
import 'package:spend_analytics/shared/models/transaction_model.dart';
import 'package:spend_analytics/shared/utils/currency_formatter.dart';
import 'package:spend_analytics/shared/widgets/liquid_glass_background.dart';
import 'package:spend_analytics/shared/widgets/liquid_glass_surface.dart';

class TransactionListScreen extends StatelessWidget {
  const TransactionListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final db = Get.find<AppDatabase>();
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: <Widget>[
          const LiquidGlassBackground(),
          SafeArea(
            child: StreamBuilder<List<TransactionModel>>(
              stream: db.watchAllTransactions(),
              builder: (context, snapshot) {
                final txns = snapshot.data ?? const <TransactionModel>[];
                return ListView(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 30),
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        IconButton(
                          onPressed: () => Get.back<void>(),
                          icon: const Icon(Icons.arrow_back_rounded),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          'Transactions',
                          style: Theme.of(context).textTheme.headlineSmall
                              ?.copyWith(fontWeight: FontWeight.w800),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    if (txns.isEmpty)
                      LiquidGlassSurface(
                        child: Text(
                          'No transactions yet. Add one from the dashboard to get started.',
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(color: scheme.onSurfaceVariant),
                        ),
                      )
                    else
                      ...txns.map(
                        (txn) => Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: LiquidGlassSurface(
                            child: Row(
                              children: <Widget>[
                                CircleAvatar(
                                  backgroundColor: Colors.white.withValues(
                                    alpha: 0.08,
                                  ),
                                  child: Icon(
                                    _iconForCategory(txn.category),
                                    color: scheme.primary,
                                  ),
                                ),
                                const SizedBox(width: 12),
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
                                            ).textTheme.titleSmall,
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        DateFormat(
                                          'dd MMM yyyy, hh:mm a',
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
                                  txn.type == 'income'
                                      ? '+${formatInr(txn.amount)}'
                                      : '-${formatInr(txn.amount)}',
                                  style: Theme.of(
                                    context,
                                  ).textTheme.titleSmall?.copyWith(
                                    color:
                                        txn.type == 'income'
                                            ? const Color(0xFF3FDF95)
                                            : scheme.onSurface,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  IconData _iconForCategory(String category) {
    final normalized = category.toLowerCase();
    if (normalized.contains('food')) {
      return Icons.restaurant_rounded;
    }
    if (normalized.contains('transport')) {
      return Icons.directions_car_rounded;
    }
    if (normalized.contains('shop')) {
      return Icons.shopping_bag_rounded;
    }
    if (normalized.contains('bill') || normalized.contains('rent')) {
      return Icons.receipt_long_rounded;
    }
    return Icons.account_balance_wallet_rounded;
  }
}
