import 'dart:developer';

import 'package:envified/envified.dart';
import 'package:spend_analytics/core/config/secrets.g.dart';

class AppConfig {
  AppConfig._();

  static bool _initialized = false;

  static Future<void> init() async {
    if (_initialized) {
      return;
    }

    try {
      await EnvConfigService.instance.init(
        allowProdSwitch: false,
        autoDiscover: true,
        defaultEnv: Env.dynamic('.env'),
        productionEnvs: {Env.dynamic('.env')},
        envAssetPaths: ["assets/env/"],
      );
    } catch (e) {
      log('unable to load ${e.toString()}');
    }

    _initialized = true;
  }

  static String get(String key, {String fallback = ''}) {
    final value = EnvConfigService.instance.get(key);
    if (value.trim().isEmpty) {
      return fallback;
    }
    return value.trim();
  }

  static String get appName => get('APP_NAME');
  static String get appVersionString => get('APP_VERSION_STRING');
  static String get appVersionNumber => get('APP_VERSION_NUMBER');

  static String get supabaseUrl => AppSecrets.supabaseUrl;
  static String get supabaseAnonKey => AppSecrets.supabaseAnonKey;
  static String get supabaseProjectId => AppSecrets.supabaseProjectId;
  static String get googleWebClientId => AppSecrets.googleWebClientId;

  static String get authorizationEndpoint => AppSecrets.authorizationEndpoint;
  static String get tokenEndpoint => AppSecrets.tokenEndpoint;
  static String get jwkcEndpoint => AppSecrets.jwksEndpoint;
  static String get oidcEndpoint => AppSecrets.oidcEndpoint;

  static bool get hasSupabaseConfig =>
      supabaseUrl.isNotEmpty && supabaseAnonKey.isNotEmpty;
}
