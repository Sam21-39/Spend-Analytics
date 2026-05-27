import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spend_analytics/core/routes/app_routes.dart';
import 'package:spend_analytics/features/rules/rules_controller.dart';
import 'package:spend_analytics/shared/widgets/icon_box.dart';
import 'package:spend_analytics/shared/widgets/liquid_glass_surface.dart';
import 'package:spend_analytics/shared/widgets/liquid_page_scaffold.dart';
import 'package:spend_analytics/shared/widgets/toggle_widget.dart';

class RulesScreen extends GetView<RulesController> {
  const RulesScreen({super.key});

  // ── Static helpers ──────────────────────────────────────────────────────

  static IconData _iconFor(String ruleType) {
    switch (ruleType) {
      case 'budget_threshold':
        return Icons.account_balance_wallet_rounded;
      case 'daily_limit':
        return Icons.payments_rounded;
      case 'no_entry_reminder':
        return Icons.edit_notifications_rounded;
      case 'category_spike':
        return Icons.trending_up_rounded;
      case 'weekend_overspend':
        return Icons.weekend_rounded;
      case 'recurring_due':
        return Icons.refresh_rounded;
      default:
        return Icons.notifications_active_rounded;
    }
  }

  static Color _colorFor(String ruleType) {
    switch (ruleType) {
      case 'budget_threshold':
        return const Color(0xFFFF6B6B);
      case 'daily_limit':
        return const Color(0xFF5B9FFF);
      case 'no_entry_reminder':
        return const Color(0xFFB0A0FF);
      case 'category_spike':
        return const Color(0xFFFF9F40);
      case 'weekend_overspend':
        return const Color(0xFF3FDDA0);
      case 'recurring_due':
        return const Color(0xFFFFB860);
      default:
        return const Color(0xFF5B9FFF);
    }
  }

  // ── Suggested rules (hardcoded templates) ──────────────────────────────

  static const _suggested = <_SuggestedRule>[
    _SuggestedRule(
      type: 'daily_limit',
      label: 'Daily Limit',
      desc: 'Alert when daily spend exceeds a cap',
      icon: Icons.payments_rounded,
      color: Color(0xFF5B9FFF),
    ),
    _SuggestedRule(
      type: 'category_spike',
      label: 'Spike Alert',
      desc: 'Flag unusual category jumps',
      icon: Icons.trending_up_rounded,
      color: Color(0xFFFF9F40),
    ),
    _SuggestedRule(
      type: 'no_entry_reminder',
      label: 'Log Reminder',
      desc: 'Remind if no expense logged today',
      icon: Icons.edit_notifications_rounded,
      color: Color(0xFFB0A0FF),
    ),
    _SuggestedRule(
      type: 'weekend_overspend',
      label: 'Weekend Insight',
      desc: 'Compare weekend vs weekday spend',
      icon: Icons.weekend_rounded,
      color: Color(0xFF3FDDA0),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return LiquidPageScaffold(
      title: 'Smart Rules',
      activeRoute: AppRoutes.rules,
      actions: <Widget>[
        BarActionButton(
          icon: Icons.add_rounded,
          onTap: () => Get.toNamed(AppRoutes.addRule),
        ),
      ],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // ── Automation hero card ──────────────────────────────
          LiquidGlassSurface(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: <Widget>[
                IconBox(
                  icon: Icons.auto_awesome_rounded,
                  color: scheme.primary,
                  size: 52,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Automation',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w800,
                          color: scheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Smart alerts that work for you — set rules and let Spend Analytics handle the rest.',
                        style: TextStyle(
                          fontSize: 13,
                          height: 1.45,
                          color: scheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // ── Active rules ─────────────────────────────────────
          Text(
            'MY RULES',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.8,
              color: scheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 10),

          Obx(() {
            if (controller.rules.isEmpty) {
              return LiquidGlassSurface(
                padding: const EdgeInsets.symmetric(
                  vertical: 28,
                  horizontal: 16,
                ),
                child: Center(
                  child: Column(
                    children: <Widget>[
                      Icon(
                        Icons.rule_rounded,
                        size: 36,
                        color: scheme.onSurfaceVariant.withValues(alpha: 0.4),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'No active rules yet',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: scheme.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Add a rule below to start automating',
                        style: TextStyle(
                          fontSize: 12,
                          color: scheme.onSurfaceVariant.withValues(alpha: 0.7),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }

            return LiquidGlassSurface(
              padding: EdgeInsets.zero,
              child: Column(
                children: List<Widget>.generate(controller.rules.length, (i) {
                  final rule = controller.rules[i];
                  final isLast = i == controller.rules.length - 1;
                  final isDark =
                      Theme.of(context).brightness == Brightness.dark;

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
                                          : Colors.black.withValues(
                                            alpha: 0.06,
                                          ),
                                  width: 0.5,
                                ),
                              ),
                            ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                    child: Row(
                      children: <Widget>[
                        IconBox(
                          icon: _iconFor(rule.ruleType),
                          color: _colorFor(rule.ruleType),
                          size: 42,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                rule.title,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color:
                                      rule.isActive
                                          ? scheme.onSurface
                                          : scheme.onSurfaceVariant,
                                ),
                              ),
                              const SizedBox(height: 3),
                              Text(
                                rule.subtitle,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: scheme.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        SAToggle(
                          value: rule.isActive,
                          onChanged: (v) => controller.toggleRule(rule.id, v),
                        ),
                      ],
                    ),
                  );
                }),
              ),
            );
          }),

          const SizedBox(height: 24),

          // ── Suggested rules ──────────────────────────────────
          Text(
            'SUGGESTED',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.8,
              color: scheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 10),

          SizedBox(
            height: 136,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: _suggested.length,
              separatorBuilder: (_, __) => const SizedBox(width: 10),
              itemBuilder: (ctx, i) {
                final s = _suggested[i];
                return _SuggestedCard(
                  rule: s,
                  onAdd: () async {
                    await controller.addDailyLimitRule();
                    Get.snackbar(
                      'Rule added',
                      '${s.label} rule is now active.',
                      duration: const Duration(seconds: 2),
                    );
                  },
                );
              },
            ),
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

// ── Data ───────────────────────────────────────────────────────────────────

class _SuggestedRule {
  const _SuggestedRule({
    required this.type,
    required this.label,
    required this.desc,
    required this.icon,
    required this.color,
  });
  final String type;
  final String label;
  final String desc;
  final IconData icon;
  final Color color;
}

// ── Widgets ────────────────────────────────────────────────────────────────

class _SuggestedCard extends StatelessWidget {
  const _SuggestedCard({required this.rule, required this.onAdd});
  final _SuggestedRule rule;
  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onAdd,
      child: LiquidGlassSurface(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: SizedBox(
          width: 148,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              IconBox(icon: rule.icon, color: rule.color, size: 36),
              const SizedBox(height: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      rule.label,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: scheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      rule.desc,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 11,
                        height: 1.35,
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: scheme.primary.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(
                    color: scheme.primary.withValues(alpha: 0.25),
                    width: 0.5,
                  ),
                ),
                child: Text(
                  '+ Add rule',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: scheme.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
