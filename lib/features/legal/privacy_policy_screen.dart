import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spend_analytics/shared/widgets/liquid_glass_background.dart';
import 'package:spend_analytics/shared/widgets/liquid_glass_surface.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final muted = Theme.of(context).colorScheme.onSurfaceVariant;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: <Widget>[
          const LiquidGlassBackground(),
          SafeArea(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 28),
              children: <Widget>[
                Row(
                  children: <Widget>[
                    IconButton(
                      onPressed: () => Get.back<void>(),
                      icon: const Icon(Icons.arrow_back_rounded),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Privacy Policy',
                      style: textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                _Section(
                  title: 'Our Commitment',
                  body:
                      'At Spend Analytics, your financial data is exclusively yours. We do not build an ad business and we do not monetize your personal finance records.',
                ),
                _Section(
                  title: 'Privacy First Principles',
                  bullets: const <String>[
                    'Zero ads policy',
                    'No selling, renting, or trading your data',
                    'Isolated cloud sync infrastructure',
                    'No SMS scraping to read personal messages',
                  ],
                ),
                _Section(
                  title: 'How We Use Data',
                  bullets: const <String>[
                    'Anonymized analytics for stability and performance only',
                    'Encrypted storage of transactions, budgets, and rules for app functionality',
                    'No sharing of identifiable financial records with third parties',
                  ],
                ),
                _Section(
                  title: 'Your Rights',
                  body:
                      'You can export your data and request account deletion. Deletion permanently removes your records from active systems.',
                ),
                const SizedBox(height: 8),
                Center(
                  child: Text(
                    'Last updated: May 2026',
                    style: textTheme.labelMedium?.copyWith(color: muted),
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

class _Section extends StatelessWidget {
  const _Section({required this.title, this.body, this.bullets});

  final String title;
  final String? body;
  final List<String>? bullets;

  @override
  Widget build(BuildContext context) {
    final muted = Theme.of(context).colorScheme.onSurfaceVariant;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: LiquidGlassSurface(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(title, style: Theme.of(context).textTheme.titleLarge),
            if (body != null) ...<Widget>[
              const SizedBox(height: 8),
              Text(
                body!,
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(color: muted),
              ),
            ],
            if (bullets != null) ...<Widget>[
              const SizedBox(height: 8),
              ...bullets!.map(
                (item) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Padding(
                        padding: EdgeInsets.only(top: 6),
                        child: Icon(Icons.circle, size: 7),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          item,
                          style: Theme.of(
                            context,
                          ).textTheme.bodyMedium?.copyWith(color: muted),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
