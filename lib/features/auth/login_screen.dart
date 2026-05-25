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
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      LiquidGlassSurface(
                        padding: const EdgeInsets.all(26),
                        child: Column(
                          children: <Widget>[
                            const Icon(
                              Icons.savings_rounded,
                              size: 56,
                              color: Color(0xFFADC6FF),
                            ),
                            const SizedBox(height: 14),
                            Text(
                              'SpendSense',
                              style: Theme.of(
                                context,
                              ).textTheme.displaySmall?.copyWith(
                                color: scheme.primary,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Your private-first financial companion',
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodyLarge
                                  ?.copyWith(color: scheme.onSurfaceVariant),
                            ),
                            const SizedBox(height: 18),
                            _BenefitRow(
                              icon: Icons.cloud_sync_rounded,
                              title: 'Cloud Sync',
                              subtitle: 'Access your data anywhere.',
                              color: scheme.primary,
                            ),
                            _BenefitRow(
                              icon: Icons.lightbulb_rounded,
                              title: 'Smart Alerts',
                              subtitle: 'Rule-driven insights and nudges.',
                              color: scheme.tertiary,
                            ),
                            _BenefitRow(
                              icon: Icons.shield_rounded,
                              title: 'Privacy First',
                              subtitle: 'No ads. No data brokerage.',
                              color: scheme.secondary,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 18),
                      Obx(
                        () => FilledButton.icon(
                          onPressed:
                              controller.isLoading.value
                                  ? null
                                  : controller.signInWithGoogle,
                          icon: const Icon(Icons.g_mobiledata_rounded),
                          label: const Text('Sign in with Google'),
                          style: FilledButton.styleFrom(
                            minimumSize: const Size.fromHeight(54),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(999),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Obx(
                        () => TextButton(
                          onPressed:
                              controller.isLoading.value
                                  ? null
                                  : controller.continueAsGuest,
                          child: Text(
                            'Continue as Guest',
                            style: Theme.of(
                              context,
                            ).textTheme.titleMedium?.copyWith(
                              color: scheme.primary,
                              fontWeight: FontWeight.w700,
                            ),
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

class _BenefitRow extends StatelessWidget {
  const _BenefitRow({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: <Widget>[
          CircleAvatar(
            backgroundColor: Colors.white.withValues(alpha: 0.07),
            child: Icon(icon, color: color),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(title, style: Theme.of(context).textTheme.titleSmall),
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
