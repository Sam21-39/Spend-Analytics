import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';
import 'package:spend_analytics/core/error/failures.dart';
import 'package:spend_analytics/features/notifications/domain/entities/notification_event_entity.dart';
import 'package:spend_analytics/features/notifications/domain/repositories/i_notification_repository.dart';
import 'package:spend_analytics/features/recurring/domain/entities/recurring_entity.dart';
import 'package:spend_analytics/features/recurring/domain/repositories/i_recurring_repository.dart';

@injectable
class CheckRecurringDueUseCase {
  const CheckRecurringDueUseCase(this._recurringRepo, this._notifRepo);
  final IRecurringRepository _recurringRepo;
  final INotificationRepository _notifRepo;
  static const _uuid = Uuid();

  /// Returns items that are due today or past. Persists a notification for each.
  /// The BLoC caller is responsible for showing push alerts.
  Future<Either<Failure, List<RecurringEntity>>> call(String userId) async {
    final result = await _recurringRepo.getDueItems(userId);
    if (result.isLeft()) return result;

    final dueItems = result.getOrElse(() => []);
    final now = DateTime.now().toUtc();

    for (final item in dueItems) {
      final notif = NotificationEventEntity(
        id: _uuid.v4(),
        userId: userId,
        title: 'Recurring due: ${item.title}',
        body: '₹${item.amount.toStringAsFixed(0)} due for ${item.title}',
        route: '/recurring',
        payload: {'id': item.id},
        source: 'recurring',
        createdAt: now,
      );
      await _notifRepo.addNotification(notif);
    }
    return Right(dueItems);
  }
}
