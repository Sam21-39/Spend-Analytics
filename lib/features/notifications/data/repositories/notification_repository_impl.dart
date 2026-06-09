import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:spend_analytics/core/error/failures.dart';
import 'package:spend_analytics/features/notifications/data/datasources/local/notification_local_datasource.dart';
import 'package:spend_analytics/features/notifications/data/models/notification_event_model.dart';
import 'package:spend_analytics/features/notifications/domain/entities/notification_event_entity.dart';
import 'package:spend_analytics/features/notifications/domain/repositories/i_notification_repository.dart';

@LazySingleton(as: INotificationRepository)
class NotificationRepositoryImpl implements INotificationRepository {
  const NotificationRepositoryImpl(this._local);

  final NotificationLocalDataSource _local;

  @override
  Stream<Either<Failure, List<NotificationEventEntity>>> watchNotifications(
    String userId,
  ) {
    return _local
        .watchNotifications(userId)
        .map((r) => r.map((models) => models.map((m) => m.toEntity()).toList()));
  }

  @override
  Future<Either<Failure, void>> addNotification(
    NotificationEventEntity notification,
  ) async {
    final model = NotificationEventModel.fromEntity(notification);
    return _local.saveNotification(model);
  }

  @override
  Future<Either<Failure, void>> markRead(String id) =>
      _local.markRead(id);

  @override
  Future<Either<Failure, void>> markAllRead(String userId) =>
      _local.markAllRead(userId);

  @override
  Future<Either<Failure, void>> clearAll(String userId) =>
      _local.clearAll(userId);
}
