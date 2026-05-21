import 'package:get/get.dart';
import 'package:spend_analytics/core/config/app_config.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService extends GetxService {
  SupabaseClient? _client;

  bool get isEnabled => _client != null;
  String? get currentUserId => _client?.auth.currentUser?.id;
  bool get isAuthenticated => currentUserId != null;

  SupabaseClient get client {
    final instance = _client;
    if (instance == null) {
      throw StateError(
        'Supabase is not initialized. Add SUPABASE_URL and SUPABASE_ANON_KEY in .env.secrets.<env> and run `fvm dart run envified --env=<env>`.',
      );
    }
    return instance;
  }

  Future<SupabaseService> init() async {
    final url = AppConfig.supabaseUrl;
    final anonKey = AppConfig.supabaseAnonKey;

    if (url.isEmpty || anonKey.isEmpty) {
      return this;
    }

    await Supabase.initialize(url: url, anonKey: anonKey);
    _client = Supabase.instance.client;
    return this;
  }
}
