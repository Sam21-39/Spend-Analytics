import 'package:flutter/foundation.dart';
import 'package:envified/envified.dart';
import 'package:spend_analytics/core/config/secrets.g.dart';

class AppConfig {
  AppConfig._();

  static Future<void> init([Env? env]) async {
    await EnvConfigService.instance.init(
      defaultEnv: env ?? Env.prod,
      envAssetPaths: const <String>['assets/env/'],
      allowProdSwitch: false,
    );
  }

  static String get(String key, {String fallback = ''}) {
    final runtimeValue = EnvConfigService.instance.get(key);
    if (runtimeValue.isNotEmpty) {
      return runtimeValue;
    }

    if (AppSecrets.contains(key)) {
      final secretValue = AppSecrets.get(key);
      if (secretValue.isNotEmpty) {
        return secretValue;
      }
    }

    return fallback;
  }

  static bool getBool(String key, {bool fallback = false}) {
    return EnvConfigService.instance.getBool(key, fallback: fallback);
  }

  static String get supabaseUrl => get('SUPABASE_URL');
  static String get supabaseProjectId => get('SUPABASE_PROJECT_ID');
  static String get supabaseAnonKey => get('SUPABASE_ANON_KEY');
  static String get firebaseApiKey {
    if (!kIsWeb && defaultTargetPlatform == TargetPlatform.iOS) {
      return get('FIREBASE_IOS_API_KEY', fallback: get('FIREBASE_API_KEY'));
    }
    if (!kIsWeb && defaultTargetPlatform == TargetPlatform.android) {
      return get('FIREBASE_ANDROID_API_KEY', fallback: get('FIREBASE_API_KEY'));
    }
    return get('FIREBASE_API_KEY');
  }

  static String get firebaseAppId {
    if (!kIsWeb && defaultTargetPlatform == TargetPlatform.iOS) {
      return get('FIREBASE_IOS_APP_ID', fallback: get('FIREBASE_APP_ID'));
    }
    if (!kIsWeb && defaultTargetPlatform == TargetPlatform.android) {
      return get('FIREBASE_ANDROID_APP_ID', fallback: get('FIREBASE_APP_ID'));
    }
    return get('FIREBASE_APP_ID');
  }

  static String get firebaseMessagingSenderId => get('FIREBASE_MESSAGING_SENDER_ID');
  static String get firebaseProjectId => get('FIREBASE_PROJECT_ID');
  static String get firebaseStorageBucket => get('FIREBASE_STORAGE_BUCKET');
  static String get firebaseAuthDomain => get('FIREBASE_AUTH_DOMAIN');
  static String get firebaseIosBundleId => get('FIREBASE_IOS_BUNDLE_ID');

  static bool get hasFirebaseConfig =>
      firebaseApiKey.isNotEmpty &&
      firebaseAppId.isNotEmpty &&
      firebaseMessagingSenderId.isNotEmpty &&
      firebaseProjectId.isNotEmpty;
}
