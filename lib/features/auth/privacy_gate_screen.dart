import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spend_analytics/core/routes/app_routes.dart';
import 'package:spend_analytics/shared/widgets/icon_box.dart';
import 'package:spend_analytics/shared/widgets/liquid_glass_background.dart';
import 'package:spend_analytics/shared/widgets/liquid_glass_surface.dart';

/// Non-dismissible privacy gate — shown once after first sign-in.
/// Presents three privacy commitments and a single "I understand" CTA.
class PrivacyGateScreen extends StatelessWidget {
  const PrivacyGateScreen({super.key});

  static const _points = <_PrivacyPoint>[
    _PrivacyPoint(
      icon:  Icons.lock_outline_rounded,
      title: 'Local-first by default',
      body:  'Everything lives on your device. Cloud sync is optional.',
    ),
    _PrivacyPoint(
      icon:  Icons.visibility_off_outlined,
      title: 'No ad tracking, ever',
      body:  "We don't sell or share your spend data. Period.",
    ),
    _PrivacyPoint(
      icon:  Icons.sync_rounded,
      title: 'You own your data',
      body:  'Export, delete, or sign out anytime — no questions.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isDark  = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: <Widget>[
          const LiquidGlassBackground(),
          // Scrim
          Container(
            color: Colors.black.withValues(alpha: 0.45),
          ),
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: LiquidGlassSurface(
                  padding:      const EdgeInsets.all(28),
                  borderRadius: const BorderRadius.all(Radius.circular(28)),
                  fillOpacity:  isDark ? 0.18 : 0.78,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      // Shield icon
                      Container(
                        width:  64,
                        height: 64,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin:  Alignment.topLeft,
                            end:    Alignment.bottomRight,
                            colors: <Color>[
                              scheme.tertiary,
                              scheme.tertiary.withValues(alpha: 0.6),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              color:      scheme.tertiary.withValues(alpha: 0.4),
                              blurRadius: 32,
                              offset:     const Offset(0, 12),
                            ),
                          ],
                        ),
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.shield_outlined,
                          size:  32,
                          color: Colors.white,
                        ),
                      ),

                      const SizedBox(height: 20),

                      Text(
                        'A quick word on privacy',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color:      scheme.onSurface,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Before you start logging spend.',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: scheme.onSurfaceVariant,
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Privacy points
                      for (final p in _points) ...<Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            IconBox(
                              icon:  p.icon,
                              color: scheme.primary,
                              size:  36,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    p.title,
                                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                      color:      scheme.onSurface,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    p.body,
                                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      color: scheme.onSurfaceVariant,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),
                      ],

                      const SizedBox(height: 8),

                      // CTA
                      FilledButton(
                        onPressed: () => Get.offAllNamed(AppRoutes.dashboard),
                        style: FilledButton.styleFrom(
                          minimumSize: const Size.fromHeight(54),
                          shape: const StadiumBorder(),
                        ),
                        child: const Text(
                          'I understand',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                        ),
                      ),

                      const SizedBox(height: 12),

                      TextButton(
                        onPressed: () => Get.toNamed(AppRoutes.privacyPolicy),
                        child: Text(
                          'Read the full privacy policy →',
                          style: TextStyle(
                            color:      scheme.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PrivacyPoint {
  const _PrivacyPoint({
    required this.icon,
    required this.title,
    required this.body,
  });
  final IconData icon;
  final String   title;
  final String   body;
}
