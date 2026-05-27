import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spend_analytics/shared/widgets/icon_box.dart';
import 'package:spend_analytics/shared/widgets/liquid_glass_surface.dart';
import 'package:spend_analytics/shared/widgets/liquid_page_scaffold.dart';

/// Rule type picker — choose what triggers a nudge, then configure it.
class AddRuleScreen extends StatefulWidget {
  const AddRuleScreen({super.key});

  @override
  State<AddRuleScreen> createState() => _AddRuleScreenState();
}

class _AddRuleScreenState extends State<AddRuleScreen> {
  int _selected = 0;

  static const _types = <_RuleType>[
    _RuleType(
      id:    'budget_threshold',
      icon:  Icons.warning_amber_rounded,
      name:  'Budget threshold',
      body:  'Alert when category spend crosses %',
    ),
    _RuleType(
      id:    'daily_limit',
      icon:  Icons.trending_up_rounded,
      name:  'Daily limit',
      body:  'Stop me at ₹X per day',
    ),
    _RuleType(
      id:    'no_entry',
      icon:  Icons.notifications_outlined,
      name:  'No-entry reminder',
      body:  'Remind me to log expenses',
    ),
    _RuleType(
      id:    'category_spike',
      icon:  Icons.auto_awesome_outlined,
      name:  'Category spike',
      body:  'Detect unusual category jumps',
    ),
    _RuleType(
      id:    'weekend',
      icon:  Icons.calendar_today_outlined,
      name:  'Weekend overspend',
      body:  'Compare weekend vs weekday',
    ),
    _RuleType(
      id:    'recurring',
      icon:  Icons.repeat_rounded,
      name:  'Recurring due',
      body:  'Heads up before bills hit',
    ),
  ];

  static const _colors = <Color>[
    Color(0xFFFFB860), // warning
    Color(0xFFFF6B6B), // error
    Color(0xFF5B9FFF), // primary
    Color(0xFFB0A0FF), // secondary
    Color(0xFF3FDDA0), // tertiary
    Color(0xFFFF9F40), // orange
  ];

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return LiquidPageScaffold(
      title:         'New rule',
      showBottomNav: false,
      onBack:        () => Get.back<void>(),
      actions: <Widget>[
        BarActionButton(icon: Icons.close_rounded, onTap: () => Get.back<void>()),
      ],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            'Pick what should trigger a nudge. You can tune it after.',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: scheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 16),

          ...List<Widget>.generate(_types.length, (i) {
            final type    = _types[i];
            final color   = _colors[i];
            final isActive = i == _selected;
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: GestureDetector(
                onTap: () => setState(() => _selected = i),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 160),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: isActive
                        ? Border.all(color: scheme.primary, width: 1.5)
                        : null,
                    boxShadow: isActive
                        ? <BoxShadow>[
                            BoxShadow(
                              color:      scheme.primary.withValues(alpha: 0.25),
                              blurRadius: 20,
                              offset:     const Offset(0, 6),
                            ),
                          ]
                        : null,
                  ),
                  child: LiquidGlassSurface(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                    children: <Widget>[
                      IconBox(icon: type.icon, color: color, size: 42, radius: 12),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              type.name,
                              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                color:      scheme.onSurface,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              type.body,
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: scheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 160),
                        width:  22,
                        height: 22,
                        decoration: BoxDecoration(
                          shape:  BoxShape.circle,
                          border: Border.all(
                            color: isActive ? scheme.primary : scheme.outline,
                            width: isActive ? 7 : 1.5,
                          ),
                        ),
                      ),
                    ],
                    ),  // Row
                  ),    // LiquidGlassSurface
                ),      // AnimatedContainer
              ),        // GestureDetector
            );          // Padding
          }),

          const SizedBox(height: 8),

          FilledButton(
            onPressed: () => Get.back<void>(),
            style: FilledButton.styleFrom(
              minimumSize: const Size.fromHeight(54),
              shape: const StadiumBorder(),
            ),
            child: const Text(
              'Configure rule',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }
}

class _RuleType {
  const _RuleType({
    required this.id,
    required this.icon,
    required this.name,
    required this.body,
  });
  final String   id;
  final IconData icon;
  final String   name;
  final String   body;
}
