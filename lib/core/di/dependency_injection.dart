import 'package:get/get.dart';
import 'package:spend_analytics/core/firebase/analytics_service.dart';
import 'package:spend_analytics/core/firebase/crashlytics_service.dart';
import 'package:spend_analytics/core/firebase/fcm_service.dart';
import 'package:spend_analytics/core/firebase/firebase_bootstrap_service.dart';
import 'package:spend_analytics/core/local_db/app_database.dart';
import 'package:spend_analytics/core/rules/rule_engine.dart';
import 'package:spend_analytics/core/supabase/realtime_service.dart';
import 'package:spend_analytics/core/supabase/supabase_service.dart';
import 'package:spend_analytics/core/sync/sync_manager.dart';
import 'package:spend_analytics/features/auth/auth_controller.dart';

class DependencyInjection {
  static Future<void> init() async {
    final firebaseBootstrap =
        Get.put(FirebaseBootstrapService(), permanent: true);
    await firebaseBootstrap.init();

    final supabase = Get.put(SupabaseService(), permanent: true);
    await supabase.init();

    final crashlytics = Get.put(CrashlyticsService(), permanent: true);
    await crashlytics.init();

    final analytics = Get.put(AnalyticsService(), permanent: true);
    await analytics.init();

    final fcm = Get.put(FcmService(), permanent: true);
    await fcm.init();

    final database = Get.put(AppDatabase(), permanent: true);
    await database.init();

    final syncManager = Get.put(SyncManager(), permanent: true);
    await syncManager.init();

    final realtime = Get.put(RealtimeService(), permanent: true);
    await realtime.init();

    final rulesEngine = Get.put(RuleEngine(), permanent: true);
    await rulesEngine.init();

    Get.put(AuthController(), permanent: true);

  }
}
