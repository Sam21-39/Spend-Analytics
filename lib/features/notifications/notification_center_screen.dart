import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spend_analytics/core/local_db/app_database.dart';
import 'package:spend_analytics/core/routes/app_routes.dart';
import 'package:spend_analytics/features/notifications/notification_center_controller.dart';
import 'package:spend_analytics/shared/widgets/liquid_glass_surface.dart';
import 'package:spend_analytics/shared/widgets/liquid_page_scaffold.dart';

class NotificationCenterScreen extends GetView<NotificationCenterController> {
  const NotificationCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LiquidPageScaffold(
      title: 'Notifications',
      activeRoute: AppRoutes.dashboard,
      actions: <Widget>[
        TextButton(
          onPressed: () async {
            await controller.clearAll();
            Get.snackbar('Cleared', 'All notifications removed.');
          },
          child: const Text('Clear All'),
        ),
      ],
      child: Obx(() {
        final items = controller.notifications;
        if (items.isEmpty) {
          return LiquidGlassSurface(
            child: Text(
              'No notifications yet. Rule alerts and reminders will appear here.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: items
              .map(
                (item) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: _NoticeCard(item: item),
                ),
              )
              .toList(growable: false),
        );
      }),
    );
  }
}

class _NoticeCard extends StatelessWidget {
  const _NoticeCard({required this.item});

  final NotificationEvent item;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final color = _accent(item.source, scheme);

    return LiquidGlassSurface(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CircleAvatar(
            backgroundColor: color.withValues(alpha: 0.16),
            child: Icon(_icon(item.source), color: color),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        item.title,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ),
                    Text(
                      _timeAgo(item.createdAt),
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  item.body,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: scheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  IconData _icon(String source) {
    switch (source) {
      case 'rule':
        return Icons.rule_rounded;
      case 'security':
        return Icons.security_rounded;
      case 'sync':
        return Icons.sync_rounded;
      default:
        return Icons.notifications_rounded;
    }
  }

  Color _accent(String source, ColorScheme scheme) {
    switch (source) {
      case 'rule':
        return scheme.primary;
      case 'security':
        return const Color(0xFFC2C1FF);
      case 'sync':
        return const Color(0xFF3FDF95);
      default:
        return const Color(0xFFFFB4AB);
    }
  }

  String _timeAgo(DateTime time) {
    final diff = DateTime.now().difference(time);
    if (diff.inMinutes < 1) return 'just now';
    if (diff.inHours < 1) return '${diff.inMinutes}m ago';
    if (diff.inDays < 1) return '${diff.inHours}h ago';
    return '${diff.inDays}d ago';
  }
}
