import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spend_analytics/features/auth/auth_controller.dart';
import 'package:spend_analytics/shared/widgets/liquid_glass_background.dart';
import 'package:spend_analytics/shared/widgets/liquid_glass_surface.dart';
import 'package:spend_analytics/shared/widgets/sa_pill.dart';
import 'package:spend_analytics/shared/widgets/sa_shimmer.dart';

class LoginScreen extends GetView<AuthController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: <Widget>[
          const LiquidGlassBackground(),
          SafeArea(
            child: Column(
              children: <Widget>[
                // ── Scrollable hero ───────────────────────────────
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(24, 40, 24, 0),
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: <Widget>[
                        // Logo
                        _LogoMark(size: 72, scheme: scheme),
                        const SizedBox(height: 20),

                        // Welcome text
                        Text(
                          'Welcome back',
                          textAlign: TextAlign.center,
                          style: Theme.of(
                            context,
                          ).textTheme.headlineLarge?.copyWith(
                            color: scheme.onSurface,
                            fontWeight: FontWeight.w800,
                            fontSize: 32,
                            letterSpacing: -0.8,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Sign in to sync across devices,\nor skip ahead in guest mode.',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(color: scheme.onSurfaceVariant),
                        ),

                        const SizedBox(height: 32),

                        // Hero preview card
                        LiquidGlassSurface(
                          padding: const EdgeInsets.all(24),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(28),
                          ),
                          fillOpacity: isDark ? 0.10 : 0.66,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'THIS MONTH',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 1.1,
                                  color: scheme.onSurfaceVariant,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                '₹24,580',
                                style: TextStyle(
                                  fontSize: 36,
                                  fontWeight: FontWeight.w800,
                                  color: scheme.onSurface,
                                  letterSpacing: -0.8,
                                  fontFeatures: const <FontFeature>[
                                    FontFeature.tabularFigures(),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: <Widget>[
                                  SAPill(
                                    label: '12% vs Apr',
                                    color: scheme.tertiary,
                                    icon: Icons.arrow_downward_rounded,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    '· 47 transactions',
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodyMedium?.copyWith(
                                      color: scheme.onSurfaceVariant,
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                                child: Divider(
                                  color: scheme.outline.withValues(alpha: 0.4),
                                  height: 1,
                                ),
                              ),
                              Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.shield_outlined,
                                    size: 16,
                                    color: scheme.tertiary,
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    'Encrypted on your device first',
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodyMedium?.copyWith(
                                      color: scheme.onSurfaceVariant,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // ── Bottom CTAs ───────────────────────────────────
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 16, 24, 36),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      // Google sign-in
                      Obx(() {
                        final loading = controller.isLoading.value;
                        return FilledButton.icon(
                          onPressed:
                              loading ? null : controller.signInWithGoogle,
                          icon:
                              loading ? const SizedBox(width: 22) : _GoogleG(),
                          label:
                              loading
                                  ? const SAShimmer(
                                    child: SAShimmerBox(
                                      width: 140,
                                      height: 14,
                                      radius: 8,
                                    ),
                                  )
                                  : const Text('Continue with Google'),
                          style: FilledButton.styleFrom(
                            backgroundColor:
                                isDark ? Colors.white : Colors.black,
                            foregroundColor:
                                isDark ? Colors.black : Colors.white,
                            minimumSize: const Size.fromHeight(54),
                            shape: const StadiumBorder(),
                            textStyle: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        );
                      }),

                      const SizedBox(height: 12),

                      // Guest mode
                      Obx(() {
                        final loading = controller.isLoading.value;
                        return TextButton(
                          onPressed:
                              loading ? null : controller.continueAsGuest,
                          style: TextButton.styleFrom(
                            minimumSize: const Size.fromHeight(50),
                          ),
                          child:
                              loading
                                  ? const SAShimmer(
                                    child: SAShimmerBox(
                                      width: 130,
                                      height: 14,
                                      radius: 8,
                                    ),
                                  )
                                  : Text(
                                    'Continue as guest →',
                                    style: TextStyle(
                                      color: scheme.onSurfaceVariant,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                        );
                      }),

                      const SizedBox(height: 6),

                      Text(
                        'By continuing, you agree to our Terms & Privacy.',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: scheme.onSurfaceVariant.withValues(alpha: 0.7),
                        ),
                      ),
                    ],
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

class _LogoMark extends StatelessWidget {
  const _LogoMark({required this.size, required this.scheme});
  final double size;
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[scheme.primary, scheme.secondary],
        ),
        borderRadius: BorderRadius.circular(size * 0.28),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: scheme.primary.withValues(alpha: 0.4),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      alignment: Alignment.center,
      child: Icon(
        Icons.bar_chart_rounded,
        size: size * 0.55,
        color: Colors.white,
      ),
    );
  }
}

/// Google-coloured "G" icon used on the sign-in button.
class _GoogleG extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Icon(Icons.g_mobiledata_rounded, size: 22);
  }
}
