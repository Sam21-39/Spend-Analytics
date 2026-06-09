import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:spend_analytics/features/settings/domain/entities/settings_entity.dart';
import 'package:spend_analytics/features/settings/domain/models/permission_statuses.dart';

part 'settings_state.freezed.dart';

@freezed
abstract class SettingsState with _$SettingsState {
  const factory SettingsState({
    required SettingsEntity settings,
    @Default(PermissionStatuses()) PermissionStatuses permissions,
    @Default(0) int transactionCount,
    @Default(false) bool isLoading,
    @Default(false) bool isExporting,
  }) = _SettingsState;
}
