import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive_ce/hive.dart';
import 'package:spend_analytics/core/enums/expense_type.dart';
import 'package:spend_analytics/core/enums/payment_type.dart';
import 'package:spend_analytics/features/expense/domain/entities/expense_entity.dart';

part 'expense_model.g.dart';

@HiveType(typeId: 0)
class ExpenseModel {
  ExpenseModel({
    required this.id,
    required this.userId,
    required this.amount,
    required this.expenseType,
    required this.category,
    required this.paymentType,
    required this.transactionDate,
    required this.updatedAt,
    required this.createdAt,
    this.note,
    this.tags = const [],
    this.isDeleted = false,
    this.deletedAt,
  });

  @HiveField(0)
  String id;

  @HiveField(1)
  String userId;

  @HiveField(2)
  double amount;

  @HiveField(3)
  ExpenseType expenseType;

  @HiveField(4)
  String category;

  @HiveField(5)
  PaymentType paymentType;

  @HiveField(6)
  DateTime transactionDate;

  @HiveField(7)
  DateTime updatedAt;

  @HiveField(8)
  DateTime createdAt;

  @HiveField(9)
  String? note;

  @HiveField(10)
  List<String> tags;

  @HiveField(11)
  bool isDeleted;

  @HiveField(12)
  DateTime? deletedAt;

  factory ExpenseModel.fromEntity(ExpenseEntity e) => ExpenseModel(
    id: e.id,
    userId: e.userId,
    amount: e.amount,
    expenseType: e.expenseType,
    category: e.category,
    paymentType: e.paymentType,
    transactionDate: e.transactionDate,
    updatedAt: e.updatedAt,
    createdAt: e.createdAt,
    note: e.note,
    tags: e.tags,
  );

  factory ExpenseModel.fromFirestore(String id, Map<String, dynamic> data) =>
      ExpenseModel(
        id: id,
        userId: data['userId'] as String? ?? '',
        amount: (data['amount'] as num? ?? 0).toDouble(),
        expenseType: ExpenseType.fromString(data['type'] as String? ?? 'expense'),
        category: data['category'] as String? ?? '',
        paymentType: PaymentType.fromString(
          data['paymentMode'] as String? ?? 'other',
        ),
        transactionDate: _ts(data['transactionDate']),
        updatedAt: _ts(data['updatedAt']),
        createdAt: _ts(data['createdAt'] ?? data['transactionDate']),
        note: data['note'] as String?,
        tags: _parseStringList(data['tags']),
        isDeleted: data['isDeleted'] as bool? ?? false,
        deletedAt: _tsOrNull(data['deletedAt']),
      );

  ExpenseEntity toEntity() => ExpenseEntity(
    id: id,
    userId: userId,
    amount: amount,
    expenseType: expenseType,
    category: category,
    paymentType: paymentType,
    transactionDate: transactionDate,
    updatedAt: updatedAt,
    createdAt: createdAt,
    note: note,
    tags: tags,
  );

  Map<String, dynamic> toFirestoreMap() => {
    'userId': userId,
    'amount': amount,
    'type': expenseType.value,
    'category': category,
    'paymentMode': paymentType.value,
    'transactionDate': transactionDate.toUtc().toIso8601String(),
    'updatedAt': updatedAt.toUtc().toIso8601String(),
    'createdAt': createdAt.toUtc().toIso8601String(),
    'note': note,
    'tags': tags,
    'isDeleted': isDeleted,
    'deletedAt': deletedAt?.toUtc().toIso8601String(),
  };

  static DateTime _ts(dynamic v) {
    if (v is Timestamp) return v.toDate().toUtc();
    if (v is DateTime) return v.toUtc();
    if (v is String) return DateTime.parse(v).toUtc();
    return DateTime.now().toUtc();
  }

  static DateTime? _tsOrNull(dynamic v) => v == null ? null : _ts(v);

  static List<String> _parseStringList(dynamic v) {
    if (v == null) return [];
    if (v is List) return v.map((e) => '$e').toList();
    if (v is String) {
      try {
        final decoded = jsonDecode(v) as List;
        return decoded.map((e) => '$e').toList();
      } catch (_) {}
    }
    return [];
  }
}
