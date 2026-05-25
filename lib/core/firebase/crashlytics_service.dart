import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:spend_analytics/core/firebase/firebase_bootstrap_service.dart';

class CrashlyticsService extends GetxService {
  bool _enabled = false;

  Future<CrashlyticsService> init() async {
    _enabled = Get.find<FirebaseBootstrapService>().isEnabled;

    FlutterError.onError = (details) {
      FlutterError.presentError(details);
      if (_enabled) {
        FirebaseCrashlytics.instance.recordFlutterFatalError(details);
      }
    };

    PlatformDispatcher.instance.onError = (error, stack) {
      if (_enabled) {
        FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      }
      // In debug, allow Flutter to surface uncaught async errors on screen.
      return !kDebugMode;
    };

    return this;
  }

  Future<void> recordError(
    Object error,
    StackTrace stack, {
    Map<String, Object?> customKeys = const <String, Object?>{},
  }) async {
    if (!_enabled) return;

    for (final entry in customKeys.entries) {
      await FirebaseCrashlytics.instance.setCustomKey(entry.key, '${entry.value}');
    }
    await FirebaseCrashlytics.instance.recordError(error, stack);
  }
}
