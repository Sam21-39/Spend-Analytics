import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_event_entity.freezed.dart';

@freezed
abstract class NotificationEventEntity with _$NotificationEventEntity {
  const factory NotificationEventEntity({
    required String id,
    String? userId,
    required String title,
    required String body,
    String? route,
    @Default({}) Map<String, dynamic> payload,
    @Default('system') String source,
    @Default(false) bool isRead,
    required DateTime createdAt,
  }) = _NotificationEventEntity;
}
