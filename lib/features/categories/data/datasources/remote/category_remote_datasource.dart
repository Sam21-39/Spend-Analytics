import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:spend_analytics/core/constants/app_constants.dart';
import 'package:spend_analytics/core/error/failures.dart';
import 'package:spend_analytics/features/categories/data/models/category_model.dart';

@lazySingleton
class CategoryRemoteDataSource {
  const CategoryRemoteDataSource(this._firestore);

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> _col(String uid) => _firestore
      .collection(AppConstants.firestoreUsersCollection)
      .doc(uid)
      .collection(AppConstants.firestoreCategoriesCollection);

  Future<Either<Failure, void>> upsertCategory(
    String userId,
    CategoryModel model,
  ) async {
    try {
      await _col(userId).doc(model.id).set(model.toFirestoreMap());
      return const Right(null);
    } on FirebaseException catch (e) {
      return Left(_mapFirebaseError(e));
    }
  }

  Future<Either<Failure, void>> upsertAll(
    String userId,
    List<CategoryModel> models,
  ) async {
    try {
      final batch = _firestore.batch();
      for (final m in models) {
        batch.set(_col(userId).doc(m.id), m.toFirestoreMap());
      }
      await batch.commit();
      return const Right(null);
    } on FirebaseException catch (e) {
      return Left(_mapFirebaseError(e));
    }
  }

  Future<Either<Failure, List<CategoryModel>>> fetchAll(
    String userId,
  ) async {
    try {
      final snap = await _col(userId)
          .orderBy('sortOrder')
          .get();
      return Right(
        snap.docs
            .map((d) => CategoryModel.fromFirestore(d.id, d.data()))
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
