import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:spend_analytics/core/firebase/firebase_bootstrap_service.dart';

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
    );

    FirebaseMessaging.onMessage.listen((message) {
      showLocalNotification(
        title: message.notification?.title ?? 'SpendSense',
        body: message.notification?.body ?? 'You have a new update',
      );
    });

    FirebaseMessaging.onMessageOpenedApp.listen(_handleNotificationTap);
    final initial = await FirebaseMessaging.instance.getInitialMessage();
    if (initial != null) {
      _handleNotificationTap(initial);
    }

    return this;
  }

  Future<void> showLocalNotification({
    required String title,
    required String body,
  }) async {
    if (!_enabled) return;
    await _localNotifications.show(
      0,
      title,
      body,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'spendsense_alerts',
          'SpendSense Alerts',
          importance: Importance.max,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(),
      ),
    );
  }

  void _handleNotificationTap(RemoteMessage message) {
    final route = message.data['route'] as String?;
    if (route != null && route.isNotEmpty) {
      Get.toNamed(route, arguments: message.data['params']);
    }
  }
}
