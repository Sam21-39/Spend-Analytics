import 'dart:async';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:spend_analytics/core/firebase/analytics_service.dart';
import 'package:spend_analytics/core/firebase/crashlytics_service.dart';
import 'package:spend_analytics/core/firebase/fcm_service.dart';
import 'package:spend_analytics/core/firebase/firebase_bootstrap_service.dart';
import 'package:spend_analytics/core/local_db/app_database.dart';
import 'package:spend_analytics/core/rules/rule_engine.dart';
import 'package:spend_analytics/core/services/biometric_lock_service.dart';
import 'package:spend_analytics/core/supabase/realtime_service.dart';
import 'package:spend_analytics/core/supabase/supabase_service.dart';
import 'package:spend_analytics/core/sync/sync_manager.dart';
import 'package:spend_analytics/core/theme/theme_service.dart';
import 'package:spend_analytics/features/auth/auth_controller.dart';
import 'package:spend_analytics/features/categories/category_controller.dart';
import 'package:spend_analytics/features/settings/settings_controller.dart';

class DependencyInjection {
  static Future<void> init() async {
    await _initCritical();
    unawaited(_initNonCritical());
  }

  static Future<void> _initCritical() async {
    final firebaseBootstrap = Get.put(
      FirebaseBootstrapService(),
      permanent: true,
    );
    await _runWithTimeout('firebase_bootstrap', firebaseBootstrap.init);

    final supabase = Get.put(SupabaseService(), permanent: true);
    await _runWithTimeout('supabase', supabase.init);

    final crashlytics = Get.put(CrashlyticsService(), permanent: true);
    await _runWithTimeout('crashlytics', crashlytics.init);

    final analytics = Get.put(AnalyticsService(), permanent: true);
    await _runWithTimeout('analytics', analytics.init);

    final database = Get.put(AppDatabase(), permanent: true);
    await _runWithTimeout('database', database.init);

    final theme = Get.put(ThemeService(), permanent: true);
    await _runWithTimeout('theme', theme.init);

    Get.put(AuthController(), permanent: true);
    Get.put(CategoryController(), permanent: true);
    Get.put(SettingsController(), permanent: true);
  }

  static Future<void> _initNonCritical() async {
    final fcm = Get.put(FcmService(), permanent: true);
    await _runWithTimeout('fcm', fcm.init, timeout: const Duration(seconds: 4));

    final syncManager = Get.put(SyncManager(), permanent: true);
    await _runWithTimeout(
      'sync_manager',
      syncManager.init,
      timeout: const Duration(seconds: 6),
    );

    final realtime = Get.put(RealtimeService(), permanent: true);
    await _runWithTimeout(
      'realtime',
      realtime.init,
      timeout: const Duration(seconds: 6),
    );

    final rulesEngine = Get.put(RuleEngine(), permanent: true);
    await _runWithTimeout(
      'rule_engine',
      rulesEngine.init,
      timeout: const Duration(seconds: 4),
    );

    final biometricLock = Get.put(BiometricLockService(), permanent: true);
    await _runWithTimeout(
      'biometric_lock',
      biometricLock.init,
      timeout: const Duration(seconds: 3),
    );
  }

  static Future<void> _runWithTimeout(
    String step,
    Future<dynamic> Function() run, {
    Duration timeout = const Duration(seconds: 5),
  }) async {
    try {
      await run().timeout(timeout);
    } catch (error, stack) {
      log(
        'Dependency init step failed: $step -> $error',
        name: 'DependencyInjection',
        stackTrace: stack,
      );
    }
  }
}
