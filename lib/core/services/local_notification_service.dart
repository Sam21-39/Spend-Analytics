import 'dart:convert';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

class LocalNotificationService extends GetxService {
  final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();

  Future<LocalNotificationService> init() async {
    await _localNotifications.initialize(
      const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
        iOS: DarwinInitializationSettings(),
      ),
      onDidReceiveNotificationResponse: _onLocalNotificationTap,
    );
    return this;
  }

  Future<void> showLocalNotification({
    required String title,
    required String body,
    String? route,
    Map<String, dynamic> payload = const <String, dynamic>{},
  }) async {
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
}
