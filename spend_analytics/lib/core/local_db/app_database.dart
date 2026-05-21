import 'dart:convert';
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:spend_analytics/shared/models/transaction_model.dart';

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

@DriftDatabase(tables: <Type>[Transactions, SyncQueueItems])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 3;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onUpgrade: (migrator, from, to) async {
      if (from < 2) {
        await migrator.createTable(syncQueueItems);
      }
      if (from < 3) {
        await migrator.addColumn(transactions, transactions.updatedAt);
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

  Future<List<TransactionModel>> allTransactions() async {
    final rows =
        await (select(transactions)
              ..orderBy(<OrderClauseGenerator<$TransactionsTable>>[
                (t) => OrderingTerm.desc(t.transactionDate),
              ]))
            .get();
    return rows.map(_mapTransaction).toList(growable: false);
  }

  Stream<List<TransactionModel>> watchAllTransactions() {
    final query = select(transactions)
      ..orderBy(<OrderClauseGenerator<$TransactionsTable>>[
        (t) => OrderingTerm.desc(t.transactionDate),
      ]);
    return query.watch().map(
      (rows) => rows.map(_mapTransaction).toList(growable: false),
    );
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
    final row = await (select(
      transactions,
    )..where((t) => t.id.equals(id))).getSingleOrNull();
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
                  t.entityId.equals(txn.id);
            }))
            .getSingleOrNull();

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

    await (update(
      syncQueueItems,
    )..where((t) => t.id.equals(existing.id))).write(
      SyncQueueItemsCompanion(
        payloadJson: Value<String>(payload),
        userId: Value<String?>(txn.userId),
        updatedAt: Value<DateTime>(now),
        lastError: const Value<String?>(null),
      ),
    );
  }

  Future<List<SyncQueueItem>> pendingSyncQueue({int limit = 100}) async {
    return (select(syncQueueItems)
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
    final existing = await (select(
      syncQueueItems,
    )..where((t) => t.id.equals(id))).getSingleOrNull();
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

  Future<int> syncQueueCount() async {
    final rowCount = syncQueueItems.id.count();
    final query = selectOnly(syncQueueItems)
      ..addColumns(<Expression<int>>[rowCount]);
    final row = await query.getSingle();
    return row.read(rowCount) ?? 0;
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
}
