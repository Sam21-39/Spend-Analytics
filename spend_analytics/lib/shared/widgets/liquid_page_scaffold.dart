import 'package:flutter/material.dart';
import 'package:spend_analytics/shared/widgets/liquid_bottom_nav.dart';
import 'package:spend_analytics/shared/widgets/liquid_glass_background.dart';
import 'package:spend_analytics/shared/widgets/liquid_glass_surface.dart';

class LiquidPageScaffold extends StatelessWidget {
  const LiquidPageScaffold({
    required this.title,
    required this.child,
    required this.activeRoute,
    super.key,
    this.actions,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.showBottomNav = true,
  });

  final String title;
  final Widget child;
  final String activeRoute;
  final List<Widget>? actions;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final bool showBottomNav;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.transparent,
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
      body: Stack(
        children: <Widget>[
          const LiquidGlassBackground(),
          SafeArea(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 10, 16, 8),
                  child: LiquidGlassSurface(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(24)),
                    opacity: 0.22,
                    blur: 28,
                    child: Row(
                      children: <Widget>[
                        Text(
                          'SpendSense',
                          style: Theme.of(
                            context,
                          ).textTheme.titleLarge?.copyWith(
                            color: scheme.onSurface,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const Spacer(),
                        ...(actions ?? const <Widget>[]),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.only(
                      left: 16,
                      right: 16,
                      top: 8,
                      bottom: showBottomNav ? 108 : 24,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          title,
                          style: Theme.of(
                            context,
                          ).textTheme.headlineMedium?.copyWith(
                            color: scheme.onSurface,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 14),
                        child,
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar:
          showBottomNav ? LiquidBottomNav(activeRoute: activeRoute) : null,
    );
  }
}
