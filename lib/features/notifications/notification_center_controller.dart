import 'dart:async';

import 'package:get/get.dart';
import 'package:spend_analytics/core/local_db/app_database.dart';
import 'package:spend_analytics/core/supabase/supabase_service.dart';

class NotificationCenterController extends GetxController {
  final AppDatabase _db = Get.find<AppDatabase>();
  final SupabaseService _supabase = Get.find<SupabaseService>();

  final notifications = <NotificationEvent>[].obs;

  StreamSubscription<List<NotificationEvent>>? _sub;
  late final String _userId;

  @override
  void onInit() {
    super.onInit();
    _userId = _resolveActiveUserId();
    _sub = _db.watchNotificationEvents(_userId).listen(notifications.assignAll);
  }

  Future<void> clearAll() => _db.clearNotificationEvents(_userId);

  String _resolveActiveUserId() {
    if (_supabase.isAuthenticated) {
      return _supabase.currentUserId!;
    }
    return 'guest';
  }

  @override
  void onClose() {
    _sub?.cancel();
    super.onClose();
  }
}
