import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spend_analytics/core/local_db/app_database.dart';
import 'package:spend_analytics/features/notifications/notification_center_controller.dart';
import 'package:spend_analytics/shared/widgets/icon_box.dart';
import 'package:spend_analytics/shared/widgets/liquid_glass_surface.dart';
import 'package:spend_analytics/shared/widgets/liquid_page_scaffold.dart';

class NotificationCenterScreen extends GetView<NotificationCenterController> {
  const NotificationCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isDark  = Theme.of(context).brightness == Brightness.dark;

    return LiquidPageScaffold(
      title:         'Notifications',
      showBottomNav: false,
      onBack:        () => Get.back<void>(),
      actions: <Widget>[
        BarActionButton(
          icon:  Icons.done_all_rounded,
          onTap: () async {
            await controller.clearAll();
            Get.snackbar(
              'Cleared',
              'All notifications removed.',
              duration: const Duration(seconds: 2),
            );
          },
        ),
      ],
      child: Obx(() {
        final items = controller.notifications;

        if (items.isEmpty) {
          return LiquidGlassSurface(
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
            child: Center(
              child: Column(
                children: <Widget>[
                  Icon(
                    Icons.notifications_none_rounded,
                    size:  48,
                    color: scheme.onSurfaceVariant.withValues(alpha: 0.35),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'All caught up!',
                    style: TextStyle(
                      fontSize:   16,
                      fontWeight: FontWeight.w700,
                      color:      scheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Rule alerts and reminders will appear here.',
                    style: TextStyle(
                      fontSize: 13,
                      color:    scheme.onSurfaceVariant,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        }

        // Group into Today / Yesterday / Earlier
        final now       = DateTime.now();
        final today     = DateTime(now.year, now.month, now.day);
        final yesterday = today.subtract(const Duration(days: 1));

        final todayItems     = items.where((n) => !n.createdAt.isBefore(today)).toList();
        final yesterdayItems = items.where((n) =>
          !n.createdAt.isBefore(yesterday) && n.createdAt.isBefore(today)
        ).toList();
        final earlierItems   = items.where((n) => n.createdAt.isBefore(yesterday)).toList();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (todayItems.isNotEmpty) ...<Widget>[
              _GroupLabel(label: 'TODAY'),
              const SizedBox(height: 10),
              _NotifGroup(items: todayItems, isDark: isDark),
              const SizedBox(height: 16),
            ],
            if (yesterdayItems.isNotEmpty) ...<Widget>[
              _GroupLabel(label: 'YESTERDAY'),
              const SizedBox(height: 10),
              _NotifGroup(items: yesterdayItems, isDark: isDark),
              const SizedBox(height: 16),
            ],
            if (earlierItems.isNotEmpty) ...<Widget>[
              _GroupLabel(label: 'EARLIER'),
              const SizedBox(height: 10),
              _NotifGroup(items: earlierItems, isDark: isDark),
              const SizedBox(height: 16),
            ],
          ],
        );
      }),
    );
  }
}

// ── Sub-widgets ────────────────────────────────────────────────────────────

class _GroupLabel extends StatelessWidget {
  const _GroupLabel({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(
        fontSize:      11,
        fontWeight:    FontWeight.w700,
        letterSpacing: 0.8,
        color:         Theme.of(context).colorScheme.onSurfaceVariant,
      ),
    );
  }
}

class _NotifGroup extends StatelessWidget {
  const _NotifGroup({required this.items, required this.isDark});
  final List<NotificationEvent> items;
  final bool                    isDark;

  @override
  Widget build(BuildContext context) {
    return LiquidGlassSurface(
      padding: EdgeInsets.zero,
      child: Column(
        children: List<Widget>.generate(items.length, (i) {
          final item   = items[i];
          final isLast = i == items.length - 1;
          return _NotifRow(item: item, showDivider: !isLast, isDark: isDark);
        }),
      ),
    );
  }
}

class _NotifRow extends StatelessWidget {
  const _NotifRow({
    required this.item,
    required this.showDivider,
    required this.isDark,
  });
  final NotificationEvent item;
  final bool              showDivider;
  final bool              isDark;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final color  = _accentFor(item.source, scheme);

    return Container(
      decoration: showDivider
          ? BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: isDark
                      ? Colors.white.withValues(alpha: 0.08)
                      : Colors.black.withValues(alpha: 0.06),
                  width: 0.5,
                ),
              ),
            )
          : null,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          IconBox(
            icon:  _iconFor(item.source),
            color: color,
            size:  38,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        item.title,
                        style: TextStyle(
                          fontSize:   14,
                          fontWeight: item.isRead ? FontWeight.w500 : FontWeight.w700,
                          color:      scheme.onSurface,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      _timeAgo(item.createdAt),
                      style: TextStyle(
                        fontSize: 11,
                        color:    scheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  item.body,
                  style: TextStyle(
                    fontSize: 13,
                    height:   1.4,
                    color:    scheme.onSurfaceVariant,
                  ),
                ),
                if (!item.isRead) ...<Widget>[
                  const SizedBox(height: 6),
                  Container(
                    width:  6,
                    height: 6,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: color,
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color:      color.withValues(alpha: 0.5),
                          blurRadius: 4,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  static IconData _iconFor(String source) {
    switch (source) {
      case 'rule':     return Icons.auto_awesome_rounded;
      case 'security': return Icons.security_rounded;
      case 'sync':     return Icons.cloud_sync_rounded;
      case 'budget':   return Icons.account_balance_wallet_rounded;
      default:         return Icons.notifications_rounded;
    }
  }

  static Color _accentFor(String source, ColorScheme scheme) {
    switch (source) {
      case 'rule':     return scheme.primary;
      case 'security': return const Color(0xFFB0A0FF);
      case 'sync':     return const Color(0xFF3FDDA0);
      case 'budget':   return const Color(0xFFFF9F40);
      default:         return const Color(0xFF5B9FFF);
    }
  }

  static String _timeAgo(DateTime time) {
    final diff = DateTime.now().difference(time);
    if (diff.inMinutes < 1)  return 'just now';
    if (diff.inHours   < 1)  return '${diff.inMinutes}m ago';
    if (diff.inDays    < 1)  return '${diff.inHours}h ago';
    return '${diff.inDays}d ago';
  }
}
