import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spend_analytics/features/recurring/recurring_controller.dart';
import 'package:spend_analytics/shared/widgets/liquid_glass_background.dart';
import 'package:spend_analytics/shared/widgets/liquid_glass_surface.dart';

class RecurringScreen extends GetView<RecurringController> {
  const RecurringScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: <Widget>[
          const LiquidGlassBackground(),
          SafeArea(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
              children: <Widget>[
                Row(
                  children: <Widget>[
                    IconButton(
                      onPressed: () => Get.back<void>(),
                      icon: const Icon(Icons.arrow_back_rounded),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'Recurring Expenses',
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(fontWeight: FontWeight.w800),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Obx(
                  () => Column(
                    children: controller.recurringItems
                        .map(
                          (item) => Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: LiquidGlassSurface(
                              child: ListTile(
                                contentPadding: EdgeInsets.zero,
                                leading: CircleAvatar(
                                  backgroundColor: Colors.white.withValues(
                                    alpha: 0.08,
                                  ),
                                  child: const Icon(Icons.repeat_rounded),
                                ),
                                title: Text(item),
                                subtitle: Text(
                                  'Auto-reminder enabled',
                                  style: Theme.of(
                                    context,
                                  ).textTheme.bodySmall?.copyWith(
                                    color: scheme.onSurfaceVariant,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                        .toList(growable: false),
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
