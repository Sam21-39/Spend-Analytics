// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as _i974;
import 'package:connectivity_plus/connectivity_plus.dart' as _i895;
import 'package:firebase_analytics/firebase_analytics.dart' as _i398;
import 'package:firebase_auth/firebase_auth.dart' as _i59;
import 'package:firebase_crashlytics/firebase_crashlytics.dart' as _i141;
import 'package:firebase_messaging/firebase_messaging.dart' as _i892;
import 'package:firebase_performance/firebase_performance.dart' as _i346;
import 'package:firebase_remote_config/firebase_remote_config.dart' as _i627;
import 'package:firebase_storage/firebase_storage.dart' as _i457;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:hive_ce/hive.dart' as _i738;
import 'package:injectable/injectable.dart' as _i526;
import 'package:local_auth/local_auth.dart' as _i152;

import '../storage/hive_service.dart' as _i459;
import 'modules/firebase_module.dart' as _i398;
import 'modules/hive_module.dart' as _i31;
import 'modules/platform_module.dart' as _i807;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final firebaseModule = _$FirebaseModule();
    final hiveModule = _$HiveModule();
    final platformModule = _$PlatformModule();
    gh.singleton<_i59.FirebaseAuth>(() => firebaseModule.auth);
    gh.singleton<_i974.FirebaseFirestore>(() => firebaseModule.firestore);
    gh.singleton<_i457.FirebaseStorage>(() => firebaseModule.storage);
    gh.singleton<_i398.FirebaseAnalytics>(() => firebaseModule.analytics);
    gh.singleton<_i141.FirebaseCrashlytics>(() => firebaseModule.crashlytics);
    gh.singleton<_i892.FirebaseMessaging>(() => firebaseModule.messaging);
    gh.singleton<_i346.FirebasePerformance>(() => firebaseModule.performance);
    await gh.singletonAsync<_i627.FirebaseRemoteConfig>(
      () => firebaseModule.remoteConfig,
      preResolve: true,
    );
    gh.lazySingleton<_i459.HiveService>(() => hiveModule.hiveService);
    gh.lazySingleton<_i558.FlutterSecureStorage>(
      () => platformModule.secureStorage,
    );
    gh.lazySingleton<_i895.Connectivity>(() => platformModule.connectivity);
    gh.lazySingleton<_i152.LocalAuthentication>(() => platformModule.localAuth);
    gh.lazySingleton<_i738.Box<dynamic>>(
      () => hiveModule.rulesBox,
      instanceName: 'rules_box',
    );
    gh.lazySingleton<_i738.Box<dynamic>>(
      () => hiveModule.budgetsBox,
      instanceName: 'budgets_box',
    );
    gh.lazySingleton<_i738.Box<dynamic>>(
      () => hiveModule.notificationEventsBox,
      instanceName: 'notification_events_box',
    );
    gh.lazySingleton<_i738.Box<dynamic>>(
      () => hiveModule.settingsBox,
      instanceName: 'settings_box',
    );
    gh.lazySingleton<_i738.Box<dynamic>>(
      () => hiveModule.expensesBox,
      instanceName: 'expenses_box',
    );
    gh.lazySingleton<_i738.Box<dynamic>>(
      () => hiveModule.categoriesBox,
      instanceName: 'categories_box',
    );
    gh.lazySingleton<_i738.Box<dynamic>>(
      () => hiveModule.recurringBox,
      instanceName: 'recurring_box',
    );
    gh.lazySingleton<_i738.Box<dynamic>>(
      () => hiveModule.syncQueueBox,
      instanceName: 'sync_queue_box',
    );
    return this;
  }
}

class _$FirebaseModule extends _i398.FirebaseModule {}

class _$HiveModule extends _i31.HiveModule {}

class _$PlatformModule extends _i807.PlatformModule {}
