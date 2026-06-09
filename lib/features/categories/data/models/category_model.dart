import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive_ce/hive.dart';
import 'package:spend_analytics/features/categories/domain/entities/category_entity.dart';

part 'category_model.g.dart';

@HiveType(typeId: 4)
class CategoryModel {
  CategoryModel({
    required this.id,
    required this.userId,
    required this.name,
    required this.type,
    required this.sortOrder,
    required this.createdAt,
    required this.updatedAt,
  });

  @HiveField(0)
  String id;

  @HiveField(1)
  String userId;

  @HiveField(2)
  String name;

  /// 'expense' | 'income' | 'transfer'
  @HiveField(3)
  String type;

  @HiveField(4)
  int sortOrder;

  @HiveField(5)
  DateTime createdAt;

  @HiveField(6)
  DateTime updatedAt;

  factory CategoryModel.fromEntity(CategoryEntity e) => CategoryModel(
    id: e.id,
    userId: e.userId,
    name: e.name,
    type: e.type,
    sortOrder: e.sortOrder,
    createdAt: e.createdAt,
    updatedAt: e.updatedAt,
  );

  factory CategoryModel.fromFirestore(String id, Map<String, dynamic> data) =>
      CategoryModel(
        id: id,
        userId: data['userId'] as String? ?? '',
        name: data['name'] as String? ?? '',
        type: data['type'] as String? ?? 'expense',
        sortOrder: data['sortOrder'] as int? ?? 0,
        createdAt: _ts(data['createdAt']),
        updatedAt: _ts(data['updatedAt']),
      );

  CategoryEntity toEntity() => CategoryEntity(
    id: id,
    userId: userId,
    name: name,
    type: type,
    sortOrder: sortOrder,
    createdAt: createdAt,
    updatedAt: updatedAt,
  );

  Map<String, dynamic> toFirestoreMap() => {
    'userId': userId,
    'name': name,
    'type': type,
    'sortOrder': sortOrder,
    'createdAt': createdAt.toUtc().toIso8601String(),
    'updatedAt': updatedAt.toUtc().toIso8601String(),
  };

  static DateTime _ts(dynamic v) {
    if (v is Timestamp) return v.toDate().toUtc();
    if (v is DateTime) return v.toUtc();
    if (v is String) return DateTime.parse(v).toUtc();
    return DateTime.now().toUtc();
  }
}
