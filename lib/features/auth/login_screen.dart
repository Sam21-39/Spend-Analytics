import 'dart:ui';

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
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: <Widget>[
          const LiquidGlassBackground(),
          SafeArea(
            child: Column(
              children: <Widget>[
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.fromLTRB(20, 26, 20, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Align(child: _LogoMark(size: 78, scheme: scheme)),
                        const SizedBox(height: 18),
                        Text(
                          'Track smarter.\nSpend calmer.',
                          textAlign: TextAlign.center,
                          style: theme.textTheme.headlineLarge?.copyWith(
                            color: scheme.onSurface,
                            fontWeight: FontWeight.w900,
                            letterSpacing: -1.0,
                            height: 1.04,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'One place for your expenses, budgets, and insights.\nPrivate first. Sync when you choose.',
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodyLarge?.copyWith(
                            color: scheme.onSurfaceVariant,
                            height: 1.35,
                          ),
                        ),
                        const SizedBox(height: 22),
                        LiquidGlassSurface(
                          padding: const EdgeInsets.all(18),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(26),
                          ),
                          fillOpacity: isDark ? 0.1 : 0.68,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  SAPill(
                                    label: 'Offline-first',
                                    color: scheme.secondary,
                                    icon: Icons.shield_rounded,
                                  ),
                                  const SizedBox(width: 8),
                                  SAPill(
                                    label: 'Realtime sync',
                                    color: scheme.tertiary,
                                    icon: Icons.cloud_done_rounded,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 14),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: _BrandStat(
                                      label: 'Monthly spend',
                                      value: '₹24,580',
                                      color: scheme.onSurface,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: _BrandStat(
                                      label: 'Transactions',
                                      value: '47',
                                      color: scheme.primary,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Divider(
                                height: 1,
                                color: scheme.outline.withValues(alpha: 0.25),
                              ),
                              const SizedBox(height: 12),
                              const _ValueProp(
                                icon: Icons.auto_graph_rounded,
                                text:
                                    'Instant analytics with category-level trends.',
                              ),
                              const SizedBox(height: 8),
                              const _ValueProp(
                                icon: Icons.lock_rounded,
                                text: 'Your data stays secure on-device first.',
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 14, 20, 28),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Obx(() {
                        final loading = controller.isLoading.value;
                        return FilledButton(
                          onPressed:
                              loading ? null : controller.signInWithGoogle,
                          style: FilledButton.styleFrom(
                            minimumSize: const Size.fromHeight(56),
                            backgroundColor:
                                isDark ? Colors.white : Colors.black,
                            foregroundColor:
                                isDark ? Colors.black : Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                            textStyle: const TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 15,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              if (!loading) const _GoogleGlyph(),
                              if (!loading) const SizedBox(width: 10),
                              loading
                                  ? const SAShimmer(
                                    child: SAShimmerBox(
                                      width: 150,
                                      height: 14,
                                      radius: 8,
                                    ),
                                  )
                                  : const Text('Continue with Google'),
                            ],
                          ),
                        );
                      }),
                      const SizedBox(height: 10),
                      Obx(() {
                        final loading = controller.isLoading.value;
                        return OutlinedButton.icon(
                          onPressed:
                              loading ? null : controller.continueAsGuest,
                          icon: const Icon(
                            Icons.person_outline_rounded,
                            size: 18,
                          ),
                          label: const Text('Continue as Guest'),
                          style: OutlinedButton.styleFrom(
                            minimumSize: const Size.fromHeight(52),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            side: BorderSide(
                              color: scheme.outline.withValues(alpha: 0.35),
                            ),
                            foregroundColor: scheme.onSurfaceVariant,
                            textStyle: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                            ),
                          ),
                        );
                      }),
                      const SizedBox(height: 8),
                      Text(
                        'By continuing, you agree to Terms and Privacy Policy.',
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: scheme.onSurfaceVariant.withValues(
                            alpha: 0.72,
                          ),
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
        borderRadius: BorderRadius.circular(size * 0.28),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            scheme.primary,
            Color.lerp(scheme.primary, scheme.secondary, 0.55)!,
            scheme.tertiary,
          ],
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: scheme.primary.withValues(alpha: 0.35),
            blurRadius: 24,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            left: size * 0.22,
            bottom: size * 0.23,
            child: _Bar(height: size * 0.24),
          ),
          Positioned(
            left: size * 0.42,
            bottom: size * 0.23,
            child: _Bar(height: size * 0.34),
          ),
          Positioned(
            left: size * 0.62,
            bottom: size * 0.23,
            child: _Bar(height: size * 0.46),
          ),
          Positioned(
            top: size * 0.32,
            child: Icon(
              Icons.trending_up_rounded,
              color: Colors.white.withValues(alpha: 0.94),
              size: size * 0.28,
            ),
          ),
        ],
      ),
    );
  }
}

class _Bar extends StatelessWidget {
  const _Bar({required this.height});

  final double height;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 1.8, sigmaY: 1.8),
        child: Container(
          width: 8.5,
          height: height,
          color: Colors.white.withValues(alpha: 0.82),
        ),
      ),
    );
  }
}

class _BrandStat extends StatelessWidget {
  const _BrandStat({
    required this.label,
    required this.value,
    required this.color,
  });

  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest.withValues(alpha: 0.26),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: scheme.outline.withValues(alpha: 0.15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            label.toUpperCase(),
            style: theme.textTheme.labelSmall?.copyWith(
              color: scheme.onSurfaceVariant,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: theme.textTheme.titleLarge?.copyWith(
              color: color,
              fontWeight: FontWeight.w900,
              letterSpacing: -0.4,
            ),
          ),
        ],
      ),
    );
  }
}

class _ValueProp extends StatelessWidget {
  const _ValueProp({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Row(
      children: <Widget>[
        Icon(icon, size: 16, color: scheme.primary),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: scheme.onSurfaceVariant,
              height: 1.3,
            ),
          ),
        ),
      ],
    );
  }
}

class _GoogleGlyph extends StatelessWidget {
  const _GoogleGlyph();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20,
      height: 20,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(999),
      ),
      child: const Text(
        'G',
        style: TextStyle(
          color: Colors.black,
          fontSize: 11,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }
}
