import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:screenx/screenx.dart';
import 'package:spend_analytics/core/config/app_config.dart';
import 'package:spend_analytics/core/di/dependency_injection.dart';
import 'package:spend_analytics/core/routes/app_routes.dart';
import 'package:spend_analytics/core/services/biometric_lock_service.dart';
import 'package:spend_analytics/core/theme/app_theme.dart';
import 'package:spend_analytics/core/theme/theme_service.dart';
import 'package:spend_analytics/features/auth/biometric_lock_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppConfig.init();
  await DependencyInjection.init();
  runApp(const _LifecycleObserver(child: SpendAnalyticsApp()));
}

/// Observes app lifecycle to trigger biometric lock on resume.
class _LifecycleObserver extends StatefulWidget {
  const _LifecycleObserver({required this.child});

  final Widget child;

  @override
  State<_LifecycleObserver> createState() => _LifecycleObserverState();
}

class _LifecycleObserverState extends State<_LifecycleObserver>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _checkBiometricLock();
    }
  }

  void _checkBiometricLock() {
    if (!Get.isRegistered<BiometricLockService>()) return;
    final lockService = Get.find<BiometricLockService>();
    if (lockService.shouldLock) {
      // Use Get.dialog so it overlays any current route non-dismissibly
      Get.dialog<void>(
        const BiometricLockScreen(),
        barrierDismissible: false,
        barrierColor: Colors.black.withValues(alpha: 0.6),
      );
    }
  }

  @override
  Widget build(BuildContext context) => widget.child;
}

class SpendAnalyticsApp extends StatelessWidget {
  const SpendAnalyticsApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeMode =
        Get.isRegistered<ThemeService>()
            ? Get.find<ThemeService>().themeMode.value
            : ThemeMode.system;
    return GetMaterialApp(
      title: AppConfig.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: themeMode,
      initialRoute: AppRoutes.splash,
      getPages: AppRoutes.pages,
      defaultTransition: Transition.fadeIn,
      enableLog: kDebugMode,
      // ScreenXLayout initialises ScreenX.sp/dp/wp/hp/bp globally.
      builder: (context, child) =>
          ScreenXLayout(child: child ?? const SizedBox.shrink()),
    );
  }
}

