import 'package:freezed_annotation/freezed_annotation.dart';

part 'dashboard_event.freezed.dart';

@freezed
sealed class DashboardEvent with _$DashboardEvent {
  const factory DashboardEvent.load({
    required String userId,
    @Default('User') String firstName,
    @Default(true) bool isGuestMode,
  }) = DashboardLoad;
  const factory DashboardEvent.refresh() = DashboardRefresh;
}
