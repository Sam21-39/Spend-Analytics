import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:spend_analytics/features/notifications/domain/repositories/i_notification_repository.dart';

import 'notification_state.dart';

@injectable
class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit(this._repo) : super(const NotificationState());

  final INotificationRepository _repo;
  StreamSubscription<dynamic>? _sub;

  void load(String userId) {
    emit(state.copyWith(isLoading: true));
    _sub?.cancel();
    _sub = _repo.watchNotifications(userId).listen((result) {
      if (isClosed) return;
      result.fold(
        (_) => emit(state.copyWith(isLoading: false)),
        (events) => emit(NotificationState(
          events: events,
          unreadCount: events.where((e) => !e.isRead).length,
        )),
      );
    });
  }

  Future<void> markRead(String notificationId) async {
    await _repo.markRead(notificationId);
  }

  Future<void> markAllRead(String userId) async {
    await _repo.markAllRead(userId);
  }

  Future<void> clearAll(String userId) async {
    await _repo.clearAll(userId);
  }

  @override
  Future<void> close() {
    _sub?.cancel();
    return super.close();
  }
}
