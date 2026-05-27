import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spend_analytics/shared/widgets/icon_box.dart';
import 'package:spend_analytics/shared/widgets/liquid_glass_surface.dart';
import 'package:spend_analytics/shared/widgets/liquid_page_scaffold.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return LiquidPageScaffold(
      title:         'Privacy Policy',
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
                  icon:  Icons.privacy_tip_rounded,
                  color: const Color(0xFF5B9FFF),
                  size:  52,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Your Data, Your Control',
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

          _LegalSection(
            title: 'Our Commitment',
            body:  'At Spend Analytics, your financial data is exclusively yours. '
                   'We do not build an ad business and we do not monetize your personal finance records.',
          ),

          _LegalSection(
            title:   'Privacy First Principles',
            bullets: const <String>[
              'Zero ads policy',
              'No selling, renting, or trading your data',
              'Isolated cloud sync infrastructure',
              'No SMS scraping or message access',
            ],
          ),

          _LegalSection(
            title:   'How We Use Data',
            bullets: const <String>[
              'Anonymized analytics for app stability only',
              'Encrypted storage of transactions, budgets, and rules',
              'No sharing of identifiable financial records with third parties',
            ],
          ),

          _LegalSection(
            title: 'Your Rights',
            body:  'You can export your data and request account deletion at any time. '
                   'Deletion permanently removes your records from all active systems within 30 days.',
          ),

          const SizedBox(height: 8),

          Center(
            child: Text(
              'Spend Analytics · Privacy Policy · May 2026',
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

class _LegalSection extends StatelessWidget {
  const _LegalSection({required this.title, this.body, this.bullets});
  final String        title;
  final String?       body;
  final List<String>? bullets;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: LiquidGlassSurface(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(
                fontSize:   15,
                fontWeight: FontWeight.w800,
                color:      scheme.onSurface,
              ),
            ),
            if (body != null) ...<Widget>[
              const SizedBox(height: 8),
              Text(
                body!,
                style: TextStyle(
                  fontSize: 14,
                  height:   1.5,
                  color:    scheme.onSurfaceVariant,
                ),
              ),
            ],
            if (bullets != null) ...<Widget>[
              const SizedBox(height: 10),
              ...bullets!.map((item) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Container(
                        width:  6,
                        height: 6,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: scheme.primary.withValues(alpha: 0.7),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        item,
                        style: TextStyle(
                          fontSize: 14,
                          height:   1.4,
                          color:    scheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
            ],
          ],
        ),
      ),
    );
  }
}
