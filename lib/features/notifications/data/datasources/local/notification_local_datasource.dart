import 'package:dartz/dartz.dart';
import 'package:hive_ce/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:spend_analytics/core/constants/hive_box_names.dart';
import 'package:spend_analytics/core/error/failures.dart';
import 'package:spend_analytics/features/notifications/data/models/notification_event_model.dart';

@lazySingleton
class NotificationLocalDataSource {
  Box<NotificationEventModel> get _box =>
      Hive.box<NotificationEventModel>(HiveBoxNames.notificationEvents);

  Future<Either<Failure, void>> saveNotification(
    NotificationEventModel model,
  ) async {
    try {
      await _box.put(model.id, model);
      return const Right(null);
    } on HiveError catch (e) {
      return Left(Failure.local(e.message));
    }
  }

  Future<Either<Failure, void>> markRead(String id) async {
    try {
      final model = _box.get(id);
      if (model == null) return const Right(null);
      model.isRead = true;
      await _box.put(id, model);
      return const Right(null);
    } on HiveError catch (e) {
      return Left(Failure.local(e.message));
    }
  }

  Future<Either<Failure, void>> markAllRead(String userId) async {
    try {
      final toUpdate = _box.values
          .where(
            (n) =>
                (n.userId == null || n.userId == userId) && !n.isRead,
          )
          .toList();
      for (final n in toUpdate) {
        n.isRead = true;
        await _box.put(n.id, n);
      }
      return const Right(null);
    } on HiveError catch (e) {
      return Left(Failure.local(e.message));
    }
  }

  Future<Either<Failure, void>> clearAll(String userId) async {
    try {
      final keys = _box.values
          .where((n) => n.userId == null || n.userId == userId)
          .map((n) => n.id)
          .toList();
      await _box.deleteAll(keys);
      return const Right(null);
    } on HiveError catch (e) {
      return Left(Failure.local(e.message));
    }
  }

  Stream<Either<Failure, List<NotificationEventModel>>> watchNotifications(
    String userId,
  ) {
    return Stream.multi((controller) {
      Either<Failure, List<NotificationEventModel>> snap() {
        try {
          final results = _box.values
              .where((n) => n.userId == null || n.userId == userId)
              .toList()
            ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
          return Right(results);
        } on HiveError catch (e) {
          return Left(Failure.local(e.message));
        }
      }

      controller.add(snap());
      final sub = _box.watch().listen((_) => controller.add(snap()));
      controller.onCancel = sub.cancel;
    });
  }
}
