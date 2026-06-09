import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_ce/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:spend_analytics/core/constants/app_constants.dart';
import 'package:spend_analytics/core/constants/hive_box_names.dart';
import 'package:spend_analytics/core/sync/models/sync_operation_model.dart';
import 'package:uuid/uuid.dart';

@lazySingleton
class SyncService {
  SyncService(
    this._firestore,
    this._crashlytics,
    this._connectivity,
  );

  final FirebaseFirestore _firestore;
  final FirebaseCrashlytics _crashlytics;
  final Connectivity _connectivity;

  bool _isFlushing = false;
  StreamSubscription<List<ConnectivityResult>>? _connectivitySub;

  Box<SyncOperationModel> get _queue =>
      Hive.box<SyncOperationModel>(HiveBoxNames.syncQueue);

  Future<void> init() async {
    _connectivitySub = _connectivity.onConnectivityChanged.listen((results) {
      if (!results.contains(ConnectivityResult.none)) {
        unawaited(flush());
      }
    });
    unawaited(flush());
  }

  Future<void> enqueueUpsert({
    required String entityType,
    required String entityId,
    required String userId,
    required Map<String, dynamic> payload,
  }) async {
    final now = DateTime.now().toUtc();
    // Collapse duplicate upserts for the same entity
    final existingKey = _queue.keys.firstWhere(
      (k) {
        final op = _queue.get(k);
        return op != null &&
            op.entityId == entityId &&
            op.operation == 'upsert';
      },
      orElse: () => null,
    );

    final op = SyncOperationModel(
      id: existingKey as String? ?? const Uuid().v4(),
      entityType: entityType,
      operation: 'upsert',
      entityId: entityId,
      payloadJson: jsonEncode(payload),
      userId: userId,
      createdAt: existingKey != null
          ? (_queue.get(existingKey)?.createdAt ?? now)
          : now,
      updatedAt: now,
    );
    await _queue.put(op.id, op);
    unawaited(flush());
  }

  Future<void> enqueueDelete({
    required String entityType,
    required String entityId,
    required String userId,
  }) async {
    final now = DateTime.now().toUtc();
    // Remove any pending upsert for this entity first
    final upsertKey = _queue.keys.firstWhere(
      (k) {
        final op = _queue.get(k);
        return op != null &&
            op.entityId == entityId &&
            op.operation == 'upsert';
      },
      orElse: () => null,
    );
    if (upsertKey != null) {
      await _queue.delete(upsertKey);
    }

    final op = SyncOperationModel(
      id: const Uuid().v4(),
      entityType: entityType,
      operation: 'delete',
      entityId: entityId,
      payloadJson: jsonEncode({'id': entityId, 'userId': userId}),
      userId: userId,
      createdAt: now,
      updatedAt: now,
    );
    await _queue.put(op.id, op);
    unawaited(flush());
  }

  Future<void> flush() async {
    if (_isFlushing) return;
    final connectivity = await _connectivity.checkConnectivity();
    if (connectivity.contains(ConnectivityResult.none)) return;

    _isFlushing = true;
    try {
      final pending = _queue.values
          .where((op) => op.retryCount < AppConstants.syncQueueMaxRetries)
          .toList()
        ..sort((a, b) => a.createdAt.compareTo(b.createdAt));

      for (final op in pending.take(AppConstants.syncQueueBatchSize)) {
        await _processOperation(op);
      }
    } finally {
      _isFlushing = false;
    }
  }

  Future<void> _processOperation(SyncOperationModel op) async {
    try {
      final userId = op.userId ?? '';
      if (userId.isEmpty) {
        await _queue.delete(op.id);
        return;
      }

      final docRef = _firestore
          .collection(AppConstants.firestoreUsersCollection)
          .doc(userId)
          .collection(op.entityType)
          .doc(op.entityId);

      if (op.operation == 'delete') {
        await docRef.update({
          AppConstants.firestoreIsDeletedField: true,
          AppConstants.firestoreDeletedAtField:
              DateTime.now().toUtc().toIso8601String(),
          AppConstants.firestoreUpdatedAtField:
              DateTime.now().toUtc().toIso8601String(),
        });
      } else {
        final data = jsonDecode(op.payloadJson) as Map<String, dynamic>;
        await docRef.set(data, SetOptions(merge: true));
      }

      await _queue.delete(op.id);
    } catch (e, stack) {
      op
        ..retryCount = op.retryCount + 1
        ..lastError = '$e'
        ..updatedAt = DateTime.now().toUtc();
      await _queue.put(op.id, op);

      if (!kDebugMode) {
        unawaited(
          _crashlytics.recordError(
            e,
            stack,
            reason: 'sync_flush_${op.entityType}',
            fatal: false,
          ),
        );
      }
    }
  }

  int get pendingCount => _queue.values
      .where((op) => op.retryCount < AppConstants.syncQueueMaxRetries)
      .length;

  Future<void> dispose() async {
    await _connectivitySub?.cancel();
  }
}
