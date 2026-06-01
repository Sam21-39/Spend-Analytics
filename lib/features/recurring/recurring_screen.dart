import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spend_analytics/features/recurring/recurring_controller.dart';
import 'package:spend_analytics/shared/widgets/liquid_glass_surface.dart';
import 'package:spend_analytics/shared/widgets/liquid_page_scaffold.dart';

class RecurringScreen extends GetView<RecurringController> {
  const RecurringScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return LiquidPageScaffold(
      title: 'Recurring',
      showBottomNav: false,
      onBack: () => Get.back<void>(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          LiquidGlassSurface(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: <Widget>[
                Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: const LinearGradient(
                      colors: <Color>[Color(0xFFFFB860), Color(0xFFFF9F40)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: const Icon(
                    Icons.repeat_rounded,
                    color: Colors.white,
                    size: 36,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Recurring Is Coming Soon',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: scheme.onSurface,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Recurring tracking and due-date reminders are under development. We will enable this as soon as it is stable.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    height: 1.5,
                    color: scheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 18),
                FilledButton.icon(
                  onPressed: () => Get.back<void>(),
                  icon: const Icon(Icons.arrow_back_rounded),
                  label: const Text('Back to App'),
                  style: FilledButton.styleFrom(
                    minimumSize: const Size.fromHeight(46),
                    shape: const StadiumBorder(),
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
