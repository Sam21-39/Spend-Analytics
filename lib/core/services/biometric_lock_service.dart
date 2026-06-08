import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:spend_analytics/features/settings/settings_controller.dart';

/// Tracks whether the app should show a biometric lock screen on resume.
///
/// The 15-minute grace window is kept in-memory; a cold start always resets it.
class BiometricLockService extends GetxService {
  static const _gracePeriod = Duration(minutes: 15);

  final LocalAuthentication _localAuth = LocalAuthentication();
  DateTime? _lastAuthTime;

  Future<BiometricLockService> init() async {
    return this;
  }

  /// Returns true if the biometric lock screen should be shown.
  bool get shouldLock {
    // Biometric must be enabled in settings
    if (!Get.isRegistered<SettingsController>()) return false;
    final settings = Get.find<SettingsController>();
    if (!settings.biometricLockEnabled.value) return false;

    // No previous auth → always lock
    if (_lastAuthTime == null) return true;

    // Grace period not elapsed → skip lock
    final elapsed = DateTime.now().difference(_lastAuthTime!);
    return elapsed > _gracePeriod;
  }

  /// Records a successful biometric authentication.
  void recordAuthSuccess() {
    _lastAuthTime = DateTime.now();
  }

  /// Performs biometric authentication.
  /// Returns true on success.
  Future<bool> authenticate() async {
    try {
      final result = await _localAuth.authenticate(
        localizedReason: 'Unlock Spend Analytics',
        persistAcrossBackgrounding: true,
      );
      if (result) {
        recordAuthSuccess();
      }
      return result;
    } catch (_) {
      return false;
    }
  }
}
