import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:spend_analytics/core/constants/app_constants.dart';
import 'package:spend_analytics/core/error/failures.dart';
import 'package:spend_analytics/features/budget/data/models/budget_model.dart';

@lazySingleton
class BudgetRemoteDataSource {
  const BudgetRemoteDataSource(this._firestore);

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> _col(String uid) => _firestore
      .collection(AppConstants.firestoreUsersCollection)
      .doc(uid)
      .collection(AppConstants.firestoreBudgetsCollection);

  Future<Either<Failure, void>> upsertBudget(
    String userId,
    BudgetModel model,
  ) async {
    try {
      await _col(userId).doc(model.id).set(model.toFirestoreMap());
      return const Right(null);
    } on FirebaseException catch (e) {
      return Left(_mapFirebaseError(e));
    }
  }

  Future<Either<Failure, List<BudgetModel>>> fetchForMonth(
    String userId,
    int month,
    int year,
  ) async {
    try {
      final snap = await _col(userId)
          .where('userId', isEqualTo: userId)
          .where('month', isEqualTo: month)
          .where('year', isEqualTo: year)
          .where(AppConstants.firestoreIsDeletedField, isEqualTo: false)
          .get();
      return Right(
        snap.docs
            .map((d) => BudgetModel.fromFirestore(d.id, d.data()))
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
