import 'dart:convert';
import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:spend_analytics/core/firebase/firebase_bootstrap_service.dart';
import 'package:spend_analytics/core/supabase/supabase_service.dart';

class FcmService extends GetxService {
  final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();
  bool _enabled = false;

  Future<FcmService> init() async {
    _enabled = Get.find<FirebaseBootstrapService>().isEnabled;
    if (!_enabled) return this;

    await _localNotifications.initialize(
      const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
        iOS: DarwinInitializationSettings(),
      ),
      onDidReceiveNotificationResponse: _onLocalNotificationTap,
    );

    FirebaseMessaging.onMessage.listen((message) {
      showLocalNotification(
        title: message.notification?.title ?? 'Spend Analytics',
        body: message.notification?.body ?? 'You have a new update',
        route: message.data['route'] as String?,
        payload: message.data,
      );
    });

    FirebaseMessaging.onMessageOpenedApp.listen(_handleNotificationTap);
    final initial = await FirebaseMessaging.instance.getInitialMessage();
    if (initial != null) {
      _handleNotificationTap(initial);
    }

    unawaited(_refreshFcmToken());
    FirebaseMessaging.instance.onTokenRefresh.listen((_) {
      _refreshFcmToken();
    });

    return this;
  }

  Future<void> showLocalNotification({
    required String title,
    required String body,
    String? route,
    Map<String, dynamic> payload = const <String, dynamic>{},
  }) async {
    if (!_enabled) return;

    final mergedPayload = <String, dynamic>{...payload};
    if (route != null && route.isNotEmpty) {
      mergedPayload['route'] = route;
    }

    await _localNotifications.show(
      DateTime.now().millisecondsSinceEpoch ~/ 1000,
      title,
      body,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'spendsense_alerts',
          'Spend Analytics Alerts',
          importance: Importance.max,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(),
      ),
      payload: jsonEncode(mergedPayload),
    );
  }

  void _onLocalNotificationTap(NotificationResponse response) {
    final payload = response.payload;
    if (payload == null || payload.isEmpty) {
      return;
    }

    try {
      final decoded = jsonDecode(payload);
      if (decoded is! Map) {
        return;
      }
      final data = decoded.map((key, value) => MapEntry('$key', value));
      final route = data['route']?.toString();
      if (route != null && route.isNotEmpty) {
        Get.toNamed(route, arguments: data);
      }
    } catch (_) {
      // Ignore malformed payload.
    }
  }

  void _handleNotificationTap(RemoteMessage message) {
    final route = message.data['route'] as String?;
    if (route != null && route.isNotEmpty) {
      Get.toNamed(route, arguments: message.data);
    }
  }

  Future<void> _refreshFcmToken() async {
    if (!_enabled) {
      return;
    }
    if (!Get.isRegistered<SupabaseService>()) {
      return;
    }

    final supabase = Get.find<SupabaseService>();
    if (!supabase.isEnabled || !supabase.isAuthenticated) {
      return;
    }

    final token = await FirebaseMessaging.instance.getToken();
    if (token == null || token.isEmpty) {
      return;
    }

    await supabase.client.from('user_profiles').upsert(<String, dynamic>{
      'id': supabase.currentUserId,
      'fcm_token': token,
      'updated_at': DateTime.now().toIso8601String(),
    }, onConflict: 'id');
  }
}
