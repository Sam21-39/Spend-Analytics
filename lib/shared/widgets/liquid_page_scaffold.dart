import 'package:flutter/material.dart';
import 'package:spend_analytics/shared/widgets/liquid_bottom_nav.dart';
import 'package:spend_analytics/shared/widgets/liquid_glass_background.dart';
import 'package:spend_analytics/shared/widgets/liquid_glass_surface.dart';

/// Standard full-screen scaffold for Spend Analytics pages.
///
/// Renders:
/// - [LiquidGlassBackground] full-screen glow backdrop
/// - A frosted-glass pill app bar showing the "Spend Analytics" brand word-mark
/// - A scrollable [child] content area with page [title]
/// - An optional floating [LiquidBottomNav] pill
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

  final String        title;
  final Widget        child;
  final String        activeRoute;
  final List<Widget>? actions;
  final Widget?       floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final bool          showBottomNav;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isDark  = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      extendBody:                   true,
      backgroundColor:              Colors.transparent,
      floatingActionButton:         floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
      body: Stack(
        children: <Widget>[
          // ── Full-screen glow ────────────────────────────────────────────
          const LiquidGlassBackground(),

          SafeArea(
            child: Column(
              children: <Widget>[
                // ── App bar pill ──────────────────────────────────────────
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
                  child: LiquidGlassSurface(
                    padding:      const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical:   11,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(999)),
                    blur:         32,
                    fillOpacity:  isDark ? 0.11 : 0.68,
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.bar_chart_rounded,
                          size:  18,
                          color: scheme.primary,
                        ),
                        const SizedBox(width: 7),
                        Text(
                          'Spend Analytics',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color:       scheme.onSurface,
                            fontWeight:  FontWeight.w800,
                            fontSize:    16,
                            letterSpacing: -0.2,
                          ),
                        ),
                        const Spacer(),
                        ...(actions ?? const <Widget>[]),
                      ],
                    ),
                  ),
                ),

                // ── Scrollable content ────────────────────────────────────
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.only(
                      left:   16,
                      right:  16,
                      top:    16,
                      bottom: showBottomNav ? 116 : 24,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          title,
                          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            color:      scheme.onSurface,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 16),
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
      bottomNavigationBar: showBottomNav
          ? LiquidBottomNav(activeRoute: activeRoute)
          : null,
    );
  }
}
