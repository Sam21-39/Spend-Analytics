import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_performance/firebase_performance.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:injectable/injectable.dart';

import '../../constants/app_constants.dart';

@module
abstract class FirebaseModule {
  @singleton
  FirebaseAuth get auth => FirebaseAuth.instance;

  @singleton
  FirebaseFirestore get firestore {
    final db = FirebaseFirestore.instance;
    db.settings = const Settings(persistenceEnabled: true);
    return db;
  }

  @singleton
  FirebaseStorage get storage => FirebaseStorage.instance;

  @singleton
  FirebaseAnalytics get analytics => FirebaseAnalytics.instance;

  @singleton
  FirebaseCrashlytics get crashlytics => FirebaseCrashlytics.instance;

  @singleton
  FirebaseMessaging get messaging => FirebaseMessaging.instance;

  @singleton
  FirebasePerformance get performance => FirebasePerformance.instance;

  @preResolve
  @singleton
  Future<FirebaseRemoteConfig> get remoteConfig async {
    final rc = FirebaseRemoteConfig.instance;
    await rc.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(seconds: 10),
      minimumFetchInterval: const Duration(hours: 1),
    ));
    await rc.setDefaults({
      AppConstants.rcMaxFreeExpensesPerMonth: AppConstants.maxFreeExpensesPerMonth,
      AppConstants.rcMaxFreeBudgets: AppConstants.maxFreeBudgets,
      AppConstants.rcMaxFreeRules: AppConstants.maxFreeRules,
      AppConstants.rcRazorpayEnabled: false,
      AppConstants.rcOnboardingVariant: 'standard',
      AppConstants.rcPremiumFeaturesEnabled: true,
      AppConstants.rcVoiceEntryEnabled: true,
      AppConstants.rcRecurringEnabled: true,
    });
    await rc.fetchAndActivate();
    return rc;
  }
}
