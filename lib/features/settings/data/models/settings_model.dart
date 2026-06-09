import 'package:flutter/material.dart';
import 'package:hive_ce/hive.dart';
import 'package:spend_analytics/core/enums/subscription_tier.dart';
import 'package:spend_analytics/features/settings/domain/entities/settings_entity.dart';

part 'settings_model.g.dart';

@HiveType(typeId: 6)
class SettingsModel {
  SettingsModel({
    this.currency = 'INR',
    this.notificationsEnabled = true,
    this.biometricLockEnabled = false,
    this.voiceEntryEnabled = true,
    this.themeModeIndex = 0,
    this.subscriptionTier = SubscriptionTier.free,
    this.hasCompletedOnboarding = false,
    this.privacyAccepted = false,
    this.lastSyncedAt,
  });

  @HiveField(0)
  String currency;

  @HiveField(1)
  bool notificationsEnabled;

  @HiveField(2)
  bool biometricLockEnabled;

  @HiveField(3)
  bool voiceEntryEnabled;

  /// ThemeMode.index: 0=system, 1=light, 2=dark
  @HiveField(4)
  int themeModeIndex;

  @HiveField(5)
  SubscriptionTier subscriptionTier;

  @HiveField(6)
  bool hasCompletedOnboarding;

  @HiveField(7)
  bool privacyAccepted;

  @HiveField(8)
  DateTime? lastSyncedAt;

  factory SettingsModel.fromEntity(SettingsEntity e) => SettingsModel(
    currency: e.currency,
    notificationsEnabled: e.notificationsEnabled,
    biometricLockEnabled: e.biometricLockEnabled,
    voiceEntryEnabled: e.voiceEntryEnabled,
    themeModeIndex: e.themeMode.index,
    subscriptionTier: e.subscriptionTier,
    hasCompletedOnboarding: e.hasCompletedOnboarding,
    privacyAccepted: e.privacyAccepted,
    lastSyncedAt: e.lastSyncedAt,
  );

  SettingsEntity toEntity() => SettingsEntity(
    currency: currency,
    notificationsEnabled: notificationsEnabled,
    biometricLockEnabled: biometricLockEnabled,
    voiceEntryEnabled: voiceEntryEnabled,
    themeMode: ThemeMode.values[themeModeIndex.clamp(0, ThemeMode.values.length - 1)],
    subscriptionTier: subscriptionTier,
    hasCompletedOnboarding: hasCompletedOnboarding,
    privacyAccepted: privacyAccepted,
    lastSyncedAt: lastSyncedAt,
  );
}
