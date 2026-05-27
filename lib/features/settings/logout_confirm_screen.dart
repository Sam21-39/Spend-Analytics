import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spend_analytics/core/routes/app_routes.dart';
import 'package:spend_analytics/features/auth/auth_controller.dart';
import 'package:spend_analytics/shared/widgets/liquid_glass_background.dart';
import 'package:spend_analytics/shared/widgets/liquid_glass_surface.dart';

/// Modal-style logout confirmation — blurred overlay with sign-out dialog.
class LogoutConfirmScreen extends StatefulWidget {
  const LogoutConfirmScreen({super.key});

  @override
  State<LogoutConfirmScreen> createState() => _LogoutConfirmScreenState();
}

class _LogoutConfirmScreenState extends State<LogoutConfirmScreen> {
  bool _clearLocal = false;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isDark  = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: <Widget>[
          const LiquidGlassBackground(),
          // Blurred scrim
          Container(
            color: Colors.black.withValues(alpha: 0.45),
          ),
          SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: LiquidGlassSurface(
                  padding:      const EdgeInsets.all(24),
                  borderRadius: const BorderRadius.all(Radius.circular(28)),
                  fillOpacity:  isDark ? 0.22 : 0.82,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      // Icon
                      Container(
                        width:  60,
                        height: 60,
                        decoration: BoxDecoration(
                          color:        scheme.error.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(
                            color: scheme.error.withValues(alpha: 0.3),
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.logout_rounded,
                          size:  28,
                          color: scheme.error,
                        ),
                      ),

                      const SizedBox(height: 16),

                      Text(
                        'Sign out of Spend Analytics?',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color:      scheme.onSurface,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Local data stays on this device. Cloud-synced data is safe — sign back in to see it.',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color:  scheme.onSurfaceVariant,
                          height: 1.5,
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Buttons
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () => Get.back<void>(),
                              style: OutlinedButton.styleFrom(
                                minimumSize: const Size(0, 50),
                                shape: const StadiumBorder(),
                              ),
                              child: const Text('Cancel'),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: FilledButton(
                              onPressed: _signOut,
                              style: FilledButton.styleFrom(
                                backgroundColor: scheme.error,
                                minimumSize: const Size(0, 50),
                                shape: const StadiumBorder(),
                              ),
                              child: const Text('Sign out'),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 14),

                      // Clear local data checkbox
                      GestureDetector(
                        onTap: () => setState(() => _clearLocal = !_clearLocal),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 160),
                              width:  18,
                              height: 18,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color:  _clearLocal ? scheme.primary : Colors.transparent,
                                border: Border.all(
                                  color: _clearLocal ? scheme.primary : scheme.outline,
                                  width: 1.5,
                                ),
                              ),
                              alignment: Alignment.center,
                              child: _clearLocal
                                  ? const Icon(
                                      Icons.check_rounded,
                                      size:  12,
                                      color: Colors.white,
                                    )
                                  : null,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Also clear local data',
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: scheme.onSurfaceVariant,
                              ),
                            ),
                          ],
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

  Future<void> _signOut() async {
    try {
      final auth = Get.find<AuthController>();
      await auth.signOut();
    } catch (_) {
      // Fallback — navigate to login regardless
    }
    Get.offAllNamed(AppRoutes.login);
  }
}
