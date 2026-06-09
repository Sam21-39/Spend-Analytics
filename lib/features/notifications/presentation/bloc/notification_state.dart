import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:spend_analytics/features/notifications/domain/entities/notification_event_entity.dart';

part 'notification_state.freezed.dart';

@freezed
abstract class NotificationState with _$NotificationState {
  const factory NotificationState({
    @Default([]) List<NotificationEventEntity> events,
    @Default(0) int unreadCount,
    @Default(false) bool isLoading,
  }) = _NotificationState;
}
