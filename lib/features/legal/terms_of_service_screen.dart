import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spend_analytics/shared/widgets/icon_box.dart';
import 'package:spend_analytics/shared/widgets/liquid_glass_surface.dart';
import 'package:spend_analytics/shared/widgets/liquid_page_scaffold.dart';

class TermsOfServiceScreen extends StatelessWidget {
  const TermsOfServiceScreen({super.key});

  static const _clauses = <_Clause>[
    _Clause(
      title: 'Agreement to Terms',
      body:  'By using Spend Analytics, you agree to these terms and to use the app in compliance with applicable law.',
    ),
    _Clause(
      title: 'User Accounts',
      body:  'You are responsible for account access and usage under your credentials. Keep your sign-in secure.',
    ),
    _Clause(
      title: 'Pro Subscriptions',
      body:  'Paid plans renew automatically unless canceled before renewal. Billing is managed by the app store.',
    ),
    _Clause(
      title: 'Data Ownership',
      body:  'You retain ownership of all financial records you enter. Spend Analytics does not claim ownership of your data.',
    ),
    _Clause(
      title: 'Acceptable Use',
      body:  'You agree not to misuse, disrupt, reverse engineer, or scrape the service.',
    ),
    _Clause(
      title: 'Limitation of Liability',
      body:  'Spend Analytics provides personal finance tooling and does not provide legal, tax, or investment advice.',
    ),
    _Clause(
      title: 'Termination',
      body:  'You may delete your account at any time. Data is removed per our privacy commitments within 30 days.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return LiquidPageScaffold(
      title:         'Terms of Service',
      showBottomNav: false,
      onBack:        () => Get.back<void>(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[

          // ── Hero ─────────────────────────────────────────────
          LiquidGlassSurface(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: <Widget>[
                IconBox(
                  icon:  Icons.description_rounded,
                  color: const Color(0xFFB0A0FF),
                  size:  52,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Terms of Service',
                        style: TextStyle(
                          fontSize:   16,
                          fontWeight: FontWeight.w800,
                          color:      scheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Last updated May 2026',
                        style: TextStyle(
                          fontSize: 12,
                          color:    scheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // ── Clauses as a single glass card with dividers ────
          LiquidGlassSurface(
            padding: EdgeInsets.zero,
            child: Column(
              children: List<Widget>.generate(_clauses.length, (i) {
                final clause  = _clauses[i];
                final isLast  = i == _clauses.length - 1;
                final isDark   = Theme.of(context).brightness == Brightness.dark;

                return Container(
                  decoration: isLast
                      ? null
                      : BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: isDark
                                  ? Colors.white.withValues(alpha: 0.08)
                                  : Colors.black.withValues(alpha: 0.06),
                              width: 0.5,
                            ),
                          ),
                        ),
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            width:  22,
                            height: 22,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: scheme.primary.withValues(alpha: 0.12),
                            ),
                            child: Text(
                              '${i + 1}',
                              style: TextStyle(
                                fontSize:   11,
                                fontWeight: FontWeight.w800,
                                color:      scheme.primary,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            clause.title,
                            style: TextStyle(
                              fontSize:   14,
                              fontWeight: FontWeight.w700,
                              color:      scheme.onSurface,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        clause.body,
                        style: TextStyle(
                          fontSize: 13,
                          height:   1.5,
                          color:    scheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ),

          const SizedBox(height: 16),

          Center(
            child: Text(
              'Spend Analytics · Terms of Service · May 2026',
              style: TextStyle(
                fontSize: 11,
                color:    scheme.onSurfaceVariant.withValues(alpha: 0.5),
              ),
            ),
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class _Clause {
  const _Clause({required this.title, required this.body});
  final String title;
  final String body;
}
