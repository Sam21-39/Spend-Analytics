import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spend_analytics/core/config/app_config.dart';
import 'package:spend_analytics/core/firebase/analytics_service.dart';
import 'package:spend_analytics/core/firebase/crashlytics_service.dart';
import 'package:spend_analytics/core/routes/app_routes.dart';
import 'package:spend_analytics/core/supabase/realtime_service.dart';
import 'package:spend_analytics/core/supabase/supabase_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthController extends GetxController {
  final SupabaseService _supabase = Get.find<SupabaseService>();
  final AnalyticsService _analytics = Get.find<AnalyticsService>();
  final CrashlyticsService _crashlytics = Get.find<CrashlyticsService>();
  late final GoogleSignIn _googleSignIn =
      AppConfig.googleWebClientId.isEmpty
          ? GoogleSignIn()
          : GoogleSignIn(
            serverClientId: AppConfig.googleWebClientId,
            scopes: const <String>['email', 'profile'],
          );

  final isLoggedIn = false.obs;
  final isLoading = false.obs;

  @override
  void onReady() {
    super.onReady();
    final hasSession = _supabase.isAuthenticated;
    isLoggedIn.value = hasSession;
    if (hasSession && Get.currentRoute == AppRoutes.login) {
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

      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return;
      }

      final auth = await googleUser.authentication;
      await _linkSupabaseUser(googleAuth: auth, googleUser: googleUser);
      if (Get.isRegistered<RealtimeService>()) {
        await Get.find<RealtimeService>().refreshSubscription();
      }

      isLoggedIn.value = true;
      await _analytics.logEvent('google_login_success');
      await _ensurePrivacyGateAcknowledged(resolveActiveUserId());
      Get.offAllNamed(AppRoutes.dashboard);
    } catch (error, stack) {
      await _crashlytics.recordError(
        error,
        stack,
        customKeys: const <String, Object?>{'action': 'google_sign_in'},
      );
      final isApi10 =
          error is PlatformException &&
          (error.message?.contains('ApiException: 10') ?? false);
      if (isApi10) {
        Get.snackbar(
          'Google Sign-In Config Error',
          'Check package name and SHA-1/SHA-256 in Google Cloud OAuth client.',
        );
      } else if ('$error'.contains('Unacceptable audience in id_token')) {
        Get.snackbar(
          'Google Audience Mismatch',
          'Set GOOGLE_WEB_CLIENT_ID to the same Web Client ID configured in Supabase Auth > Providers > Google.',
          duration: const Duration(seconds: 6),
        );
      } else {
        Get.snackbar('Sign-in Failed', 'Please try again.');
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

    final authResponse = await _supabase.client.auth.signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: idToken,
      accessToken: googleAuth.accessToken,
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
            FilledButton(
              onPressed: () => Get.back<void>(),
              child: const Text('I Understand'),
            ),
          ],
        ),
      ),
      barrierDismissible: false,
    );

    await prefs.setBool(key, true);
    await _analytics.logEvent('onboarding_privacy_gate_completed');
  }

  Future<void> signOut() async {
    isLoading.value = true;
    try {
      await _googleSignIn.signOut();
      if (_supabase.isEnabled) {
        await _supabase.client.auth.signOut();
        if (Get.isRegistered<RealtimeService>()) {
          await Get.find<RealtimeService>().refreshSubscription();
        }
      }
      isLoggedIn.value = false;
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
}
