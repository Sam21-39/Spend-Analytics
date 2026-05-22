import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spend_analytics/core/routes/app_routes.dart';
import 'package:spend_analytics/features/rules/rules_controller.dart';
import 'package:spend_analytics/shared/widgets/liquid_glass_surface.dart';
import 'package:spend_analytics/shared/widgets/liquid_page_scaffold.dart';

class RulesScreen extends StatefulWidget {
  const RulesScreen({super.key});

  @override
  State<RulesScreen> createState() => _RulesScreenState();
}

class _RulesScreenState extends State<RulesScreen> {
  late final RulesController controller;
  late final List<bool> enabled;

  @override
  void initState() {
    super.initState();
    controller = Get.find<RulesController>();
    enabled = List<bool>.filled(controller.rules.length, true);
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return LiquidPageScaffold(
      title: 'My Smart Rules',
      activeRoute: AppRoutes.rules,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Automate your financial discipline with smart alerts.',
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(color: scheme.onSurfaceVariant),
          ),
          const SizedBox(height: 14),
          ...controller.rules.asMap().entries.map((entry) {
            final index = entry.key;
            final rule = entry.value;
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: LiquidGlassSurface(
                child: Row(
                  children: <Widget>[
                    CircleAvatar(
                      backgroundColor: Colors.white.withValues(alpha: 0.09),
                      child: Icon(
                        _iconForRule(index),
                        color: _accentForRule(index),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        rule,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                    Switch.adaptive(
                      value: enabled[index],
                      onChanged: (value) {
                        setState(() {
                          enabled[index] = value;
                        });
                      },
                      activeTrackColor: scheme.primary.withValues(alpha: 0.45),
                      activeThumbColor: scheme.primary,
                    ),
                  ],
                ),
              ),
            );
          }),
          const SizedBox(height: 4),
          OutlinedButton.icon(
            onPressed: () {
              Get.snackbar(
                'Coming Soon',
                'Rule builder will be added in the next pass.',
              );
            },
            icon: const Icon(Icons.add_circle_outline_rounded),
            label: const Text('Add New Rule'),
          ),
        ],
      ),
    );
  }

  IconData _iconForRule(int index) {
    switch (index) {
      case 0:
        return Icons.lunch_dining_rounded;
      case 1:
        return Icons.payments_rounded;
      default:
        return Icons.notifications_active_rounded;
    }
  }

  Color _accentForRule(int index) {
    switch (index) {
      case 0:
        return const Color(0xFFFF6B6B);
      case 1:
        return const Color(0xFFADC6FF);
      default:
        return const Color(0xFF8382FF);
    }
  }
}
