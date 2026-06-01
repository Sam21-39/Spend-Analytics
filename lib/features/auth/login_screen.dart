import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:screenx/screenx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spend_analytics/features/auth/auth_controller.dart';
import 'package:spend_analytics/shared/widgets/liquid_glass_background.dart';
import 'package:spend_analytics/shared/widgets/sa_shimmer.dart';

class LoginScreen extends GetView<AuthController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;
    final size = MediaQuery.sizeOf(context);
    final isTablet = size.width >= 600;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: <Widget>[
          // ── Animated gradient backdrop ────────────────────────────────
          const LiquidGlassBackground(),

          // ── Subtle decorative orbs ───────────────────────────────────
          Positioned(
            top: -size.height * 0.08,
            left: -size.width * 0.2,
            child: _GlowOrb(
              size: size.width * 0.75,
              color: scheme.primary.withValues(alpha: isDark ? 0.18 : 0.12),
            ),
          ),
          Positioned(
            bottom: size.height * 0.12,
            right: -size.width * 0.25,
            child: _GlowOrb(
              size: size.width * 0.65,
              color: scheme.tertiary.withValues(alpha: isDark ? 0.14 : 0.09),
            ),
          ),

          // ── Content ──────────────────────────────────────────────────
          SafeArea(
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: isTablet ? 440 : double.infinity),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: ScreenX.dp(isTablet ? 0 : 28)),
                  child: Column(
                    children: <Widget>[
                      const Spacer(flex: 2),

                      // ── Logo ─────────────────────────────────────
                      _AnimatedLogoMark(size: ScreenX.dp(isTablet ? 100 : 88), scheme: scheme),
                      SizedBox(height: ScreenX.dp(28)),

                      // ── Title ────────────────────────────────────
                      Text(
                        'Spend Analytics',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: ScreenX.sp(isTablet ? 36 : 32),
                          fontWeight: FontWeight.w900,
                          color: scheme.onSurface,
                          letterSpacing: -1.2,
                          height: 1.0,
                        ),
                      ),
                      SizedBox(height: ScreenX.dp(10)),

                      // ── Subtitle ─────────────────────────────────
                      Text(
                        'Track smarter. Spend calmer.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: ScreenX.sp(isTablet ? 18 : 16),
                          fontWeight: FontWeight.w500,
                          color: scheme.onSurfaceVariant,
                          letterSpacing: 0.1,
                          height: 1.4,
                        ),
                      ),
                      SizedBox(height: ScreenX.dp(6)),
                      Text(
                        'Budgets, expenses & insights — private first.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: ScreenX.sp(13),
                          fontWeight: FontWeight.w400,
                          color: scheme.onSurfaceVariant.withValues(alpha: 0.7),
                          height: 1.4,
                        ),
                      ),

                      const Spacer(flex: 3),

                      // ── Feature pills row ─────────────────────────
                      _FeaturePillRow(scheme: scheme),
                      SizedBox(height: ScreenX.dp(28)),

                      // ── Sign in with Google button ────────────────
                      Obx(() {
                        final loading = controller.isLoading.value;
                        return _GoogleSignInButton(
                          isDark: isDark,
                          loading: loading,
                          onTap: loading ? null : controller.signInWithGoogle,
                        );
                      }),
                      SizedBox(height: ScreenX.dp(12)),

                      // ── Continue as Guest button ──────────────────
                      Obx(() {
                        final loading = controller.isLoading.value;
                        return _GuestButton(
                          scheme: scheme,
                          loading: loading,
                          onTap: loading ? null : controller.continueAsGuest,
                        );
                      }),

                      SizedBox(height: ScreenX.dp(18)),

                      // ── Legal ─────────────────────────────────────
                      Text(
                        'By continuing you agree to our Terms & Privacy Policy.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: ScreenX.sp(11.5),
                          color: scheme.onSurfaceVariant.withValues(alpha: 0.55),
                          height: 1.4,
                        ),
                      ),

                      SizedBox(height: ScreenX.dp(12)),
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

// ── Sub-widgets ─────────────────────────────────────────────────────────────

class _GlowOrb extends StatelessWidget {
  const _GlowOrb({required this.size, required this.color});
  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(colors: <Color>[color, color.withValues(alpha: 0)]),
      ),
    );
  }
}

/// The large hero logo shown on the login screen.
class _AnimatedLogoMark extends StatefulWidget {
  const _AnimatedLogoMark({required this.size, required this.scheme});
  final double size;
  final ColorScheme scheme;

  @override
  State<_AnimatedLogoMark> createState() => _AnimatedLogoMarkState();
}

class _AnimatedLogoMarkState extends State<_AnimatedLogoMark> with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _scale;
  late final Animation<double> _opacity;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 800));
    _scale = CurvedAnimation(parent: _ctrl, curve: Curves.easeOutBack);
    _opacity = CurvedAnimation(parent: _ctrl, curve: Curves.easeIn);
    _ctrl.forward();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = widget.size;
    final scheme = widget.scheme;

    return FadeTransition(
      opacity: _opacity,
      child: ScaleTransition(
        scale: _scale,
        child: Container(
          width: s,
          height: s,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(s * 0.28),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[
                scheme.primary,
                Color.lerp(scheme.primary, scheme.secondary, 0.5)!,
                scheme.tertiary,
              ],
              stops: const <double>[0, 0.5, 1],
            ),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: scheme.primary.withValues(alpha: 0.4),
                blurRadius: 36,
                spreadRadius: 4,
                offset: const Offset(0, 12),
              ),
              BoxShadow(
                color: scheme.tertiary.withValues(alpha: 0.2),
                blurRadius: 24,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              // Frosted glass inner ring
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(s * 0.28),
                    gradient: RadialGradient(
                      colors: <Color>[Colors.white.withValues(alpha: 0.18), Colors.transparent],
                    ),
                  ),
                ),
              ),
              // Bar chart elements
              SvgPicture.asset('assets/images/spend_analytics_logo.svg', width: s, height: s),
            ],
          ),
        ),
      ),
    );
  }
}

class _FeaturePillRow extends StatelessWidget {
  const _FeaturePillRow({required this.scheme});
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,

      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _Pill(
            icon: Icons.shield_rounded,
            label: 'Offline-first',
            color: scheme.secondary,
            scheme: scheme,
          ),
          SizedBox(width: ScreenX.dp(10)),
          _Pill(
            icon: Icons.cloud_done_rounded,
            label: 'Cloud sync',
            color: scheme.primary,
            scheme: scheme,
          ),
          SizedBox(width: ScreenX.dp(10)),
          _Pill(
            icon: Icons.auto_graph_rounded,
            label: 'Smart insights',
            color: scheme.tertiary,
            scheme: scheme,
          ),
        ],
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  const _Pill({required this.icon, required this.label, required this.color, required this.scheme});
  final IconData icon;
  final String label;
  final Color color;
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: ScreenX.dp(10), vertical: ScreenX.dp(6)),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: color.withValues(alpha: 0.25), width: 0.8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(icon, size: ScreenX.dp(13), color: color),
          SizedBox(width: ScreenX.dp(5)),
          Text(
            label,
            style: TextStyle(
              fontSize: ScreenX.sp(11.5),
              fontWeight: FontWeight.w700,
              color: scheme.onSurface,
              letterSpacing: 0.1,
            ),
          ),
        ],
      ),
    );
  }
}

class _GoogleSignInButton extends StatelessWidget {
  const _GoogleSignInButton({required this.isDark, required this.loading, required this.onTap});
  final bool isDark;
  final bool loading;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 120),
        height: ScreenX.dp(56),
        decoration: BoxDecoration(
          color: isDark ? Colors.white : Colors.black,
          borderRadius: BorderRadius.circular(ScreenX.dp(18)),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: (isDark ? Colors.white : Colors.black).withValues(alpha: 0.18),
              blurRadius: 24,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child:
            loading
                ? const Center(
                  child: SAShimmer(child: SAShimmerBox(width: 160, height: 14, radius: 8)),
                )
                : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _GoogleGlyph(isDark: isDark),
                    SizedBox(width: ScreenX.dp(10)),
                    Text(
                      'Continue with Google',
                      style: TextStyle(
                        fontSize: ScreenX.sp(15),
                        fontWeight: FontWeight.w800,
                        color: isDark ? Colors.black : Colors.white,
                        letterSpacing: -0.1,
                      ),
                    ),
                  ],
                ),
      ),
    );
  }
}

class _GuestButton extends StatelessWidget {
  const _GuestButton({required this.scheme, required this.loading, required this.onTap});
  final ColorScheme scheme;
  final bool loading;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: ScreenX.dp(52),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(ScreenX.dp(16)),
          border: Border.all(color: scheme.outline.withValues(alpha: 0.30), width: 1),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(ScreenX.dp(16)),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
            child: Container(
              color: scheme.surfaceContainerHighest.withValues(alpha: 0.08),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.person_outline_rounded,
                    size: ScreenX.dp(18),
                    color: scheme.onSurfaceVariant,
                  ),
                  SizedBox(width: ScreenX.dp(8)),
                  Text(
                    'Continue as Guest',
                    style: TextStyle(
                      fontSize: ScreenX.sp(14),
                      fontWeight: FontWeight.w700,
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _GoogleGlyph extends StatelessWidget {
  const _GoogleGlyph({required this.isDark});
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenX.dp(22),
      height: ScreenX.dp(22),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isDark ? Colors.black : Colors.white,
        shape: BoxShape.circle,
      ),
      child: Text(
        'G',
        style: TextStyle(
          color: isDark ? Colors.white : Colors.black,
          fontSize: ScreenX.sp(11),
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }
}
