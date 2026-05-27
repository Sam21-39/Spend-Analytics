import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spend_analytics/shared/widgets/liquid_glass_surface.dart';
import 'package:spend_analytics/shared/widgets/liquid_page_scaffold.dart';

class SubscriptionPlansScreen extends StatefulWidget {
  const SubscriptionPlansScreen({super.key});

  @override
  State<SubscriptionPlansScreen> createState() => _SubscriptionPlansScreenState();
}

class _SubscriptionPlansScreenState extends State<SubscriptionPlansScreen> {
  bool _yearly      = false;
  int  _selectedIdx = 1; // 0 Free, 1 Pro, 2 Family

  static const _plans = <_Plan>[
    _Plan(
      title: 'Free',
      monthlyPrice: 0,
      yearlyPrice:  0,
      cta:          'Current Plan',
      accent:       Color(0xFF3FDDA0),
      features: <String>[
        'Unlimited transactions',
        '3 budget categories',
        '2 active rules',
        'Local + CSV export',
      ],
    ),
    _Plan(
      title: 'Pro',
      monthlyPrice: 99,
      yearlyPrice:  699,
      cta:          '30-Day Free Trial',
      accent:       Color(0xFF5B9FFF),
      badge:        'Best Value',
      features: <String>[
        'Cloud sync (3 devices)',
        'Unlimited budgets & rules',
        'Receipt attachments',
        'Advanced PDF reports',
        'Priority support',
      ],
    ),
    _Plan(
      title: 'Family',
      monthlyPrice: 199,
      yearlyPrice:  1499,
      cta:          'Choose Family',
      accent:       Color(0xFFB0A0FF),
      features: <String>[
        'Everything in Pro',
        'Up to 5 family members',
        'Shared household budgets',
        'Admin access controls',
        'Consolidated reports',
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return LiquidPageScaffold(
      title:         'Upgrade',
      showBottomNav: false,
      onBack:        () => Get.back<void>(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[

          // ── Crown hero ────────────────────────────────────────
          LiquidGlassSurface(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: <Widget>[
                // Gradient crown icon
                Container(
                  width:  72,
                  height: 72,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: const LinearGradient(
                      colors: <Color>[Color(0xFFFFB860), Color(0xFFFF9F40)],
                      begin: Alignment.topLeft,
                      end:   Alignment.bottomRight,
                    ),
                    boxShadow: const <BoxShadow>[
                      BoxShadow(
                        color:      Color(0x4DFFB860),
                        blurRadius: 20,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.workspace_premium_rounded,
                      size:  36,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Unlock Full Potential',
                  style: TextStyle(
                    fontSize:   22,
                    fontWeight: FontWeight.w800,
                    color:      scheme.onSurface,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 6),
                Text(
                  'Deeper insights, cloud sync, and complete financial control.',
                  style: TextStyle(
                    fontSize: 14,
                    height:   1.5,
                    color:    scheme.onSurfaceVariant,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // ── Billing toggle ────────────────────────────────────
          LiquidGlassSurface(
            padding:      const EdgeInsets.all(4),
            borderRadius: const BorderRadius.all(Radius.circular(999)),
            child: Row(
              children: <Widget>[
                _BillingTab(
                  label:    'Monthly',
                  selected: !_yearly,
                  onTap:    () => setState(() => _yearly = false),
                ),
                _BillingTab(
                  label:    'Yearly',
                  selected: _yearly,
                  badge:    'Save 40%',
                  onTap:    () => setState(() => _yearly = true),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // ── Plan cards ────────────────────────────────────────
          ...List<Widget>.generate(_plans.length, (i) {
            final plan     = _plans[i];
            final selected = _selectedIdx == i;
            final price    = _yearly ? plan.yearlyPrice : plan.monthlyPrice;
            final period   = plan.monthlyPrice == 0
                ? ''
                : _yearly ? '/year' : '/month';

            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: GestureDetector(
                onTap: () => setState(() => _selectedIdx = i),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: selected
                          ? plan.accent.withValues(alpha: 0.6)
                          : Colors.transparent,
                      width: 1.5,
                    ),
                    boxShadow: selected
                        ? <BoxShadow>[
                            BoxShadow(
                              color:      plan.accent.withValues(alpha: 0.12),
                              blurRadius: 20,
                              spreadRadius: 2,
                            ),
                          ]
                        : null,
                  ),
                  child: LiquidGlassSurface(
                    padding: const EdgeInsets.all(18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        // Title row
                        Row(
                          children: <Widget>[
                            Text(
                              plan.title,
                              style: TextStyle(
                                fontSize:   18,
                                fontWeight: FontWeight.w800,
                                color:      scheme.onSurface,
                              ),
                            ),
                            if (plan.badge != null) ...<Widget>[
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical:   3,
                                ),
                                decoration: BoxDecoration(
                                  color:        plan.accent.withValues(alpha: 0.15),
                                  borderRadius: BorderRadius.circular(999),
                                  border: Border.all(
                                    color: plan.accent.withValues(alpha: 0.3),
                                    width: 0.5,
                                  ),
                                ),
                                child: Text(
                                  plan.badge!,
                                  style: TextStyle(
                                    fontSize:   10,
                                    fontWeight: FontWeight.w800,
                                    color:      plan.accent,
                                  ),
                                ),
                              ),
                            ],
                            const Spacer(),
                            // Selection indicator
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 180),
                              width:  20,
                              height: 20,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: selected
                                    ? plan.accent
                                    : Colors.transparent,
                                border: Border.all(
                                  color: selected
                                      ? plan.accent
                                      : scheme.outline.withValues(alpha: 0.4),
                                  width: 1.5,
                                ),
                              ),
                              child: selected
                                  ? const Icon(
                                      Icons.check_rounded,
                                      size:  12,
                                      color: Colors.white,
                                    )
                                  : null,
                            ),
                          ],
                        ),

                        const SizedBox(height: 10),

                        // Price
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: <Widget>[
                            Text(
                              price == 0 ? 'Free' : '₹$price',
                              style: TextStyle(
                                fontSize:   32,
                                fontWeight: FontWeight.w800,
                                color:      plan.accent,
                                letterSpacing: -0.5,
                              ),
                            ),
                            if (period.isNotEmpty) ...<Widget>[
                              const SizedBox(width: 2),
                              Text(
                                period,
                                style: TextStyle(
                                  fontSize: 14,
                                  color:    scheme.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ],
                        ),

                        const SizedBox(height: 14),

                        // Feature list
                        ...plan.features.map((f) => Padding(
                          padding: const EdgeInsets.only(bottom: 7),
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.check_circle_rounded,
                                size:  15,
                                color: plan.accent,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                f,
                                style: TextStyle(
                                  fontSize: 13,
                                  color:    scheme.onSurface,
                                ),
                              ),
                            ],
                          ),
                        )),

                        const SizedBox(height: 14),

                        // CTA button
                        SizedBox(
                          width: double.infinity,
                          child: plan.monthlyPrice == 0
                              ? OutlinedButton(
                                  onPressed: () {},
                                  style: OutlinedButton.styleFrom(
                                    minimumSize: const Size.fromHeight(46),
                                    shape: const StadiumBorder(),
                                    side: BorderSide(
                                      color: scheme.outline.withValues(alpha: 0.4),
                                    ),
                                  ),
                                  child: Text(
                                    plan.cta,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color:      scheme.onSurfaceVariant,
                                    ),
                                  ),
                                )
                              : FilledButton(
                                  onPressed: () => Get.snackbar(
                                    'Coming soon',
                                    '${plan.title} billing will be connected next.',
                                    duration: const Duration(seconds: 2),
                                  ),
                                  style: FilledButton.styleFrom(
                                    minimumSize:    const Size.fromHeight(46),
                                    shape:          const StadiumBorder(),
                                    backgroundColor: plan.accent,
                                    foregroundColor: Colors.white,
                                  ),
                                  child: Text(
                                    plan.cta,
                                    style: const TextStyle(fontWeight: FontWeight.w700),
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),

          const SizedBox(height: 6),

          Center(
            child: TextButton(
              onPressed: () => Get.snackbar(
                'Restore',
                'Restore purchase flow will be connected to billing SDK.',
                duration: const Duration(seconds: 2),
              ),
              child: Text(
                'Restore Purchase',
                style: TextStyle(
                  fontSize: 13,
                  color:    scheme.onSurfaceVariant,
                ),
              ),
            ),
          ),

          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

// ── Data ───────────────────────────────────────────────────────────────────

class _Plan {
  const _Plan({
    required this.title,
    required this.monthlyPrice,
    required this.yearlyPrice,
    required this.cta,
    required this.accent,
    required this.features,
    this.badge,
  });
  final String        title;
  final int           monthlyPrice;
  final int           yearlyPrice;
  final String        cta;
  final Color         accent;
  final List<String>  features;
  final String?       badge;
}

// ── Widgets ────────────────────────────────────────────────────────────────

class _BillingTab extends StatelessWidget {
  const _BillingTab({
    required this.label,
    required this.selected,
    required this.onTap,
    this.badge,
  });
  final String       label;
  final bool         selected;
  final VoidCallback onTap;
  final String?      badge;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(999),
            color:  selected ? scheme.primary.withValues(alpha: 0.18) : Colors.transparent,
            border: selected ? Border.all(color: scheme.primary.withValues(alpha: 0.3), width: 0.5) : null,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                label,
                style: TextStyle(
                  fontSize:   14,
                  fontWeight: FontWeight.w700,
                  color:      selected ? scheme.primary : scheme.onSurfaceVariant,
                ),
              ),
              if (badge != null) ...<Widget>[
                const SizedBox(width: 6),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                  decoration: BoxDecoration(
                    color:        scheme.tertiary.withValues(alpha: 0.18),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    badge!,
                    style: TextStyle(
                      fontSize:   10,
                      fontWeight: FontWeight.w800,
                      color:      scheme.tertiary,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
