import 'dart:convert';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

import '../constants/app_constants.dart';
import '../constants/hive_box_names.dart';

// Hive box type imports — added as each model is generated in Phase 1.
// Placeholder comments mark where adapters are registered.

class HiveService {
  HiveService._();
  static final instance = HiveService._();

  bool _initialized = false;
  bool dataResetRequired = false;

  Future<void> init() async {
    if (_initialized) return;

    await Hive.initFlutter();

    final cipherKey = await _resolveCipherKey();

    _registerAdapters();

    await _openBoxes(cipherKey);

    _initialized = true;
  }

  // ---------------------------------------------------------------------------
  // Encryption key management
  // ---------------------------------------------------------------------------

  Future<HiveAesCipher> _resolveCipherKey() async {
    const secureStorage = FlutterSecureStorage(
      iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
    );

    try {
      final existing = await secureStorage.read(
        key: AppConstants.hiveEncryptionKeyStorageKey,
      );

      if (existing != null) {
        final keyBytes = base64Decode(existing);
        return HiveAesCipher(keyBytes);
      }

      final keyBytes = Hive.generateSecureKey();
      await secureStorage.write(
        key: AppConstants.hiveEncryptionKeyStorageKey,
        value: base64Encode(keyBytes),
      );
      return HiveAesCipher(keyBytes);
    } catch (e, stack) {
      // Key retrieval failure — boxes cannot be opened safely.
      // Log the error, signal a data reset, and return a fresh ephemeral key
      // so the app can still boot. DataMigrationService will see the empty
      // boxes and dataResetRequired flag will trigger a recovery UI.
      dataResetRequired = true;
      if (!kDebugMode) {
        await FirebaseCrashlytics.instance.recordError(
          e,
          stack,
          reason: 'Hive encryption key retrieval failed — boxes will be reset',
          fatal: false,
        );
      } else {
        debugPrint('⚠️  Hive key retrieval failed: $e');
      }
      await _deleteAllBoxFiles();
      final ephemeralKey = Hive.generateSecureKey();
      return HiveAesCipher(ephemeralKey);
    }
  }

  Future<void> _deleteAllBoxFiles() async {
    final boxNames = [
      HiveBoxNames.expenses,
      HiveBoxNames.budgets,
      HiveBoxNames.rules,
      HiveBoxNames.recurring,
      HiveBoxNames.categories,
      HiveBoxNames.notificationEvents,
      HiveBoxNames.settings,
      HiveBoxNames.syncQueue,
    ];
    for (final name in boxNames) {
      try {
        await Hive.deleteBoxFromDisk(name);
      } catch (_) {
        // Best-effort cleanup — ignore individual failures.
      }
    }
  }

  // ---------------------------------------------------------------------------
  // Adapter registration
  // ---------------------------------------------------------------------------

  void _registerAdapters() {
    // TypeIds 0–7 (models) and 100–105 (enums) are registered here as each
    // model class is generated in Phase 1. Stubs are commented out below and
    // will be uncommented as corresponding model files are added.
    //
    // Phase 1 models (uncomment as generated):
    // Hive.registerAdapter(ExpenseModelAdapter());       // TypeId 0
    // Hive.registerAdapter(BudgetModelAdapter());        // TypeId 1
    // Hive.registerAdapter(RuleModelAdapter());          // TypeId 2
    // Hive.registerAdapter(RecurringModelAdapter());     // TypeId 3
    // Hive.registerAdapter(CategoryModelAdapter());      // TypeId 4
    // Hive.registerAdapter(NotificationEventModelAdapter()); // TypeId 5
    // Hive.registerAdapter(SettingsModelAdapter());      // TypeId 6
    // Hive.registerAdapter(SyncOperationModelAdapter()); // TypeId 7
    //
    // Phase 1 enums (uncomment as generated):
    // Hive.registerAdapter(PaymentTypeAdapter());        // TypeId 100
    // Hive.registerAdapter(ExpenseTypeAdapter());        // TypeId 101
    // Hive.registerAdapter(BudgetPeriodAdapter());       // TypeId 102
    // Hive.registerAdapter(RuleTypeAdapter());           // TypeId 103
    // Hive.registerAdapter(RecurringFrequencyAdapter()); // TypeId 104
    // Hive.registerAdapter(SubscriptionTierAdapter());   // TypeId 105
  }

  // ---------------------------------------------------------------------------
  // Box opening
  // ---------------------------------------------------------------------------

  Future<void> _openBoxes(HiveAesCipher cipher) async {
    // Settings box opens first — needed by DataMigrationService and feature
    // flag checks before other boxes are ready.
    await Hive.openBox<dynamic>(
      HiveBoxNames.settings,
      encryptionCipher: cipher,
    );

    // All remaining boxes open in parallel.
    await Future.wait([
      Hive.openBox<dynamic>(HiveBoxNames.expenses, encryptionCipher: cipher),
      Hive.openBox<dynamic>(HiveBoxNames.budgets, encryptionCipher: cipher),
      Hive.openBox<dynamic>(HiveBoxNames.rules, encryptionCipher: cipher),
      Hive.openBox<dynamic>(HiveBoxNames.recurring, encryptionCipher: cipher),
      Hive.openBox<dynamic>(HiveBoxNames.categories, encryptionCipher: cipher),
      Hive.openBox<dynamic>(
        HiveBoxNames.notificationEvents,
        encryptionCipher: cipher,
      ),
      Hive.openBox<dynamic>(HiveBoxNames.syncQueue, encryptionCipher: cipher),
    ]);
  }

  // ---------------------------------------------------------------------------
  // Typed box accessors
  // Phase 1: replace Box<dynamic> with the concrete typed Box<*Model> once
  // models and adapters are registered above.
  // ---------------------------------------------------------------------------

  Box<dynamic> get settingsBox => Hive.box(HiveBoxNames.settings);
  Box<dynamic> get expensesBox => Hive.box(HiveBoxNames.expenses);
  Box<dynamic> get budgetsBox => Hive.box(HiveBoxNames.budgets);
  Box<dynamic> get rulesBox => Hive.box(HiveBoxNames.rules);
  Box<dynamic> get recurringBox => Hive.box(HiveBoxNames.recurring);
  Box<dynamic> get categoriesBox => Hive.box(HiveBoxNames.categories);
  Box<dynamic> get notificationEventsBox =>
      Hive.box(HiveBoxNames.notificationEvents);
  Box<dynamic> get syncQueueBox => Hive.box(HiveBoxNames.syncQueue);

  // ---------------------------------------------------------------------------
  // Schema version helpers (used by DataMigrationService)
  // ---------------------------------------------------------------------------

  int? get storedSchemaVersion =>
      settingsBox.get(AppConstants.hiveSchemaVersionKey) as int?;

  Future<void> markSchemaMigrated() async {
    await settingsBox.put(
      AppConstants.hiveSchemaVersionKey,
      AppConstants.hiveSchemaVersion,
    );
  }
}
