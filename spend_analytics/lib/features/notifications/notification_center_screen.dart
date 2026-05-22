import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spend_analytics/core/routes/app_routes.dart';
import 'package:spend_analytics/shared/widgets/liquid_glass_surface.dart';
import 'package:spend_analytics/shared/widgets/liquid_page_scaffold.dart';

class NotificationCenterScreen extends StatelessWidget {
  const NotificationCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return LiquidPageScaffold(
      title: 'Notifications',
      activeRoute: AppRoutes.dashboard,
      actions: <Widget>[
        TextButton(
          onPressed:
              () =>
                  Get.snackbar('Cleared', 'All notifications marked as read.'),
          child: const Text('Clear All'),
        ),
      ],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'New',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(color: scheme.onSurfaceVariant),
          ),
          const SizedBox(height: 10),
          const _NoticeCard(
            icon: Icons.trending_up_rounded,
            title: 'Budget Alert',
            subtitle:
                'Food budget at 88%. You have ₹480 left in this category.',
            timestamp: '2m ago',
            color: Color(0xFFFFB4AB),
          ),
          const SizedBox(height: 10),
          const _NoticeCard(
            icon: Icons.security_rounded,
            title: 'Security Alert',
            subtitle: 'New login detected from Mumbai, IN.',
            timestamp: '1h ago',
            color: Color(0xFFC2C1FF),
          ),
          const SizedBox(height: 18),
          Text(
            'Earlier',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(color: scheme.onSurfaceVariant),
          ),
          const SizedBox(height: 10),
          const _NoticeCard(
            icon: Icons.assessment_rounded,
            title: 'Monthly Summary',
            subtitle:
                'Your report is ready. Review spending patterns and adjust goals.',
            timestamp: '1d ago',
            color: Color(0xFFADC6FF),
          ),
          const SizedBox(height: 10),
          const _NoticeCard(
            icon: Icons.lightbulb_rounded,
            title: 'Savings Tip',
            subtitle: 'You saved 12% more this week compared to last week.',
            timestamp: '3d ago',
            color: Color(0xFFFFB3B5),
          ),
        ],
      ),
    );
  }
}

class _NoticeCard extends StatelessWidget {
  const _NoticeCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.timestamp,
    required this.color,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final String timestamp;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return LiquidGlassSurface(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CircleAvatar(
            backgroundColor: color.withValues(alpha: 0.16),
            child: Icon(icon, color: color),
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
                        title,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ),
                    Text(
                      timestamp,
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
