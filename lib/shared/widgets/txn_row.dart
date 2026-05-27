import 'package:flutter/material.dart';
import 'package:spend_analytics/shared/widgets/icon_box.dart';

/// Single transaction row — used in dashboard, transaction list, budget detail.
///
/// Pass a [TransactionRowData] to render a category icon, merchant name,
/// category+mode subtitle, amount, and time.
class TransactionRowData {
  const TransactionRowData({
    required this.merchant,
    required this.category,
    required this.icon,
    required this.iconColor,
    required this.amount,
    required this.time,
    required this.isIncome,
    this.mode = '',
  });

  final String  merchant;
  final String  category;
  final IconData icon;
  final Color   iconColor;
  final double  amount;
  final String  time;
  final bool    isIncome;
  final String  mode;
}

class TxnRow extends StatelessWidget {
  const TxnRow({
    required this.data,
    super.key,
    this.showDivider = true,
    this.onTap,
  });

  final TransactionRowData data;
  final bool showDivider;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final scheme  = Theme.of(context).colorScheme;
    final isDark  = Theme.of(context).brightness == Brightness.dark;
    final dividerColor = isDark
        ? Colors.white.withValues(alpha: 0.08)
        : Colors.black.withValues(alpha: 0.06);

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        decoration: showDivider
            ? BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: dividerColor, width: 0.5),
                ),
              )
            : null,
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: <Widget>[
            IconBox(icon: data.icon, color: data.iconColor, size: 40, radius: 12),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    data.merchant,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color:      scheme.onSurface,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: <Widget>[
                      Text(
                        data.category,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: scheme.onSurfaceVariant,
                        ),
                      ),
                      if (data.mode.isNotEmpty) ...<Widget>[
                        Text(
                          ' · ',
                          style: TextStyle(
                            color:   scheme.onSurfaceVariant.withValues(alpha: 0.5),
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          data.mode,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: scheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text(
                  '${data.isIncome ? '+' : '−'}₹${_formatAmount(data.amount)}',
                  style: TextStyle(
                    fontSize:            15,
                    fontWeight:          FontWeight.w800,
                    color:               data.isIncome ? scheme.tertiary : scheme.onSurface,
                    fontFeatures: const <FontFeature>[FontFeature.tabularFigures()],
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  data.time,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: scheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatAmount(double amount) {
    if (amount >= 100000) {
      return '${(amount / 100000).toStringAsFixed(1)}L';
    }
    if (amount >= 1000) {
      final s = amount.toStringAsFixed(0);
      // en-IN grouping: last 3, then groups of 2
      if (s.length > 3) {
        final last3  = s.substring(s.length - 3);
        final rest   = s.substring(0, s.length - 3);
        final groups = <String>[];
        for (var i = rest.length; i > 0; i -= 2) {
          groups.insert(0, rest.substring(i < 2 ? 0 : i - 2, i));
        }
        return '${groups.join(',')},$last3';
      }
      return s;
    }
    return amount.toStringAsFixed(0);
  }
}
