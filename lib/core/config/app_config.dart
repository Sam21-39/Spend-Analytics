import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConfig {
  AppConfig._();

  static bool _initialized = false;

  static Future<void> init() async {
    if (_initialized) {
      return;
    }

    try {
      await dotenv.load(fileName: '.env');
    } catch (_) {
      await dotenv.load(fileName: '.env.example');
    }

    _initialized = true;
  }

  static String get(String key, {String fallback = ''}) {
    final value = dotenv.maybeGet(key);
    if (value == null || value.trim().isEmpty) {
      return fallback;
    }
    return value.trim();
  }

  static String get supabaseUrl => get('SUPABASE_URL');
  static String get supabaseAnonKey => get('SUPABASE_ANON_KEY');
  static String get supabaseProjectId => get('SUPABASE_PROJECT_ID');

  static bool get hasSupabaseConfig => supabaseUrl.isNotEmpty && supabaseAnonKey.isNotEmpty;
}
