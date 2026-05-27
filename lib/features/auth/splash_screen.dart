import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spend_analytics/core/routes/app_routes.dart';
import 'package:spend_analytics/shared/widgets/liquid_glass_background.dart';

/// Animated splash screen — logo with concentric rings, app name, version.
/// Navigates to [AppRoutes.onboarding] after 2 seconds.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double>   _fadeIn;
  late final Animation<double>   _scaleIn;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync:    this,
      duration: const Duration(milliseconds: 900),
    );
    _fadeIn  = CurvedAnimation(parent: _ctrl, curve: Curves.easeOut);
    _scaleIn = Tween<double>(begin: 0.85, end: 1.0)
        .animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOutCubic));

    _ctrl.forward();

    Future<void>.delayed(const Duration(milliseconds: 2200), () {
      // Navigate to onboarding on first launch, login otherwise.
      // AppRoutes.onboarding is registered in app_routes.dart.
      if (mounted) Get.offAllNamed(AppRoutes.login);
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: <Widget>[
          const LiquidGlassBackground(),

          // Center logo + wordmark
          Center(
            child: FadeTransition(
              opacity: _fadeIn,
              child: ScaleTransition(
                scale: _scaleIn,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    // Logo with 3 concentric rings
                    SizedBox(
                      width:  180,
                      height: 180,
                      child: Stack(
                        alignment: Alignment.center,
                        children: <Widget>[
                          for (int i = 0; i < 3; i++)
                            Container(
                              width:  92.0 + i * 28,
                              height: 92.0 + i * 28,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: scheme.primary
                                      .withValues(alpha: 0.30 - i * 0.09),
                                  width: 1,
                                ),
                              ),
                            ),
                          _LogoMark(size: 92, scheme: scheme),
                        ],
                      ),
                    ),
                    const SizedBox(height: 28),
                    Text(
                      'Spend Analytics',
                      style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        color:         scheme.onSurface,
                        fontWeight:    FontWeight.w800,
                        fontSize:      30,
                        letterSpacing: -0.8,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Your private-first financial companion',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Bottom: dots + version
          Positioned(
            left:   0,
            right:  0,
            bottom: 48,
            child: FadeTransition(
              opacity: _fadeIn,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List<Widget>.generate(3, (i) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 3),
                        width:  8,
                        height: 8,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: scheme.primary.withValues(
                            alpha: i == 1 ? 1.0 : 0.3,
                          ),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'v3.0.0 · Offline-first · Encrypted',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: scheme.onSurfaceVariant.withValues(alpha: 0.7),
                    ),
                  ),
                ],
              ),
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
      width:  size,
      height: size,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin:  Alignment.topLeft,
          end:    Alignment.bottomRight,
          colors: <Color>[scheme.primary, scheme.secondary],
        ),
        borderRadius: BorderRadius.circular(size * 0.28),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color:      scheme.primary.withValues(alpha: 0.4),
            blurRadius: 32,
            offset:     const Offset(0, 12),
          ),
          const BoxShadow(
            color:      Color(0x33FFFFFF),
            blurRadius: 0,
            spreadRadius: -1,
          ),
        ],
      ),
      alignment: Alignment.center,
      child: Icon(
        Icons.bar_chart_rounded,
        size:  size * 0.55,
        color: Colors.white,
      ),
    );
  }
}
