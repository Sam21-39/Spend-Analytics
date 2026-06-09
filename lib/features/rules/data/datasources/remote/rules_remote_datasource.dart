import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:spend_analytics/core/constants/app_constants.dart';
import 'package:spend_analytics/core/error/failures.dart';
import 'package:spend_analytics/features/rules/data/models/rule_model.dart';

@lazySingleton
class RulesRemoteDataSource {
  const RulesRemoteDataSource(this._firestore);

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> _col(String uid) => _firestore
      .collection(AppConstants.firestoreUsersCollection)
      .doc(uid)
      .collection(AppConstants.firestoreRulesCollection);

  Future<Either<Failure, void>> upsertRule(
    String userId,
    RuleModel model,
  ) async {
    try {
      await _col(userId).doc(model.id).set(model.toFirestoreMap());
      return const Right(null);
    } on FirebaseException catch (e) {
      return Left(_mapFirebaseError(e));
    }
  }

  Future<Either<Failure, void>> deleteRule(
    String userId,
    String id,
  ) async {
    try {
      await _col(userId).doc(id).update({
        AppConstants.firestoreIsDeletedField: true,
        AppConstants.firestoreUpdatedAtField:
            DateTime.now().toUtc().toIso8601String(),
      });
      return const Right(null);
    } on FirebaseException catch (e) {
      return Left(_mapFirebaseError(e));
    }
  }

  Future<Either<Failure, List<RuleModel>>> fetchAll(String userId) async {
    try {
      final snap = await _col(userId)
          .where(AppConstants.firestoreIsDeletedField, isEqualTo: false)
          .get();
      return Right(
        snap.docs.map((d) => RuleModel.fromFirestore(d.id, d.data())).toList(),
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
