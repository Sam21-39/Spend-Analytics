import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  final fb.FirebaseAuth _firebaseAuth = fb.FirebaseAuth.instance;

  final isLoggedIn = false.obs;
  final isLoading = false.obs;

  @override
  void onReady() {
    super.onReady();
    final hasSession =
        _firebaseAuth.currentUser != null || _supabase.isAuthenticated;
    isLoggedIn.value = hasSession;
    if (hasSession && Get.currentRoute == AppRoutes.login) {
      Get.offAllNamed(AppRoutes.dashboard);
    }
  }

  Future<void> signInWithGoogle() async {
    isLoading.value = true;
    try {
      final googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        return;
      }

      final auth = await googleUser.authentication;
      final credential = fb.GoogleAuthProvider.credential(
        idToken: auth.idToken,
        accessToken: auth.accessToken,
      );
      final firebaseCredential = await _firebaseAuth.signInWithCredential(
        credential,
      );
      final firebaseUser = firebaseCredential.user;
      if (firebaseUser == null) {
        throw StateError('Firebase user not available after Google sign-in.');
      }

      if (_supabase.isEnabled) {
        await _linkSupabaseUser(
          googleAuth: auth,
          firebaseUser: firebaseUser,
          googleUser: googleUser,
        );
        if (Get.isRegistered<RealtimeService>()) {
          await Get.find<RealtimeService>().refreshSubscription();
        }
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
      Get.snackbar('Sign-in Failed', 'Please try again.');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _linkSupabaseUser({
    required GoogleSignInAuthentication googleAuth,
    required fb.User firebaseUser,
    required GoogleSignInAccount googleUser,
  }) async {
    final idToken = googleAuth.idToken;
    if (idToken == null || idToken.isEmpty) {
      throw StateError(
        'Google ID token is missing. Configure Google Sign-In client IDs first.',
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
      'firebase_uid': firebaseUser.uid,
      'display_name': firebaseUser.displayName ?? googleUser.displayName,
      'avatar_url': firebaseUser.photoURL ?? googleUser.photoUrl,
      'updated_at': DateTime.now().toIso8601String(),
    }, onConflict: 'id');

    await _supabase.client.auth.updateUser(
      UserAttributes(
        data: <String, dynamic>{
          'firebase_uid': firebaseUser.uid,
          'display_name': firebaseUser.displayName ?? googleUser.displayName,
          'avatar_url': firebaseUser.photoURL ?? googleUser.photoUrl,
          'email': firebaseUser.email,
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
    final firebaseUser = _firebaseAuth.currentUser;
    if (firebaseUser != null) {
      return firebaseUser.uid;
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
      await GoogleSignIn().signOut();
      await _firebaseAuth.signOut();
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
