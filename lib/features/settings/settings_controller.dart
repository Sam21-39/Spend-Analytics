import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:permission_handler/permission_handler.dart'
    as permission_handler;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:spend_analytics/core/config/app_config.dart';
import 'package:spend_analytics/core/local_db/app_database.dart';
import 'package:spend_analytics/core/supabase/supabase_service.dart';
import 'package:spend_analytics/core/theme/theme_service.dart';
import 'package:spend_analytics/shared/models/transaction_model.dart';

enum SettingsPermissionState { unknown, granted, denied, unavailable }

class SettingsController extends GetxController {
  static const currencies = <String>['INR', 'USD', 'EUR', 'GBP'];
  static const _kCurrency = 'settings_currency';
  static const _kNotifications = 'settings_notifications_enabled';
  static const _kBiometric = 'settings_biometric_enabled';
  static const _kVoiceEntry = 'settings_voice_entry_enabled';
  static const _kPremiumEnabled = 'settings_premium_enabled';
  static const voiceEntryPreferenceKey = _kVoiceEntry;

  final SupabaseService _supabase = Get.find<SupabaseService>();
  final AppDatabase _db = Get.find<AppDatabase>();
  final ThemeService _themeService = Get.find<ThemeService>();
  final LocalAuthentication _localAuth = LocalAuthentication();
  final SpeechToText _speechToText = SpeechToText();
  StreamSubscription<List<TransactionModel>>? _txnSub;
  late final String _activeUserId;

  final selectedCurrency = 'INR'.obs;
  final notificationsEnabled = true.obs;
  final biometricLockEnabled = false.obs;
  final voiceEntryEnabled = true.obs;
  final displayName = 'Guest User'.obs;
  final avatarUrl = ''.obs;
  final email = ''.obs;
  final isGuestMode = true.obs;
  final premiumEnabled = false.obs;
  final transactionCount = 0.obs;
  final appVersionLabel = 'v1.0.0'.obs;
  final isLoading = true.obs;
  final notificationsPermission = SettingsPermissionState.unknown.obs;
  final microphonePermission = SettingsPermissionState.unknown.obs;
  final biometricPermission = SettingsPermissionState.unknown.obs;

  bool _prefsLoaded = false;
  bool _txLoaded = false;

  String get profileSubtitle {
    final mode = isGuestMode.value ? 'Guest mode' : 'Signed in';
    final sync =
        _supabase.isEnabled && !isGuestMode.value
            ? 'Cloud sync enabled'
            : 'Offline mode';
    return '$mode · $sync';
  }

  String get syncSubtitle =>
      _supabase.isEnabled && !isGuestMode.value
          ? 'Supabase cloud sync is active'
          : 'Data is stored locally on this device';

  String get exportSubtitle => '$transactionCount transactions available';

  String get themeLabel => _themeService.themeLabel;

  ThemeMode get themeMode => _themeService.themeMode.value;

  bool get hasPremium => premiumEnabled.value;

  String get premiumSubtitle => hasPremium ? 'Pro enabled' : 'Upgrade for Pro';

  String get backupSubtitle {
    if (!hasPremium) {
      return 'Pro feature · Cloud sync across devices';
    }
    return syncSubtitle;
  }

  String get notificationsPermissionLabel =>
      _permissionLabel(notificationsPermission.value);

  String get microphonePermissionLabel =>
      _permissionLabel(microphonePermission.value);

  String get biometricPermissionLabel =>
      _permissionLabel(biometricPermission.value);

  String get privacyUpdatedLabel {
    final now = DateTime.now();
    const months = <String>[
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return 'Last updated ${months[now.month - 1]} ${now.year}';
  }

  @override
  void onInit() {
    super.onInit();
    _activeUserId =
        _supabase.isAuthenticated ? _supabase.currentUserId! : 'guest';
    _hydrateProfile();
    unawaited(_loadPrefs());
    _txnSub = _db.watchTransactionsForUser(_activeUserId).listen((rows) {
      transactionCount.value = rows.length;
      _txLoaded = true;
      _updateLoading();
    });
  }

  Future<void> _loadPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final currency = prefs.getString(_kCurrency);
    final notifications = prefs.getBool(_kNotifications);
    final biometric = prefs.getBool(_kBiometric);
    final voiceEntry = prefs.getBool(_kVoiceEntry);
    final premium = prefs.getBool(_kPremiumEnabled);

    if (currency != null && currencies.contains(currency)) {
      selectedCurrency.value = currency;
    }
    if (notifications != null) {
      notificationsEnabled.value = notifications;
    }
    if (biometric != null) {
      biometricLockEnabled.value = biometric;
    }
    if (voiceEntry != null) {
      voiceEntryEnabled.value = voiceEntry;
    }
    premiumEnabled.value = premium ?? false;
    await refreshPermissionStatuses();
    _prefsLoaded = true;
    _updateLoading();
  }

  void _hydrateProfile() {
    final sessionUser =
        _supabase.isEnabled ? _supabase.client.auth.currentUser : null;
    if (sessionUser == null) {
      isGuestMode.value = true;
      displayName.value = 'Guest User';
      avatarUrl.value = '';
      email.value = '';
    } else {
      isGuestMode.value = false;
      final meta = sessionUser.userMetadata ?? <String, dynamic>{};
      final name = '${meta['display_name'] ?? ''}'.trim();
      displayName.value = name.isEmpty ? 'User' : name;
      avatarUrl.value = '${meta['avatar_url'] ?? meta['picture'] ?? ''}'.trim();
      email.value = sessionUser.email ?? '';
    }

    final versionString = AppConfig.appVersionString;
    final versionNumber = AppConfig.appVersionNumber;
    if (versionString.isNotEmpty) {
      appVersionLabel.value = versionString;
    } else if (versionNumber.isNotEmpty) {
      appVersionLabel.value = 'v$versionNumber';
    }
  }

  Future<void> setCurrency(String currency) async {
    if (!currencies.contains(currency)) {
      return;
    }
    selectedCurrency.value = currency;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kCurrency, currency);
  }

  Future<void> setNotificationsEnabled(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    if (value) {
      final granted = await requestNotificationsPermission();
      notificationsEnabled.value = granted;
      await prefs.setBool(_kNotifications, granted);
      if (!granted) {
        await _openAppSettingsWithMessage(
          title: 'Notifications blocked',
          message: 'Enable notifications in app settings to receive alerts.',
        );
      }
      return;
    }

    notificationsEnabled.value = false;
    await prefs.setBool(_kNotifications, false);
  }

  Future<void> setBiometricLockEnabled(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    if (value) {
      final granted = await requestBiometricPermission();
      biometricLockEnabled.value = granted;
      await prefs.setBool(_kBiometric, granted);
      if (!granted) {
        await _openAppSettingsWithMessage(
          title: 'Biometric unavailable',
          message: 'Set up biometrics in device settings, then try again.',
        );
      }
      return;
    }

    biometricLockEnabled.value = false;
    await prefs.setBool(_kBiometric, false);
  }

  Future<void> setVoiceEntryEnabled(bool value) async {
    voiceEntryEnabled.value = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_kVoiceEntry, value);
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    await _themeService.setThemeMode(mode);
    update();
  }

  Future<void> clearLocalData() async {
    await _db.clearUserData(_activeUserId);
  }

  Future<void> refreshPermissionStatuses() async {
    await _refreshNotificationPermission();
    await _refreshMicrophonePermission();
    await _refreshBiometricAvailability();
  }

  Future<bool> requestNotificationsPermission() async {
    try {
      final settings = await FirebaseMessaging.instance.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );
      final granted =
          settings.authorizationStatus == AuthorizationStatus.authorized ||
          settings.authorizationStatus == AuthorizationStatus.provisional;
      notificationsPermission.value =
          granted
              ? SettingsPermissionState.granted
              : SettingsPermissionState.denied;
      return granted;
    } catch (_) {
      notificationsPermission.value = SettingsPermissionState.denied;
      return false;
    }
  }

  Future<bool> requestMicrophonePermission() async {
    try {
      final available = await _speechToText.initialize(
        onStatus: (_) {},
        onError: (_) {},
      );
      final granted = available && (_speechToText.hasPermission == true);
      microphonePermission.value =
          granted
              ? SettingsPermissionState.granted
              : SettingsPermissionState.denied;
      return granted;
    } catch (_) {
      microphonePermission.value = SettingsPermissionState.denied;
      return false;
    }
  }

  Future<void> openSystemAppSettings() async {
    await permission_handler.openAppSettings();
  }

  Future<bool> requestBiometricPermission() async {
    try {
      final supported = await _localAuth.isDeviceSupported();
      final canCheck = await _localAuth.canCheckBiometrics;
      if (!supported || !canCheck) {
        biometricPermission.value = SettingsPermissionState.unavailable;
        return false;
      }
      final enrolled = await _localAuth.getAvailableBiometrics();
      if (enrolled.isEmpty) {
        biometricPermission.value = SettingsPermissionState.denied;
        return false;
      }

      final authed = await _localAuth.authenticate(
        localizedReason: 'Enable biometric lock for Spend Analytics',
        options: const AuthenticationOptions(
          biometricOnly: true,
          stickyAuth: false,
        ),
      );
      biometricPermission.value =
          authed
              ? SettingsPermissionState.granted
              : SettingsPermissionState.denied;
      return authed;
    } catch (_) {
      biometricPermission.value = SettingsPermissionState.denied;
      return false;
    }
  }

  Future<void> _refreshNotificationPermission() async {
    try {
      final settings =
          await FirebaseMessaging.instance.getNotificationSettings();
      switch (settings.authorizationStatus) {
        case AuthorizationStatus.authorized:
        case AuthorizationStatus.provisional:
          notificationsPermission.value = SettingsPermissionState.granted;
          break;
        case AuthorizationStatus.denied:
          notificationsPermission.value = SettingsPermissionState.denied;
          break;
        case AuthorizationStatus.notDetermined:
          notificationsPermission.value = SettingsPermissionState.unknown;
          break;
      }
    } catch (_) {
      notificationsPermission.value = SettingsPermissionState.unknown;
    }
  }

  Future<void> _refreshBiometricAvailability() async {
    try {
      final supported = await _localAuth.isDeviceSupported();
      final canCheck = await _localAuth.canCheckBiometrics;
      if (!supported || !canCheck) {
        biometricPermission.value = SettingsPermissionState.unavailable;
        return;
      }
      final enrolled = await _localAuth.getAvailableBiometrics();
      biometricPermission.value =
          enrolled.isNotEmpty
              ? SettingsPermissionState.unknown
              : SettingsPermissionState.denied;
    } catch (_) {
      biometricPermission.value = SettingsPermissionState.unknown;
    }
  }

  Future<void> _refreshMicrophonePermission() async {
    final hasPermission = _speechToText.hasPermission;
    if (hasPermission == true) {
      microphonePermission.value = SettingsPermissionState.granted;
      return;
    }
    microphonePermission.value = SettingsPermissionState.unknown;
  }

  String _permissionLabel(SettingsPermissionState state) {
    switch (state) {
      case SettingsPermissionState.granted:
        return 'Allowed';
      case SettingsPermissionState.denied:
        return 'Blocked';
      case SettingsPermissionState.unavailable:
        return 'Unavailable';
      case SettingsPermissionState.unknown:
        return 'Not requested';
    }
  }

  Future<void> _openAppSettingsWithMessage({
    required String title,
    required String message,
  }) async {
    Get.snackbar(title, message);
    await openSystemAppSettings();
  }

  void _updateLoading() {
    isLoading.value = !(_prefsLoaded && _txLoaded);
  }

  @override
  void onClose() {
    _txnSub?.cancel();
    super.onClose();
  }
}
