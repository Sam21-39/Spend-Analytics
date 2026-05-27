import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spend_analytics/shared/widgets/liquid_glass_background.dart';
import 'package:spend_analytics/shared/widgets/liquid_glass_surface.dart';

class TermsOfServiceScreen extends StatelessWidget {
  const TermsOfServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

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
                      'Terms of Service',
                      style: textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const _Clause(
                  title: 'Agreement to Terms',
                  body:
                      'By using Spend Analytics, you agree to these terms and to use the app in compliance with applicable law.',
                ),
                const _Clause(
                  title: 'User Accounts',
                  body:
                      'You are responsible for account access and usage under your credentials. Keep your sign-in secure.',
                ),
                const _Clause(
                  title: 'Pro Subscriptions',
                  body:
                      'Paid plans renew automatically unless canceled before renewal. Billing is managed by the app store.',
                ),
                const _Clause(
                  title: 'Data Ownership',
                  body:
                      'You retain ownership of all financial records you enter. Spend Analytics does not claim ownership of your data.',
                ),
                const _Clause(
                  title: 'Acceptable Use',
                  body:
                      'You agree not to misuse, disrupt, reverse engineer, or scrape the service.',
                ),
                const _Clause(
                  title: 'Limitation of Liability',
                  body:
                      'Spend Analytics provides personal finance tooling and does not provide legal, tax, or investment advice.',
                ),
                const _Clause(
                  title: 'Termination',
                  body:
                      'You may delete your account at any time. Data is removed per our privacy commitments.',
                ),
                const SizedBox(height: 8),
                Center(
                  child: Text(
                    'Last updated: May 2026',
                    style: textTheme.labelMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
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

class _Clause extends StatelessWidget {
  const _Clause({required this.title, required this.body});

  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: LiquidGlassSurface(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(title, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Text(
              body,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
