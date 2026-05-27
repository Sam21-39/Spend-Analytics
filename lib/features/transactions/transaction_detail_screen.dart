import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spend_analytics/core/routes/app_routes.dart';
import 'package:spend_analytics/features/transactions/transaction_controller.dart';
import 'package:spend_analytics/shared/models/transaction_model.dart';
import 'package:spend_analytics/shared/utils/currency_formatter.dart';
import 'package:spend_analytics/shared/widgets/icon_box.dart';
import 'package:spend_analytics/shared/widgets/liquid_page_scaffold.dart';
import 'package:spend_analytics/shared/widgets/liquid_glass_surface.dart';
import 'package:spend_analytics/shared/widgets/sa_pill.dart';

/// Detail view for a single transaction.
/// Expects a [TransactionModel] passed via `Get.arguments`.
class TransactionDetailScreen extends StatelessWidget {
  const TransactionDetailScreen({super.key});

  static const _categoryMeta = <String, ({IconData icon, Color color})>{
    'Food': (icon: Icons.coffee_rounded, color: Color(0xFFFF9F40)),
    'Transport': (icon: Icons.directions_car_rounded, color: Color(0xFF5B9FFF)),
    'Shopping': (icon: Icons.shopping_bag_rounded, color: Color(0xFFB0A0FF)),
    'Health': (icon: Icons.favorite_rounded, color: Color(0xFFFF6B6B)),
    'Bills': (icon: Icons.bolt_rounded, color: Color(0xFFFFB860)),
    'Income': (icon: Icons.arrow_downward_rounded, color: Color(0xFF3FDDA0)),
    'Others': (icon: Icons.sell_rounded, color: Color(0xFF3FDDA0)),
  };

  static ({IconData icon, Color color}) _meta(String category) =>
      _categoryMeta[category] ??
      (icon: Icons.paid_rounded, color: const Color(0xFF5B9FFF));

  @override
  Widget build(BuildContext context) {
    final txn = Get.arguments as TransactionModel?;
    final ctrl =
        Get.isRegistered<TransactionController>()
            ? Get.find<TransactionController>()
            : Get.put(TransactionController());
    final scheme = Theme.of(context).colorScheme;
    final isIncome = txn?.type == 'income';
    final meta = _meta(txn?.category ?? 'Others');

    return LiquidPageScaffold(
      title: 'Transaction',
      showBottomNav: false,
      onBack: () => Get.back<void>(),
      actions: <Widget>[
        BarActionButton(
          icon: Icons.edit_outlined,
          onTap:
              txn == null
                  ? null
                  : () => Get.offNamed(AppRoutes.addTxn, arguments: txn),
        ),
        const SizedBox(width: 4),
        BarActionButton(
          icon: Icons.delete_outline_rounded,
          iconColor: scheme.error,
          onTap:
              txn == null
                  ? null
                  : () => _confirmDelete(context, scheme, txn, ctrl),
        ),
      ],
      child: Column(
        children: <Widget>[
          // ── Hero amount card ──────────────────────────────────
          LiquidGlassSurface(
            padding: const EdgeInsets.all(28),
            borderRadius: const BorderRadius.all(Radius.circular(24)),
            child: Column(
              children: <Widget>[
                IconBox(
                  icon: meta.icon,
                  color: meta.color,
                  size: 64,
                  radius: 20,
                ),
                const SizedBox(height: 14),
                Text(
                  txn?.category ?? 'Unknown',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: scheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  '${isIncome ? '+' : '−'}${formatInr(txn?.amount ?? 0)}',
                  style: TextStyle(
                    fontSize: 44,
                    fontWeight: FontWeight.w800,
                    color: isIncome ? scheme.tertiary : scheme.onSurface,
                    letterSpacing: -1.5,
                    fontFeatures: const <FontFeature>[
                      FontFeature.tabularFigures(),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  txn != null
                      ? '${_formatDate(txn.transactionDate)} · ${_formatTime(txn.transactionDate)}'
                      : '',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: scheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 14),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SAPill(
                      label: txn?.category ?? 'Unknown',
                      color: scheme.primary,
                    ),
                    const SizedBox(width: 8),
                    SAPill(
                      label: txn?.paymentMode ?? 'UPI',
                      color: scheme.secondary,
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // ── Details list ──────────────────────────────────────
          LiquidGlassSurface(
            padding: EdgeInsets.zero,
            child: Column(
              children: <_DetailRow>[
                _DetailRow(label: 'Note', value: txn?.note ?? '—'),
                _DetailRow(label: 'Account', value: '——'),
                _DetailRow(label: 'Created via', value: 'Manual entry'),
                _DetailRow(
                  label: 'Cloud sync',
                  value: 'Synced ✓',
                  accent: scheme.tertiary,
                  isLast: true,
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // ── Delete ────────────────────────────────────────────
          GestureDetector(
            onTap:
                txn == null
                    ? null
                    : () => _confirmDelete(context, scheme, txn, ctrl),
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: scheme.error.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: scheme.error.withValues(alpha: 0.3)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.delete_outline_rounded,
                    size: 18,
                    color: scheme.error,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Delete transaction',
                    style: TextStyle(
                      color: scheme.error,
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _confirmDelete(
    BuildContext context,
    ColorScheme scheme,
    TransactionModel txn,
    TransactionController ctrl,
  ) {
    showDialog<void>(
      context: context,
      builder:
          (ctx) => AlertDialog(
            title: const Text('Delete transaction?'),
            content: const Text(
              'This will remove the transaction from your device and cloud backup.',
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: const Text('Cancel'),
              ),
              FilledButton(
                style: FilledButton.styleFrom(backgroundColor: scheme.error),
                onPressed: () async {
                  Navigator.pop(ctx);
                  try {
                    await ctrl.deleteTransaction(txn);
                    Get.back<void>();
                  } catch (_) {}
                },
                child: const Text('Delete'),
              ),
            ],
          ),
    );
  }

  String _formatDate(DateTime d) =>
      '${d.day} ${_months[d.month - 1]} ${d.year}';

  String _formatTime(DateTime d) {
    final h = d.hour % 12 == 0 ? 12 : d.hour % 12;
    final m = d.minute.toString().padLeft(2, '0');
    final ap = d.hour < 12 ? 'AM' : 'PM';
    return '$h:$m $ap';
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
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({
    required this.label,
    required this.value,
    this.accent,
    this.isLast = false,
  });
  final String label;
  final String value;
  final Color? accent;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      decoration:
          isLast
              ? null
              : BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color:
                        isDark
                            ? Colors.white.withValues(alpha: 0.08)
                            : Colors.black.withValues(alpha: 0.06),
                    width: 0.5,
                  ),
                ),
              ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 4,
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(color: scheme.onSurfaceVariant),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            flex: 6,
            child: Text(
              value,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.right,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: accent ?? scheme.onSurface,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
