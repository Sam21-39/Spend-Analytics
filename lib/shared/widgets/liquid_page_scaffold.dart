import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spend_analytics/shared/widgets/liquid_bottom_nav.dart';
import 'package:spend_analytics/shared/widgets/liquid_glass_background.dart';
import 'package:spend_analytics/shared/widgets/liquid_glass_surface.dart';

/// Standard full-screen scaffold for Spend Analytics pages.
///
/// Renders:
/// - [LiquidGlassBackground] full-screen glow backdrop
/// - A frosted-glass pill app bar (logo + title + actions  OR  back + title + actions)
/// - A scrollable [child] content area
/// - An optional floating [LiquidBottomNav] pill with FAB
///
/// Usage — main screen (logo shown):
/// ```dart
/// LiquidPageScaffold(
///   title: 'Spend Analytics',
///   activeRoute: AppRoutes.dashboard,
///   actions: [bellBtn, settingsBtn],
///   child: ...,
/// )
/// ```
///
/// Usage — sub-screen (back button shown):
/// ```dart
/// LiquidPageScaffold(
///   title: 'Transaction',
///   showBottomNav: false,
///   actions: [editBtn, deleteBtn],
///   child: ...,
/// )
/// ```
class LiquidPageScaffold extends StatelessWidget {
  const LiquidPageScaffold({
    required this.title,
    required this.child,
    super.key,
    this.activeRoute,
    this.actions,
    this.showBottomNav        = true,
    this.showFab              = true,
    this.onAddPressed,
    /// When non-null a back-chevron is shown instead of the logo.
    this.onBack,
    this.contentPadding       = const EdgeInsets.fromLTRB(16, 16, 16, 0),
    this.scrollable           = true,
  });

  final String        title;
  final Widget        child;
  final String?       activeRoute;
  final List<Widget>? actions;
  final bool          showBottomNav;
  final bool          showFab;
  final VoidCallback? onAddPressed;
  final VoidCallback? onBack;
  final EdgeInsets    contentPadding;
  final bool          scrollable;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isDark  = Theme.of(context).brightness == Brightness.dark;

    Widget content = Padding(
      padding: contentPadding.copyWith(
        bottom: showBottomNav ? 120 : 24,
      ),
      child: child,
    );

    if (scrollable) {
      content = SingleChildScrollView(
        padding: EdgeInsets.zero,
        physics: const BouncingScrollPhysics(),
        child: content,
      );
    }

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: <Widget>[
          // ── Full-screen glow backdrop ──────────────────────────────
          const LiquidGlassBackground(),

          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                // ── App bar pill ──────────────────────────────────────
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
                  child: LiquidGlassSurface(
                    padding:      EdgeInsets.zero,
                    borderRadius: const BorderRadius.all(Radius.circular(999)),
                    blur:         32,
                    fillOpacity:  isDark ? 0.11 : 0.68,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical:   8,
                      ),
                      child: Row(
                        children: <Widget>[
                          // Leading — back OR logo
                          if (onBack != null)
                            _BarIconBtn(
                              icon:    Icons.chevron_left_rounded,
                              onTap:   onBack,
                              isDark:  isDark,
                            )
                          else
                            Padding(
                              padding: const EdgeInsets.only(left: 6),
                              child: _LogoMark(size: 26, scheme: scheme),
                            ),

                          const SizedBox(width: 9),

                          // Title
                          Expanded(
                            child: Text(
                              title,
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                color:       scheme.onSurface,
                                fontWeight:  FontWeight.w800,
                                fontSize:    16,
                                letterSpacing: -0.2,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),

                          // Trailing actions
                          if (actions != null)
                            ...actions!.map(
                              (a) => _wrapAction(a, isDark),
                            ),

                          const SizedBox(width: 4),
                        ],
                      ),
                    ),
                  ),
                ),

                // ── Scrollable content ──────────────────────────────
                Expanded(child: content),
              ],
            ),
          ),

          // ── Floating bottom nav ─────────────────────────────────
          if (showBottomNav && activeRoute != null)
            Positioned(
              left:   0,
              right:  0,
              bottom: 0,
              child: LiquidBottomNav(
                activeRoute:   activeRoute!,
                showFab:       showFab,
                onAddPressed:  onAddPressed,
              ),
            ),
        ],
      ),
    );
  }

  Widget _wrapAction(Widget action, bool isDark) {
    // If the caller passes a raw IconButton it'll render fine.
    // We wrap arbitrary widgets in a 36×36 circle to match _BarIconBtn look.
    if (action is IconButton || action is _BarIconBtn) return action;
    return action;
  }
}

/// Small circle button for the app bar — matches ChromeIconBtn from design.
class _BarIconBtn extends StatelessWidget {
  const _BarIconBtn({
    required this.icon,
    required this.isDark,
    this.onTap,
    this.badge,
    this.iconColor,
  });

  final IconData  icon;
  final bool      isDark;
  final VoidCallback? onTap;
  final String?   badge;
  final Color?    iconColor;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: onTap ?? () => Get.back<void>(),
      child: Container(
        width:  36,
        height: 36,
        decoration: BoxDecoration(
          color:  isDark
              ? Colors.white.withValues(alpha: 0.06)
              : Colors.black.withValues(alpha: 0.04),
          shape:  BoxShape.circle,
          border: Border.all(
            color: isDark
                ? Colors.white.withValues(alpha: 0.10)
                : Colors.black.withValues(alpha: 0.06),
            width: 0.5,
          ),
        ),
        alignment: Alignment.center,
        child: Stack(
          clipBehavior: Clip.none,
          children: <Widget>[
            Icon(icon, size: 18, color: iconColor ?? scheme.onSurface),
            if (badge != null)
              Positioned(
                top:   -4,
                right: -4,
                child: Container(
                  constraints: const BoxConstraints(minWidth: 14, minHeight: 14),
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    color:        scheme.error,
                    borderRadius: BorderRadius.circular(999),
                    border:       Border.all(color: scheme.surface, width: 1.5),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    badge!,
                    style: const TextStyle(
                      color: Colors.white, fontSize: 9, fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

/// The Spend Analytics gradient bar-chart logo mark.
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
          begin: Alignment.topLeft,
          end:   Alignment.bottomRight,
          colors: <Color>[scheme.primary, scheme.secondary],
        ),
        borderRadius: BorderRadius.circular(size * 0.28),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color:      scheme.primary.withValues(alpha: 0.4),
            blurRadius: 8,
            offset:     const Offset(0, 3),
          ),
        ],
      ),
      alignment: Alignment.center,
      child: Icon(Icons.bar_chart_rounded, size: size * 0.6, color: Colors.white),
    );
  }
}

/// Convenience icon-button to drop into [actions] on [LiquidPageScaffold].
///
/// ```dart
/// BarActionButton(icon: Icons.notifications_outlined, onTap: () { ... })
/// ```
class BarActionButton extends StatelessWidget {
  const BarActionButton({
    required this.icon,
    super.key,
    this.onTap,
    this.badge,
    this.iconColor,
  });

  final IconData  icon;
  final VoidCallback? onTap;
  final String?   badge;
  final Color?    iconColor;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return _BarIconBtn(
      icon:       icon,
      isDark:     isDark,
      onTap:      onTap,
      badge:      badge,
      iconColor:  iconColor,
    );
  }
}
