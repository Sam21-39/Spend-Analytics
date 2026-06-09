import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:spend_analytics/core/enums/subscription_tier.dart';

part 'settings_entity.freezed.dart';

@freezed
abstract class SettingsEntity with _$SettingsEntity {
  const factory SettingsEntity({
    @Default('INR') String currency,
    @Default(true) bool notificationsEnabled,
    @Default(false) bool biometricLockEnabled,
    @Default(true) bool voiceEntryEnabled,
    @Default(ThemeMode.system) ThemeMode themeMode,
    @Default(SubscriptionTier.free) SubscriptionTier subscriptionTier,
    @Default(false) bool hasCompletedOnboarding,
    @Default(false) bool privacyAccepted,
    DateTime? lastSyncedAt,
  }) = _SettingsEntity;
}
