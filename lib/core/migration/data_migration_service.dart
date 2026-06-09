import 'dart:convert';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_ce/hive.dart';
import 'package:uuid/uuid.dart';

import '../constants/app_constants.dart';
import '../constants/hive_box_names.dart';
import '../local_db/app_database.dart';
import '../../features/budget/data/models/budget_model.dart';
import '../../features/expense/data/models/expense_model.dart';
import '../../features/notifications/data/models/notification_event_model.dart';
import '../../features/rules/data/models/rule_model.dart';
import '../../core/enums/expense_type.dart';
import '../../core/enums/payment_type.dart';
import '../../core/enums/rule_type.dart';
import '../../core/sync/models/sync_operation_model.dart';

/// Migrates Drift v6 data into Hive CE boxes on first v4.0.0 launch.
///
/// Designed for partial-success: a failure on a single row is logged to
/// Crashlytics and the remaining rows continue. The schema version key is
/// only written after ALL tables have been attempted, so the caller can
/// check [hadRowFailures] and show a recovery notice if needed.
class DataMigrationService {
  static const _uuid = Uuid();

  bool hadRowFailures = false;
  int migratedRows = 0;

  Future<void> runIfNeeded() async {
    final settingsBox = Hive.box(HiveBoxNames.settings);

    final storedVersion =
        settingsBox.get(AppConstants.hiveSchemaVersionKey) as int?;
    if (storedVersion != null &&
        storedVersion >= AppConstants.hiveSchemaVersion) {
      return;
    }

    AppDatabase? db;
    try {
      db = AppDatabase();
      await db.init();
    } catch (e) {
      // Drift DB may not exist on fresh installs — not an error.
      if (kDebugMode) debugPrint('DataMigration: no Drift DB found — $e');
      await _writeSchemaVersion(settingsBox);
      return;
    }

    try {
      await _migrateTransactions(db, settingsBox);
      await _migrateBudgets(db);
      await _migrateRules(db);
      await _migrateNotifications(db);
      await _migrateSyncQueue(db);
    } finally {
      await db.close();
    }

    await _writeSchemaVersion(settingsBox);

    await _logAnalytics();

    if (kDebugMode) {
      debugPrint(
        'DataMigration: done. rows=$migratedRows failures=$hadRowFailures',
      );
    }
  }

  // ---------------------------------------------------------------------------
  // Table migrations
  // ---------------------------------------------------------------------------

  Future<void> _migrateTransactions(
    AppDatabase db,
    Box<dynamic> settingsBox,
  ) async {
    final expensesBox = Hive.box<ExpenseModel>(HiveBoxNames.expenses);

    // Resolve user id from stored settings key or fall back to 'guest'.
    final userId =
        (settingsBox.get('userId') as String?) ?? 'guest';

    List<dynamic> rows;
    try {
      rows = await db.select(db.transactions).get();
    } catch (e, stack) {
      await _logRowError('transactions_table', null, e, stack);
      hadRowFailures = true;
      return;
    }

    for (final row in rows) {
      try {
        final tags = _decodeTags(row.tagsJson);
        final model = ExpenseModel(
          id: row.id,
          userId: row.userId.isEmpty ? userId : row.userId,
          amount: row.amount,
          expenseType: ExpenseType.fromString(row.type),
          category: row.category,
          paymentType: PaymentType.fromString(row.paymentMode),
          transactionDate: row.transactionDate.toUtc(),
          updatedAt: row.updatedAt.toUtc(),
          createdAt: row.updatedAt.toUtc(),
          note: row.note,
          tags: tags,
          isDeleted: false,
          deletedAt: null,
        );
        await expensesBox.put(model.id, model);
        migratedRows++;
      } catch (e, stack) {
        await _logRowError('transactions', row.id, e, stack);
        hadRowFailures = true;
      }
    }
  }

  Future<void> _migrateBudgets(AppDatabase db) async {
    final budgetsBox = Hive.box<BudgetModel>(HiveBoxNames.budgets);

    List<dynamic> rows;
    try {
      rows = await db.select(db.budgets).get();
    } catch (e, stack) {
      await _logRowError('budgets_table', null, e, stack);
      hadRowFailures = true;
      return;
    }

    for (final row in rows) {
      try {
        final id = _uuid.v4();
        final model = BudgetModel(
          id: id,
          userId: row.userId,
          category: row.category,
          limitAmount: row.limitAmount,
          month: row.month,
          year: row.year,
          createdAt: row.createdAt.toUtc(),
          updatedAt: row.updatedAt.toUtc(),
          isDeleted: false,
          deletedAt: null,
        );
        await budgetsBox.put(model.id, model);
        migratedRows++;
      } catch (e, stack) {
        await _logRowError('budgets', row.id.toString(), e, stack);
        hadRowFailures = true;
      }
    }
  }

  Future<void> _migrateRules(AppDatabase db) async {
    final rulesBox = Hive.box<RuleModel>(HiveBoxNames.rules);

    List<dynamic> rows;
    try {
      rows = await db.select(db.userRules).get();
    } catch (e, stack) {
      await _logRowError('rules_table', null, e, stack);
      hadRowFailures = true;
      return;
    }

    for (final row in rows) {
      try {
        final model = RuleModel(
          id: row.id,
          userId: row.userId,
          ruleType: RuleType.fromString(row.ruleType),
          parametersJson: row.parametersJson,
          isActive: row.isActive,
          createdAt: row.createdAt.toUtc(),
          updatedAt: row.updatedAt.toUtc(),
          isDeleted: false,
        );
        await rulesBox.put(model.id, model);
        migratedRows++;
      } catch (e, stack) {
        await _logRowError('rules', row.id, e, stack);
        hadRowFailures = true;
      }
    }
  }

  Future<void> _migrateNotifications(AppDatabase db) async {
    final notifBox =
        Hive.box<NotificationEventModel>(HiveBoxNames.notificationEvents);

    List<dynamic> rows;
    try {
      rows = await db.select(db.notificationEvents).get();
    } catch (e, stack) {
      await _logRowError('notifications_table', null, e, stack);
      hadRowFailures = true;
      return;
    }

    final settingsBox = Hive.box(HiveBoxNames.settings);
    final userId =
        (settingsBox.get('userId') as String?) ?? 'guest';

    for (final row in rows) {
      try {
        final id = _uuid.v4();
        final model = NotificationEventModel(
          id: id,
          userId: (row.userId as String?) ?? userId,
          title: row.title as String,
          body: row.body as String,
          route: row.route as String?,
          payloadJson: row.payloadJson as String,
          source: row.source as String,
          isRead: row.isRead as bool,
          createdAt: (row.createdAt as DateTime).toUtc(),
        );
        await notifBox.put(model.id, model);
        migratedRows++;
      } catch (e, stack) {
        await _logRowError('notifications', row.id.toString(), e, stack);
        hadRowFailures = true;
      }
    }
  }

  Future<void> _migrateSyncQueue(AppDatabase db) async {
    final syncBox = Hive.box<SyncOperationModel>(HiveBoxNames.syncQueue);

    List<dynamic> rows;
    try {
      rows = await db.select(db.syncQueueItems).get();
    } catch (e, stack) {
      await _logRowError('sync_queue_table', null, e, stack);
      hadRowFailures = true;
      return;
    }

    for (final row in rows) {
      // Only re-enqueue pending operations (no retries exhausted).
      if ((row.retryCount as int) >= AppConstants.syncQueueMaxRetries) {
        continue;
      }

      try {
        final id = _uuid.v4();
        final model = SyncOperationModel(
          id: id,
          entityType: _mapEntityType(row.entityType as String),
          operation: row.operation as String,
          entityId: row.entityId as String,
          userId: (row.userId as String?) ?? '',
          payloadJson: row.payloadJson as String,
          createdAt: (row.createdAt as DateTime).toUtc(),
          updatedAt: (row.updatedAt as DateTime).toUtc(),
          retryCount: row.retryCount as int,
          lastError: row.lastError as String?,
        );
        await syncBox.put(model.id, model);
        migratedRows++;
      } catch (e, stack) {
        await _logRowError('sync_queue', row.id.toString(), e, stack);
        hadRowFailures = true;
      }
    }
  }

  // ---------------------------------------------------------------------------
  // Helpers
  // ---------------------------------------------------------------------------

  Future<void> _writeSchemaVersion(Box<dynamic> settingsBox) async {
    await settingsBox.put(
      AppConstants.hiveSchemaVersionKey,
      AppConstants.hiveSchemaVersion,
    );
  }

  Future<void> _logRowError(
    String table,
    String? rowId,
    Object error,
    StackTrace stack,
  ) async {
    if (!kDebugMode) {
      await FirebaseCrashlytics.instance.recordError(
        error,
        stack,
        reason: 'DataMigration: row failure table=$table id=$rowId',
        fatal: false,
      );
    } else {
      debugPrint('DataMigration ERROR table=$table id=$rowId: $error');
    }
  }

  Future<void> _logAnalytics() async {
    try {
      await FirebaseAnalytics.instance.logEvent(
        name: 'migration_completed',
        parameters: {
          'rows': migratedRows,
          'had_failures': hadRowFailures ? 1 : 0,
          'schema_version': AppConstants.hiveSchemaVersion,
        },
      );
    } catch (_) {}
  }

  List<String> _decodeTags(String raw) {
    try {
      final decoded = jsonDecode(raw);
      if (decoded is List) {
        return decoded.map((e) => '$e').toList();
      }
    } catch (_) {}
    return const [];
  }

  // Drift used 'transaction'; Firestore/v4 uses 'expenses'.
  String _mapEntityType(String legacy) {
    return switch (legacy) {
      'transaction' => 'expenses',
      _ => legacy,
    };
  }
}
