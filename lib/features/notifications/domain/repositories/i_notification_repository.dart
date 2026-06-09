import 'package:dartz/dartz.dart';
import 'package:spend_analytics/core/error/failures.dart';
import 'package:spend_analytics/features/notifications/domain/entities/notification_event_entity.dart';

abstract interface class INotificationRepository {
  Stream<Either<Failure, List<NotificationEventEntity>>> watchNotifications(
    String userId,
  );
  Future<Either<Failure, void>> addNotification(
    NotificationEventEntity notification,
  );
  Future<Either<Failure, void>> markRead(String id);
  Future<Either<Failure, void>> markAllRead(String userId);
  Future<Either<Failure, void>> clearAll(String userId);
}
