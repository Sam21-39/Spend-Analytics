import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spend_analytics/shared/widgets/liquid_glass_background.dart';
import 'package:spend_analytics/shared/widgets/liquid_glass_surface.dart';

class SubscriptionPlansScreen extends StatefulWidget {
  const SubscriptionPlansScreen({super.key});

  @override
  State<SubscriptionPlansScreen> createState() =>
      _SubscriptionPlansScreenState();
}

class _SubscriptionPlansScreenState extends State<SubscriptionPlansScreen> {
  bool yearly = false;

  @override
  Widget build(BuildContext context) {
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
                      icon: const Icon(Icons.close_rounded),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Choose Your Plan',
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(fontWeight: FontWeight.w800),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'Unlock deeper insights and complete financial control.',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 14),
                LiquidGlassSurface(
                  padding: const EdgeInsets.all(6),
                  borderRadius: const BorderRadius.all(Radius.circular(999)),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: _BillingToggle(
                          label: 'Monthly',
                          selected: !yearly,
                          onTap: () => setState(() => yearly = false),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: _BillingToggle(
                          label: 'Yearly',
                          selected: yearly,
                          onTap: () => setState(() => yearly = true),
                          badge: 'Save 40%',
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                _PlanCard(
                  title: 'Free',
                  price: '₹0',
                  period: '',
                  cta: 'Current Plan',
                  highlighted: false,
                  features: const <String>[
                    'Unlimited transactions',
                    '3 categories',
                    '2 active rules',
                    'Local + CSV backup',
                  ],
                ),
                const SizedBox(height: 12),
                _PlanCard(
                  title: 'Pro',
                  price: yearly ? '₹699' : '₹99',
                  period: yearly ? '/year' : '/month',
                  cta: 'Start 30-Day Free Trial',
                  highlighted: true,
                  features: const <String>[
                    'Cloud sync (3 devices)',
                    'Unlimited budgets & rules',
                    'Receipt attachments',
                    'Advanced PDF reports',
                  ],
                ),
                const SizedBox(height: 12),
                _PlanCard(
                  title: 'Family',
                  price: yearly ? '₹1499' : '₹199',
                  period: yearly ? '/year' : '/month',
                  cta: 'Choose Family',
                  highlighted: false,
                  features: const <String>[
                    'All Pro features',
                    'Up to 5 family members',
                    'Shared household budgets',
                    'Admin controls',
                  ],
                ),
                const SizedBox(height: 14),
                Center(
                  child: TextButton(
                    onPressed:
                        () => Get.snackbar(
                          'Restore',
                          'Restore purchase flow will be connected to billing SDK.',
                        ),
                    child: const Text('Restore Purchase'),
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

class _BillingToggle extends StatelessWidget {
  const _BillingToggle({
    required this.label,
    required this.selected,
    required this.onTap,
    this.badge,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;
  final String? badge;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(999),
          color:
              selected
                  ? scheme.primary.withValues(alpha: 0.22)
                  : Colors.transparent,
          border: Border.all(
            color:
                selected
                    ? scheme.primary
                    : Colors.white.withValues(alpha: 0.12),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(label),
            if (badge != null) ...<Widget>[
              const SizedBox(width: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(99),
                  color: const Color(0xFF8382FF).withValues(alpha: 0.2),
                ),
                child: Text(
                  badge!,
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _PlanCard extends StatelessWidget {
  const _PlanCard({
    required this.title,
    required this.price,
    required this.period,
    required this.cta,
    required this.highlighted,
    required this.features,
  });

  final String title;
  final String price;
  final String period;
  final String cta;
  final bool highlighted;
  final List<String> features;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return LiquidGlassSurface(
      opacity: highlighted ? 0.30 : 0.24,
      borderOpacity: highlighted ? 0.35 : 0.2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if (highlighted)
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(999),
                color: scheme.primary.withValues(alpha: 0.2),
              ),
              child: const Text('Best Value'),
            ),
          Text(title, style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 6),
          RichText(
            text: TextSpan(
              text: price,
              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                color: highlighted ? scheme.primary : scheme.onSurface,
                fontWeight: FontWeight.w800,
              ),
              children: <InlineSpan>[
                TextSpan(
                  text: period,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: scheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          ...features.map(
            (feature) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.check_circle_rounded,
                    color: scheme.primary,
                    size: 18,
                  ),
                  const SizedBox(width: 8),
                  Expanded(child: Text(feature)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child:
                highlighted
                    ? FilledButton(
                      onPressed:
                          () => Get.snackbar(
                            'Trial',
                            'Pro trial checkout will be connected next.',
                          ),
                      child: Text(cta),
                    )
                    : OutlinedButton(
                      onPressed:
                          () => Get.snackbar(
                            'Plan Selected',
                            '$title plan selected.',
                          ),
                      child: Text(cta),
                    ),
          ),
        ],
      ),
    );
  }
}
