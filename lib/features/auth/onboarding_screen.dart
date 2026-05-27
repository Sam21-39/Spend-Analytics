import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spend_analytics/core/routes/app_routes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spend_analytics/shared/widgets/liquid_glass_background.dart';
import 'package:spend_analytics/shared/widgets/liquid_glass_surface.dart';

/// 3-step onboarding carousel — slides through Track / See / Yours alone.
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int _step = 0;

  static const _slides = <_Slide>[
    _Slide(
      icon: Icons.account_balance_wallet_outlined,
      title: 'Track every rupee',
      body:
          'Log expenses in seconds — by voice, by tap, or set them on autopilot.',
    ),
    _Slide(
      icon: Icons.pie_chart_outline_rounded,
      title: 'See where it goes',
      body: 'Beautiful breakdowns by category, merchant, and time of day.',
    ),
    _Slide(
      icon: Icons.shield_outlined,
      title: 'Yours alone',
      body: 'Offline-first, end-to-end encrypted. Your money is your business.',
    ),
  ];

  Future<void> _finishOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboarding_seen', true);
  }

  void _next() async {
    if (_step < _slides.length - 1) {
      setState(() => _step++);
    } else {
      await _finishOnboarding();
      Get.offAllNamed(AppRoutes.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final slide = _slides[_step];

    final colors = <Color>[scheme.primary, scheme.secondary, scheme.tertiary];
    final accentColor = colors[_step];

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: <Widget>[
          const LiquidGlassBackground(),
          SafeArea(
            child: Column(
              children: <Widget>[
                // Skip
                Align(
                  alignment: Alignment.topRight,
                  child: TextButton(
                    onPressed: () async {
                      await _finishOnboarding();
                      Get.offAllNamed(AppRoutes.login);
                    },
                    child: Text(
                      'Skip',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // Hero illustration card
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 28),
                  child: LiquidGlassSurface(
                    padding: const EdgeInsets.all(32),
                    borderRadius: const BorderRadius.all(Radius.circular(28)),
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: Center(
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 260),
                          child: _IllustrationBox(
                            key: ValueKey<int>(_step),
                            icon: slide.icon,
                            color: accentColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 32),

                // Title + body
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 220),
                    child: Column(
                      key: ValueKey<int>(_step),
                      children: <Widget>[
                        Text(
                          slide.title,
                          textAlign: TextAlign.center,
                          style: Theme.of(
                            context,
                          ).textTheme.headlineLarge?.copyWith(
                            color: scheme.onSurface,
                            fontWeight: FontWeight.w800,
                            fontSize: 30,
                            letterSpacing: -0.8,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          slide.body,
                          textAlign: TextAlign.center,
                          style: Theme.of(
                            context,
                          ).textTheme.bodyLarge?.copyWith(
                            color: scheme.onSurfaceVariant,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const Spacer(),

                // Dots
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List<Widget>.generate(_slides.length, (i) {
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 220),
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      width: i == _step ? 24 : 8,
                      height: 8,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(999),
                        color:
                            i == _step
                                ? scheme.primary
                                : scheme.onSurfaceVariant.withValues(
                                  alpha: 0.3,
                                ),
                      ),
                    );
                  }),
                ),

                const SizedBox(height: 24),

                // Continue / Let's go button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: FilledButton(
                    onPressed: _next,
                    style: FilledButton.styleFrom(
                      minimumSize: const Size.fromHeight(54),
                      shape: const StadiumBorder(),
                    ),
                    child: Text(
                      _step == _slides.length - 1 ? "Let's go" : 'Continue',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 32),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Slide {
  const _Slide({required this.icon, required this.title, required this.body});
  final IconData icon;
  final String title;
  final String body;
}

class _IllustrationBox extends StatelessWidget {
  const _IllustrationBox({super.key, required this.icon, required this.color});
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[color, color.withValues(alpha: 0.6)],
        ),
        borderRadius: BorderRadius.circular(32),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: color.withValues(alpha: 0.5),
            blurRadius: 48,
            offset: const Offset(0, 16),
          ),
        ],
      ),
      alignment: Alignment.center,
      child: Icon(icon, size: 56, color: Colors.white),
    );
  }
}
