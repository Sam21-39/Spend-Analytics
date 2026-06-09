import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive_ce/hive.dart';
import 'package:spend_analytics/features/notifications/domain/entities/notification_event_entity.dart';

part 'notification_event_model.g.dart';

@HiveType(typeId: 5)
class NotificationEventModel {
  NotificationEventModel({
    required this.id,
    this.userId,
    required this.title,
    required this.body,
    this.route,
    this.payloadJson = '{}',
    this.source = 'system',
    this.isRead = false,
    required this.createdAt,
  });

  @HiveField(0)
  String id;

  @HiveField(1)
  String? userId;

  @HiveField(2)
  String title;

  @HiveField(3)
  String body;

  @HiveField(4)
  String? route;

  @HiveField(5)
  String payloadJson;

  @HiveField(6)
  String source;

  @HiveField(7)
  bool isRead;

  @HiveField(8)
  DateTime createdAt;

  Map<String, dynamic> get payload {
    try {
      final decoded = jsonDecode(payloadJson);
      if (decoded is Map<String, dynamic>) return decoded;
    } catch (_) {}
    return const {};
  }

  factory NotificationEventModel.fromEntity(NotificationEventEntity e) =>
      NotificationEventModel(
        id: e.id,
        userId: e.userId,
        title: e.title,
        body: e.body,
        route: e.route,
        payloadJson: jsonEncode(e.payload),
        source: e.source,
        isRead: e.isRead,
        createdAt: e.createdAt,
      );

  factory NotificationEventModel.fromFirestore(
    String id,
    Map<String, dynamic> data,
  ) => NotificationEventModel(
    id: id,
    userId: data['userId'] as String?,
    title: data['title'] as String? ?? '',
    body: data['body'] as String? ?? '',
    route: data['route'] as String?,
    payloadJson: _encodePayload(data['payload']),
    source: data['source'] as String? ?? 'system',
    isRead: data['isRead'] as bool? ?? false,
    createdAt: _ts(data['createdAt']),
  );

  NotificationEventEntity toEntity() => NotificationEventEntity(
    id: id,
    userId: userId,
    title: title,
    body: body,
    route: route,
    payload: payload,
    source: source,
    isRead: isRead,
    createdAt: createdAt,
  );

  Map<String, dynamic> toFirestoreMap() => {
    'userId': userId,
    'title': title,
    'body': body,
    'route': route,
    'payload': payload,
    'source': source,
    'isRead': isRead,
    'createdAt': createdAt.toUtc().toIso8601String(),
  };

  static String _encodePayload(dynamic v) {
    if (v is Map<String, dynamic>) return jsonEncode(v);
    if (v is Map) return jsonEncode(v.map((k, val) => MapEntry('$k', val)));
    if (v is String) return v;
    return '{}';
  }

  static DateTime _ts(dynamic v) {
    if (v is Timestamp) return v.toDate().toUtc();
    if (v is DateTime) return v.toUtc();
    if (v is String) return DateTime.parse(v).toUtc();
    return DateTime.now().toUtc();
  }
}
