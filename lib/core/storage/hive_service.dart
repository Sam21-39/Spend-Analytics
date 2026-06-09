import 'dart:convert';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

import '../constants/app_constants.dart';
import '../constants/hive_box_names.dart';
import '../enums/budget_period.dart';
import '../enums/expense_type.dart';
import '../enums/payment_type.dart';
import '../enums/recurring_frequency.dart';
import '../enums/rule_type.dart';
import '../enums/subscription_tier.dart';
import '../sync/models/sync_operation_model.dart';
import '../../features/budget/data/models/budget_model.dart';
import '../../features/categories/data/models/category_model.dart';
import '../../features/expense/data/models/expense_model.dart';
import '../../features/notifications/data/models/notification_event_model.dart';
import '../../features/recurring/data/models/recurring_model.dart';
import '../../features/rules/data/models/rule_model.dart';
import '../../features/settings/data/models/settings_model.dart';

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
    // Models — TypeIds 0–7
    Hive.registerAdapter(ExpenseModelAdapter());
    Hive.registerAdapter(BudgetModelAdapter());
    Hive.registerAdapter(RuleModelAdapter());
    Hive.registerAdapter(RecurringModelAdapter());
    Hive.registerAdapter(CategoryModelAdapter());
    Hive.registerAdapter(NotificationEventModelAdapter());
    Hive.registerAdapter(SettingsModelAdapter());
    Hive.registerAdapter(SyncOperationModelAdapter());

    // Enums — TypeIds 100–105
    Hive.registerAdapter(PaymentTypeAdapter());
    Hive.registerAdapter(ExpenseTypeAdapter());
    Hive.registerAdapter(BudgetPeriodAdapter());
    Hive.registerAdapter(RuleTypeAdapter());
    Hive.registerAdapter(RecurringFrequencyAdapter());
    Hive.registerAdapter(SubscriptionTierAdapter());
  }

  // ---------------------------------------------------------------------------
  // Box opening
  // ---------------------------------------------------------------------------

  Future<void> _openBoxes(HiveAesCipher cipher) async {
    // Settings box opens first — needed by DataMigrationService and feature
    // flag checks before other boxes are ready.
    await Hive.openBox<SettingsModel>(
      HiveBoxNames.settings,
      encryptionCipher: cipher,
    );

    // All remaining boxes open in parallel.
    await Future.wait([
      Hive.openBox<ExpenseModel>(
        HiveBoxNames.expenses,
        encryptionCipher: cipher,
      ),
      Hive.openBox<BudgetModel>(
        HiveBoxNames.budgets,
        encryptionCipher: cipher,
      ),
      Hive.openBox<RuleModel>(HiveBoxNames.rules, encryptionCipher: cipher),
      Hive.openBox<RecurringModel>(
        HiveBoxNames.recurring,
        encryptionCipher: cipher,
      ),
      Hive.openBox<CategoryModel>(
        HiveBoxNames.categories,
        encryptionCipher: cipher,
      ),
      Hive.openBox<NotificationEventModel>(
        HiveBoxNames.notificationEvents,
        encryptionCipher: cipher,
      ),
      Hive.openBox<SyncOperationModel>(
        HiveBoxNames.syncQueue,
        encryptionCipher: cipher,
      ),
    ]);
  }

  // ---------------------------------------------------------------------------
  // Typed box accessors
  // ---------------------------------------------------------------------------

  Box<SettingsModel> get settingsBox =>
      Hive.box<SettingsModel>(HiveBoxNames.settings);
  Box<ExpenseModel> get expensesBox =>
      Hive.box<ExpenseModel>(HiveBoxNames.expenses);
  Box<BudgetModel> get budgetsBox =>
      Hive.box<BudgetModel>(HiveBoxNames.budgets);
  Box<RuleModel> get rulesBox => Hive.box<RuleModel>(HiveBoxNames.rules);
  Box<RecurringModel> get recurringBox =>
      Hive.box<RecurringModel>(HiveBoxNames.recurring);
  Box<CategoryModel> get categoriesBox =>
      Hive.box<CategoryModel>(HiveBoxNames.categories);
  Box<NotificationEventModel> get notificationEventsBox =>
      Hive.box<NotificationEventModel>(HiveBoxNames.notificationEvents);
  Box<SyncOperationModel> get syncQueueBox =>
      Hive.box<SyncOperationModel>(HiveBoxNames.syncQueue);

  // ---------------------------------------------------------------------------
  // Schema version helpers (used by DataMigrationService)
  // ---------------------------------------------------------------------------

  int? get storedSchemaVersion {
    try {
      final raw = Hive.box(HiveBoxNames.settings)
          .get(AppConstants.hiveSchemaVersionKey);
      return raw as int?;
    } catch (_) {
      return null;
    }
  }

  Future<void> markSchemaMigrated() async {
    await Hive.box(HiveBoxNames.settings).put(
      AppConstants.hiveSchemaVersionKey,
      AppConstants.hiveSchemaVersion,
    );
  }
}
