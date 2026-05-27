import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spend_analytics/features/auth/auth_controller.dart';
import 'package:spend_analytics/shared/widgets/liquid_glass_background.dart';
import 'package:spend_analytics/shared/widgets/liquid_glass_surface.dart';

class LoginScreen extends GetView<AuthController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isDark  = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: <Widget>[
          const LiquidGlassBackground(),
          SafeArea(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 460),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical:   24,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      // ── Hero card ──────────────────────────────────────
                      LiquidGlassSurface(
                        padding:     const EdgeInsets.all(28),
                        borderRadius: const BorderRadius.all(Radius.circular(28)),
                        fillOpacity: isDark ? 0.10 : 0.66,
                        child: Column(
                          children: <Widget>[
                            // Logo mark
                            Container(
                              width:  72,
                              height: 72,
                              decoration: BoxDecoration(
                                color:        scheme.primaryContainer
                                    .withValues(alpha: isDark ? 0.30 : 0.50),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Icon(
                                Icons.bar_chart_rounded,
                                size:  36,
                                color: scheme.primary,
                              ),
                            ),
                            const SizedBox(height: 18),

                            // App name
                            Text(
                              'Spend Analytics',
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                                color:       scheme.onSurface,
                                fontWeight:  FontWeight.w800,
                                letterSpacing: -1.0,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              'Your private-first financial companion',
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                color: scheme.onSurfaceVariant,
                              ),
                            ),
                            const SizedBox(height: 24),

                            // Benefits
                            _BenefitRow(
                              icon:     Icons.cloud_sync_rounded,
                              title:    'Cloud Sync',
                              subtitle: 'Access your data on any device.',
                              color:    scheme.primary,
                            ),
                            const SizedBox(height: 4),
                            _BenefitRow(
                              icon:     Icons.auto_awesome_rounded,
                              title:    'Smart Alerts',
                              subtitle: 'Rule-driven insights and nudges.',
                              color:    scheme.secondary,
                            ),
                            const SizedBox(height: 4),
                            _BenefitRow(
                              icon:     Icons.shield_rounded,
                              title:    'Privacy First',
                              subtitle: 'No ads. No data brokerage. Ever.',
                              color:    scheme.tertiary,
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      // ── Google sign-in ─────────────────────────────────
                      Obx(
                        () => FilledButton.icon(
                          onPressed: controller.isLoading.value
                              ? null
                              : controller.signInWithGoogle,
                          icon:  const Icon(Icons.g_mobiledata_rounded, size: 22),
                          label: const Text('Continue with Google'),
                          style: FilledButton.styleFrom(
                            minimumSize: const Size.fromHeight(54),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(999),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),

                      // ── Guest mode ─────────────────────────────────────
                      Obx(
                        () => TextButton(
                          onPressed: controller.isLoading.value
                              ? null
                              : controller.continueAsGuest,
                          child: Text(
                            'Continue as Guest',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color:      scheme.primary,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 6),
                      Text(
                        'Guest mode keeps data local on this device.',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: scheme.onSurfaceVariant.withValues(alpha: 0.70),
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

class _BenefitRow extends StatelessWidget {
  const _BenefitRow({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
  });

  final IconData icon;
  final String   title;
  final String   subtitle;
  final Color    color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: <Widget>[
          Container(
            width:  40,
            height: 40,
            decoration: BoxDecoration(
              color:        color.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 1),
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
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
