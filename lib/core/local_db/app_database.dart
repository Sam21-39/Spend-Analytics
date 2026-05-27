import 'dart:convert';
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:spend_analytics/shared/models/transaction_model.dart';
import 'package:uuid/uuid.dart';

part 'app_database.g.dart';

class Transactions extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text()();
  RealColumn get amount => real()();
  TextColumn get type => text()();
  TextColumn get category => text()();
  TextColumn get paymentMode => text()();
  DateTimeColumn get transactionDate => dateTime()();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
  TextColumn get note => text().nullable()();
  TextColumn get tagsJson => text().withDefault(const Constant('[]'))();

  @override
  Set<Column<Object>> get primaryKey => <Column<Object>>{id};
}

class SyncQueueItems extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get entityType => text()();
  TextColumn get operation => text()();
  TextColumn get entityId => text()();
  TextColumn get payloadJson => text()();
  TextColumn get userId => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  IntColumn get retryCount => integer().withDefault(const Constant(0))();
  TextColumn get lastError => text().nullable()();
}

class Budgets extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get userId => text()();
  TextColumn get category => text()();
  IntColumn get month => integer()();
  IntColumn get year => integer()();
  RealColumn get limitAmount => real()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  List<Set<Column<Object>>> get uniqueKeys => <Set<Column<Object>>>[
    <Column<Object>>{userId, category, month, year},
  ];
}

class UserRules extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text()();
  TextColumn get ruleType => text()();
  TextColumn get parametersJson => text().withDefault(const Constant('{}'))();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column<Object>> get primaryKey => <Column<Object>>{id};
}

class NotificationEvents extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get userId => text().nullable()();
  TextColumn get title => text()();
  TextColumn get body => text()();
  TextColumn get route => text().nullable()();
  TextColumn get payloadJson => text().withDefault(const Constant('{}'))();
  TextColumn get source => text().withDefault(const Constant('system'))();
  BoolColumn get isRead => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

@DriftDatabase(
  tables: <Type>[
    Transactions,
    SyncQueueItems,
    Budgets,
    UserRules,
    NotificationEvents,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 6;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onUpgrade: (migrator, from, to) async {
      if (from < 2) {
        await migrator.createTable(syncQueueItems);
      }
      if (from < 3) {
        await migrator.addColumn(transactions, transactions.updatedAt);
      }
      if (from < 4) {
        await migrator.createTable(budgets);
      }
      if (from < 5) {
        await migrator.createTable(userRules);
      }
      if (from < 6) {
        await migrator.createTable(notificationEvents);
      }
    },
  );

  static LazyDatabase _openConnection() {
    return LazyDatabase(() async {
      final directory = await getApplicationDocumentsDirectory();
      final file = File(p.join(directory.path, 'spendsense.sqlite'));
      return NativeDatabase.createInBackground(file);
    });
  }

  Future<AppDatabase> init() async {
    await customStatement('PRAGMA foreign_keys = ON;');
    return this;
  }

  Future<List<TransactionModel>> allTransactionsForUser(String userId) async {
    final rows =
        await (select(transactions)
              ..where((t) => t.userId.equals(userId))
              ..orderBy(<OrderClauseGenerator<$TransactionsTable>>[
                (t) => OrderingTerm.desc(t.transactionDate),
              ]))
            .get();
    return rows.map(_mapTransaction).toList(growable: false);
  }

  Stream<List<TransactionModel>> watchTransactionsForUser(String userId) {
    final query =
        select(transactions)
          ..where((t) => t.userId.equals(userId))
          ..orderBy(<OrderClauseGenerator<$TransactionsTable>>[
            (t) => OrderingTerm.desc(t.transactionDate),
          ]);
    return query.watch().map(
      (rows) => rows.map(_mapTransaction).toList(growable: false),
    );
  }

  Stream<Map<String, double>> watchCategorySpendByMonth({
    required String userId,
    required int month,
    required int year,
  }) {
    final range = _monthRange(month: month, year: year);
    final query = select(transactions)..where((t) {
      return t.userId.equals(userId) &
          t.type.equals('expense') &
          t.transactionDate.isBiggerOrEqualValue(range.start) &
          t.transactionDate.isSmallerThanValue(range.endExclusive);
    });

    return query.watch().map((rows) {
      final totals = <String, double>{};
      for (final row in rows) {
        totals.update(
          row.category,
          (value) => value + row.amount,
          ifAbsent: () => row.amount,
        );
      }
      return totals;
    });
  }

  Future<double> getCategorySpendForMonth({
    required String userId,
    required String category,
    required int month,
    required int year,
  }) async {
    final range = _monthRange(month: month, year: year);
    final rows =
        await (select(transactions)..where((t) {
          return t.userId.equals(userId) &
              t.category.equals(category) &
              t.type.equals('expense') &
              t.transactionDate.isBiggerOrEqualValue(range.start) &
              t.transactionDate.isSmallerThanValue(range.endExclusive);
        })).get();

    return rows.fold<double>(0, (sum, row) => sum + row.amount);
  }

  Future<double> getDailyExpenseTotal({
    required String userId,
    required DateTime date,
  }) async {
    final range = _dayRange(date);
    final rows =
        await (select(transactions)..where((t) {
          return t.userId.equals(userId) &
              t.type.equals('expense') &
              t.transactionDate.isBiggerOrEqualValue(range.start) &
              t.transactionDate.isSmallerThanValue(range.endExclusive);
        })).get();

    return rows.fold<double>(0, (sum, row) => sum + row.amount);
  }

  Future<void> upsertTransaction(TransactionModel txn) async {
    final companion = TransactionsCompanion.insert(
      id: txn.id,
      userId: txn.userId,
      amount: txn.amount,
      type: txn.type,
      category: txn.category,
      paymentMode: txn.paymentMode,
      transactionDate: txn.transactionDate,
      updatedAt: Value<DateTime>(txn.updatedAt),
      note: Value<String?>(txn.note),
      tagsJson: Value<String>(jsonEncode(txn.tags)),
    );
    await into(transactions).insertOnConflictUpdate(companion);
  }

  Future<TransactionModel?> getTransactionById(String id) async {
    final row =
        await (select(transactions)
          ..where((t) => t.id.equals(id))).getSingleOrNull();
    if (row == null) return null;
    return _mapTransaction(row);
  }

  Future<void> deleteTransactionById(String id) async {
    await (delete(transactions)..where((t) => t.id.equals(id))).go();
  }

  Future<void> enqueueTransactionUpsert(TransactionModel txn) async {
    final now = DateTime.now().toUtc();
    final existing =
        await (select(syncQueueItems)..where((t) {
          return t.entityType.equals('transaction') &
              t.operation.equals('upsert') &
              t.entityId.equals(txn.id) &
              t.userId.equals(txn.userId);
        })).getSingleOrNull();

    final payload = jsonEncode(txn.toJson());
    if (existing == null) {
      await into(syncQueueItems).insert(
        SyncQueueItemsCompanion.insert(
          entityType: 'transaction',
          operation: 'upsert',
          entityId: txn.id,
          payloadJson: payload,
          userId: Value<String?>(txn.userId),
          createdAt: now,
          updatedAt: now,
          retryCount: const Value<int>(0),
          lastError: const Value<String?>(null),
        ),
      );
      return;
    }

    await (update(syncQueueItems)
      ..where((t) => t.id.equals(existing.id))).write(
      SyncQueueItemsCompanion(
        payloadJson: Value<String>(payload),
        userId: Value<String?>(txn.userId),
        updatedAt: Value<DateTime>(now),
        lastError: const Value<String?>(null),
      ),
    );
  }

  Future<void> enqueueTransactionDelete({
    required String transactionId,
    required String userId,
  }) async {
    final now = DateTime.now().toUtc();
    final existing =
        await (select(syncQueueItems)..where((t) {
          return t.entityType.equals('transaction') &
              t.operation.equals('delete') &
              t.entityId.equals(transactionId) &
              t.userId.equals(userId);
        })).getSingleOrNull();

    final payload = jsonEncode(<String, dynamic>{
      'id': transactionId,
      'userId': userId,
      'updatedAt': now.toIso8601String(),
    });

    if (existing == null) {
      await into(syncQueueItems).insert(
        SyncQueueItemsCompanion.insert(
          entityType: 'transaction',
          operation: 'delete',
          entityId: transactionId,
          payloadJson: payload,
          userId: Value<String?>(userId),
          createdAt: now,
          updatedAt: now,
          retryCount: const Value<int>(0),
          lastError: const Value<String?>(null),
        ),
      );
      return;
    }

    await (update(syncQueueItems)
      ..where((t) => t.id.equals(existing.id))).write(
      SyncQueueItemsCompanion(
        payloadJson: Value<String>(payload),
        userId: Value<String?>(userId),
        updatedAt: Value<DateTime>(now),
        lastError: const Value<String?>(null),
      ),
    );
  }

  Future<List<SyncQueueItem>> pendingSyncQueue({
    required String userId,
    int limit = 100,
  }) async {
    return (select(syncQueueItems)
          ..where((t) => t.userId.equals(userId))
          ..orderBy(<OrderClauseGenerator<$SyncQueueItemsTable>>[
            (t) => OrderingTerm.asc(t.createdAt),
          ])
          ..limit(limit))
        .get();
  }

  Future<void> markSyncQueueSuccess(int id) async {
    await (delete(syncQueueItems)..where((t) => t.id.equals(id))).go();
  }

  Future<void> markSyncQueueFailure(int id, String error) async {
    final existing =
        await (select(syncQueueItems)
          ..where((t) => t.id.equals(id))).getSingleOrNull();
    if (existing == null) {
      return;
    }
    await (update(syncQueueItems)..where((t) => t.id.equals(id))).write(
      SyncQueueItemsCompanion(
        retryCount: Value<int>(existing.retryCount + 1),
        lastError: Value<String>(error),
        updatedAt: Value<DateTime>(DateTime.now().toUtc()),
      ),
    );
  }

  Future<int> syncQueueCountForUser(String userId) async {
    final rowCount = syncQueueItems.id.count();
    final query =
        selectOnly(syncQueueItems)
          ..where(syncQueueItems.userId.equals(userId))
          ..addColumns(<Expression<int>>[rowCount]);
    final row = await query.getSingle();
    return row.read(rowCount) ?? 0;
  }

  Future<void> clearUserData(String userId) async {
    await transaction(() async {
      await (delete(transactions)..where((t) => t.userId.equals(userId))).go();
      await (delete(budgets)..where((t) => t.userId.equals(userId))).go();
      await (delete(userRules)..where((t) => t.userId.equals(userId))).go();
      await (delete(notificationEvents)
        ..where((t) => t.userId.equals(userId) | t.userId.isNull())).go();
      await (delete(syncQueueItems)
        ..where((t) => t.userId.equals(userId))).go();
    });
  }

  Future<void> saveBudget({
    required String userId,
    required String category,
    required int month,
    required int year,
    required double limitAmount,
  }) async {
    final now = DateTime.now().toUtc();
    final existing =
        await (select(budgets)..where((t) {
          return t.userId.equals(userId) &
              t.category.equals(category) &
              t.month.equals(month) &
              t.year.equals(year);
        })).getSingleOrNull();

    if (existing == null) {
      await into(budgets).insert(
        BudgetsCompanion.insert(
          userId: userId,
          category: category,
          month: month,
          year: year,
          limitAmount: limitAmount,
          createdAt: Value<DateTime>(now),
          updatedAt: Value<DateTime>(now),
        ),
      );
      return;
    }

    await (update(budgets)..where((t) => t.id.equals(existing.id))).write(
      BudgetsCompanion(
        limitAmount: Value<double>(limitAmount),
        updatedAt: Value<DateTime>(now),
      ),
    );
  }

  Stream<List<Budget>> watchBudgetsForMonth({
    required String userId,
    required int month,
    required int year,
  }) {
    final query =
        select(budgets)
          ..where((t) {
            return t.userId.equals(userId) &
                t.month.equals(month) &
                t.year.equals(year);
          })
          ..orderBy(<OrderClauseGenerator<$BudgetsTable>>[
            (t) => OrderingTerm.asc(t.category),
          ]);
    return query.watch();
  }

  Future<List<UserRule>> getRules(String userId) {
    return (select(userRules)
          ..where((t) => t.userId.equals(userId))
          ..orderBy(<OrderClauseGenerator<$UserRulesTable>>[
            (t) => OrderingTerm.asc(t.createdAt),
          ]))
        .get();
  }

  Future<List<UserRule>> getActiveRules(String userId) {
    return (select(userRules)..where((t) {
      return t.userId.equals(userId) & t.isActive.equals(true);
    })).get();
  }

  Future<void> upsertRule({
    required String id,
    required String userId,
    required String ruleType,
    required Map<String, dynamic> parameters,
    required bool isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) async {
    final now = DateTime.now().toUtc();
    final existing =
        await (select(userRules)
          ..where((t) => t.id.equals(id))).getSingleOrNull();

    if (existing == null) {
      await into(userRules).insert(
        UserRulesCompanion.insert(
          id: id,
          userId: userId,
          ruleType: ruleType,
          parametersJson: Value<String>(jsonEncode(parameters)),
          isActive: Value<bool>(isActive),
          createdAt: Value<DateTime>(createdAt ?? now),
          updatedAt: Value<DateTime>(updatedAt ?? now),
        ),
      );
      return;
    }

    await (update(userRules)..where((t) => t.id.equals(id))).write(
      UserRulesCompanion(
        ruleType: Value<String>(ruleType),
        parametersJson: Value<String>(jsonEncode(parameters)),
        isActive: Value<bool>(isActive),
        updatedAt: Value<DateTime>(updatedAt ?? now),
      ),
    );
  }

  Future<void> setRuleActive({
    required String id,
    required bool isActive,
  }) async {
    await (update(userRules)..where((t) => t.id.equals(id))).write(
      UserRulesCompanion(
        isActive: Value<bool>(isActive),
        updatedAt: Value<DateTime>(DateTime.now().toUtc()),
      ),
    );
  }

  Future<void> seedDefaultRules(String userId) async {
    final existingCountExp = userRules.id.count();
    final row =
        await (selectOnly(userRules)
              ..addColumns(<Expression<int>>[existingCountExp])
              ..where(userRules.userId.equals(userId)))
            .getSingle();
    final count = row.read(existingCountExp) ?? 0;
    if (count > 0) {
      return;
    }

    final uuid = const Uuid();
    await upsertRule(
      id: uuid.v4(),
      userId: userId,
      ruleType: 'budget_threshold',
      parameters: <String, dynamic>{'threshold_pct': 0.8},
      isActive: true,
    );
    await upsertRule(
      id: uuid.v4(),
      userId: userId,
      ruleType: 'daily_limit',
      parameters: <String, dynamic>{'limit_amount': 1500},
      isActive: true,
    );
    await upsertRule(
      id: uuid.v4(),
      userId: userId,
      ruleType: 'no_entry_reminder',
      parameters: <String, dynamic>{'time': '21:00'},
      isActive: true,
    );
  }

  Future<void> normalizeRuleIdsToUuid(String userId) async {
    final uuid = const Uuid();
    final rows =
        await (select(userRules)..where((t) => t.userId.equals(userId))).get();

    for (final row in rows) {
      if (Uuid.isValidUUID(fromString: row.id)) {
        continue;
      }

      final newId = uuid.v4();
      await transaction(() async {
        await into(userRules).insert(
          UserRulesCompanion.insert(
            id: newId,
            userId: row.userId,
            ruleType: row.ruleType,
            parametersJson: Value<String>(row.parametersJson),
            isActive: Value<bool>(row.isActive),
            createdAt: Value<DateTime>(row.createdAt),
            updatedAt: Value<DateTime>(row.updatedAt),
          ),
        );
        await (delete(userRules)..where((t) => t.id.equals(row.id))).go();
      });
    }
  }

  Map<String, dynamic> parseRuleParameters(UserRule rule) {
    try {
      final decoded = jsonDecode(rule.parametersJson);
      if (decoded is Map<String, dynamic>) {
        return decoded;
      }
      if (decoded is Map) {
        return decoded.map((key, value) => MapEntry('$key', value));
      }
    } catch (_) {
      // Ignore malformed payload and fallback to empty map.
    }
    return const <String, dynamic>{};
  }

  Future<void> addNotificationEvent({
    required String? userId,
    required String title,
    required String body,
    String? route,
    Map<String, dynamic> payload = const <String, dynamic>{},
    String source = 'system',
  }) async {
    await into(notificationEvents).insert(
      NotificationEventsCompanion.insert(
        userId: Value<String?>(userId),
        title: title,
        body: body,
        route: Value<String?>(route),
        payloadJson: Value<String>(jsonEncode(payload)),
        source: Value<String>(source),
      ),
    );
  }

  Stream<List<NotificationEvent>> watchNotificationEvents(String userId) {
    final query =
        select(notificationEvents)
          ..where((t) => t.userId.equals(userId) | t.userId.isNull())
          ..orderBy(<OrderClauseGenerator<$NotificationEventsTable>>[
            (t) => OrderingTerm.desc(t.createdAt),
          ]);
    return query.watch();
  }

  Future<void> clearNotificationEvents(String userId) async {
    await (delete(notificationEvents)
      ..where((t) => t.userId.equals(userId) | t.userId.isNull())).go();
  }

  TransactionModel _mapTransaction(Transaction row) {
    return TransactionModel(
      id: row.id,
      userId: row.userId,
      amount: row.amount,
      type: row.type,
      category: row.category,
      paymentMode: row.paymentMode,
      transactionDate: row.transactionDate,
      updatedAt: row.updatedAt,
      note: row.note,
      tags: _decodeTags(row.tagsJson),
    );
  }

  List<String> _decodeTags(String raw) {
    try {
      final decoded = jsonDecode(raw);
      if (decoded is List) {
        return decoded.map((item) => '$item').toList(growable: false);
      }
    } catch (_) {
      // Ignore malformed historical data and fallback to empty tags.
    }
    return const <String>[];
  }

  _DateRange _monthRange({required int month, required int year}) {
    final start = DateTime(year, month, 1);
    final endExclusive =
        month == 12 ? DateTime(year + 1, 1, 1) : DateTime(year, month + 1, 1);
    return _DateRange(start: start, endExclusive: endExclusive);
  }

  _DateRange _dayRange(DateTime value) {
    final start = DateTime(value.year, value.month, value.day);
    final endExclusive = start.add(const Duration(days: 1));
    return _DateRange(start: start, endExclusive: endExclusive);
  }
}

class _DateRange {
  const _DateRange({required this.start, required this.endExclusive});

  final DateTime start;
  final DateTime endExclusive;
}
