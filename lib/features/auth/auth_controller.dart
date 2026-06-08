import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart' as permission_handler;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spend_analytics/core/config/app_config.dart';
import 'package:spend_analytics/core/firebase/analytics_service.dart';
import 'package:spend_analytics/core/firebase/crashlytics_service.dart';
import 'package:spend_analytics/core/local_db/app_database.dart';
import 'package:spend_analytics/core/routes/app_routes.dart';
import 'package:spend_analytics/core/supabase/realtime_service.dart';
import 'package:spend_analytics/core/supabase/supabase_service.dart';
import 'package:spend_analytics/core/sync/sync_manager.dart';
import 'package:spend_analytics/features/categories/category_controller.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthController extends GetxController {
  final SupabaseService _supabase = Get.find<SupabaseService>();
  final AnalyticsService _analytics = Get.find<AnalyticsService>();
  final CrashlyticsService _crashlytics = Get.find<CrashlyticsService>();
  final AppDatabase _db = Get.find<AppDatabase>();
  // google_sign_in 7.x uses a singleton with an explicit initialize() call.
  // Phase 6 will replace this entire flow with FirebaseAuth.signInWithCredential.
  GoogleSignIn get _googleSignIn => GoogleSignIn.instance;

  final isLoggedIn = false.obs;
  final isLoading = false.obs;
  StreamSubscription<AuthState>? _authSub;

  bool get hasActiveSession => _supabase.isAuthenticated;

  @override
  void onInit() {
    super.onInit();
    // Initialize GoogleSignIn singleton. Must be called exactly once.
    unawaited(
      GoogleSignIn.instance.initialize(
        serverClientId: AppConfig.googleWebClientId.isEmpty
            ? null
            : AppConfig.googleWebClientId,
      ),
    );
    if (_supabase.isEnabled) {
      _authSub = _supabase.client.auth.onAuthStateChange.listen((state) {
        isLoggedIn.value = state.session != null;
      });
    }
  }

  @override
  void onReady() {
    super.onReady();
    final hasSession = _supabase.isAuthenticated;
    isLoggedIn.value = hasSession;
    if (hasSession &&
        (Get.currentRoute == AppRoutes.login ||
            Get.currentRoute == AppRoutes.splash ||
            Get.currentRoute == AppRoutes.onboarding)) {
      Get.offAllNamed(AppRoutes.dashboard);
    }
  }

  Future<void> signInWithGoogle() async {
    isLoading.value = true;
    try {
      if (!_supabase.isEnabled) {
        throw StateError(
          'Supabase is not configured. Add SUPABASE_URL and SUPABASE_ANON_KEY in .env.',
        );
      }

      // google_sign_in 7.x: authenticate() is the interactive sign-in method.
      // It throws on cancellation/failure rather than returning null.
      final googleUser = await _googleSignIn.authenticate();

      final auth = await googleUser.authentication;
      await permission_handler.Permission.notification.status;
      await _linkSupabaseUser(googleAuth: auth, googleUser: googleUser);
      if (Get.isRegistered<RealtimeService>()) {
        await Get.find<RealtimeService>().refreshSubscription();
      }

      isLoggedIn.value = true;
      await _refreshCategoriesForCurrentUser();
      await _analytics.logEvent('login_success_google');
      final activeUserId = resolveActiveUserId();

      // Silently pull all cloud transactions in background (reinstall recovery)
      if (Get.isRegistered<SyncManager>()) {
        unawaited(Get.find<SyncManager>().pullAllFromCloud(activeUserId));
      }

      await _ensurePrivacyGateAcknowledged(activeUserId);
      await permission_handler.Permission.notification.request();
      Get.offAllNamed(AppRoutes.dashboard);
    } catch (error, stack) {
      await _crashlytics.recordError(
        error,
        stack,
        customKeys: const <String, Object?>{'action': 'google_sign_in'},
      );
      final errStr = '$error';
      final isApi10 =
          error is PlatformException && (error.message?.contains('ApiException: 10') ?? false);
      final isApi12500 =
          error is PlatformException &&
          (error.message!.contains('12500') ||
              (error.code == 'sign_in_failed' && (error.message?.contains('12500') ?? false)));

      if (isApi12500) {
        Get.snackbar(
          'Google Sign-In Failed (12500)',
          'SHA-1 fingerprint not registered. Add your debug SHA-1 to Firebase Console → Project Settings → Your Android app.',
          duration: const Duration(seconds: 8),
          snackPosition: SnackPosition.BOTTOM,
        );
      } else if (isApi10) {
        Get.snackbar(
          'Google Sign-In Config Error',
          'Check package name and SHA-1/SHA-256 in Google Cloud OAuth client.',
        );
      } else if (errStr.contains('Unacceptable audience in id_token')) {
        Get.snackbar(
          'Google Audience Mismatch',
          'Set GOOGLE_WEB_CLIENT_ID to the same Web Client ID configured in Supabase Auth > Providers > Google.',
          duration: const Duration(seconds: 6),
        );
      } else {
        Get.snackbar('Sign-in Failed', errStr.length > 80 ? errStr.substring(0, 80) : errStr);
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _linkSupabaseUser({
    required GoogleSignInAuthentication googleAuth,
    required GoogleSignInAccount googleUser,
  }) async {
    final idToken = googleAuth.idToken;
    if (idToken == null || idToken.isEmpty) {
      throw StateError(
        'Google ID token is missing. Set GOOGLE_WEB_CLIENT_ID in .env using your OAuth web client ID.',
      );
    }

    // google_sign_in 7.x no longer exposes accessToken on GoogleSignInAuthentication.
    // Supabase accepts idToken-only for Google sign-in.
    final authResponse = await _supabase.client.auth.signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: idToken,
    );

    final supabaseUser = authResponse.user ?? _supabase.client.auth.currentUser;
    if (supabaseUser == null) {
      throw StateError('Supabase user missing after token sign-in.');
    }

    await _supabase.client.from('user_profiles').upsert(<String, dynamic>{
      'id': supabaseUser.id,
      'display_name': googleUser.displayName,
      'avatar_url': googleUser.photoUrl,
      'updated_at': DateTime.now().toIso8601String(),
    }, onConflict: 'id');

    await _supabase.client.auth.updateUser(
      UserAttributes(
        data: <String, dynamic>{
          'display_name': googleUser.displayName,
          'avatar_url': googleUser.photoUrl,
          'email': googleUser.email,
        },
      ),
    );
  }

  Future<void> continueAsGuest() async {
    isLoggedIn.value = false;
    await _refreshCategoriesForCurrentUser();
    await _analytics.logEvent('guest_mode_enabled');
    await _ensurePrivacyGateAcknowledged(resolveActiveUserId());
    Get.offAllNamed(AppRoutes.dashboard);
  }

  String resolveActiveUserId() {
    if (_supabase.isAuthenticated) {
      return _supabase.currentUserId!;
    }
    return 'guest';
  }

  Future<void> _ensurePrivacyGateAcknowledged(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'privacy_gate_seen_$userId';
    final seen = prefs.getBool(key) ?? false;
    if (seen) {
      return;
    }

    await Get.dialog<void>(
      PopScope(
        canPop: false,
        child: AlertDialog(
          title: const Text('Privacy First'),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('• Your data is isolated with row-level security.'),
              SizedBox(height: 6),
              Text('• No ads and no data brokering.'),
              SizedBox(height: 6),
              Text('• Export or delete your data anytime.'),
              SizedBox(height: 6),
              Text('• Guest mode stays local on this device.'),
            ],
          ),
          actions: <Widget>[
            FilledButton(onPressed: () => Get.back<void>(), child: const Text('I Understand')),
          ],
        ),
      ),
      barrierDismissible: false,
    );

    await prefs.setBool(key, true);
    await _analytics.logEvent('onboarding_privacy_gate_completed');
  }

  Future<void> signOut({bool clearLocalData = false}) async {
    isLoading.value = true;
    try {
      final activeUserId = resolveActiveUserId();
      if (clearLocalData) {
        await _db.clearUserData(activeUserId);
      }
      await _googleSignIn.signOut();
      if (_supabase.isEnabled) {
        await _supabase.client.auth.signOut();
        if (Get.isRegistered<RealtimeService>()) {
          await Get.find<RealtimeService>().refreshSubscription();
        }
      }
      isLoggedIn.value = false;
      await _refreshCategoriesForCurrentUser();
      Get.offAllNamed(AppRoutes.login);
    } catch (error, stack) {
      await _crashlytics.recordError(
        error,
        stack,
        customKeys: const <String, Object?>{'action': 'sign_out'},
      );
      Get.snackbar('Sign-out Failed', 'Please try again.');
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    _authSub?.cancel();
    super.onClose();
  }

  Future<void> _refreshCategoriesForCurrentUser() async {
    if (!Get.isRegistered<CategoryController>()) {
      return;
    }
    await Get.find<CategoryController>().refreshForActiveUser();
  }
}
