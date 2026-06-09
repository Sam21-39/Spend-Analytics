import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:spend_analytics/core/constants/app_constants.dart';
import 'package:spend_analytics/core/error/failures.dart';
import 'package:spend_analytics/features/expense/data/models/expense_model.dart';

@lazySingleton
class ExpenseRemoteDataSource {
  const ExpenseRemoteDataSource(this._firestore);

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> _col(String uid) => _firestore
      .collection(AppConstants.firestoreUsersCollection)
      .doc(uid)
      .collection(AppConstants.firestoreExpensesCollection);

  Future<Either<Failure, void>> upsertExpense(
    String userId,
    ExpenseModel model,
  ) async {
    try {
      await _col(userId).doc(model.id).set(model.toFirestoreMap());
      return const Right(null);
    } on FirebaseException catch (e) {
      return Left(_mapFirebaseError(e));
    }
  }

  Future<Either<Failure, void>> softDeleteExpense(
    String userId,
    String id,
  ) async {
    try {
      await _col(userId).doc(id).update({
        AppConstants.firestoreIsDeletedField: true,
        AppConstants.firestoreDeletedAtField:
            DateTime.now().toUtc().toIso8601String(),
        AppConstants.firestoreUpdatedAtField:
            DateTime.now().toUtc().toIso8601String(),
      });
      return const Right(null);
    } on FirebaseException catch (e) {
      return Left(_mapFirebaseError(e));
    }
  }

  Stream<Either<Failure, List<ExpenseModel>>> watchExpenses(String userId) {
    return _col(userId)
        .where(AppConstants.firestoreIsDeletedField, isEqualTo: false)
        .orderBy('transactionDate', descending: true)
        .snapshots()
        .map((snap) {
          final models = snap.docs
              .map((d) => ExpenseModel.fromFirestore(d.id, d.data()))
              .toList();
          return Right<Failure, List<ExpenseModel>>(models);
        })
        .handleError(
          (Object e) => Left<Failure, List<ExpenseModel>>(
            e is FirebaseException
                ? _mapFirebaseError(e)
                : Failure.network('$e'),
          ),
        );
  }

  Future<Either<Failure, List<ExpenseModel>>> fetchAll(String userId) async {
    try {
      final snap = await _col(userId)
          .where(AppConstants.firestoreIsDeletedField, isEqualTo: false)
          .orderBy('updatedAt', descending: true)
          .get();
      return Right(
        snap.docs
            .map((d) => ExpenseModel.fromFirestore(d.id, d.data()))
            .toList(),
      );
    } on FirebaseException catch (e) {
      return Left(_mapFirebaseError(e));
    }
  }

  static Failure _mapFirebaseError(FirebaseException e) {
    if (e.code == 'permission-denied' || e.code == 'unauthenticated') {
      return Failure.auth(e.message ?? e.code);
    }
    return Failure.network(e.message ?? e.code, statusCode: null);
  }
}
