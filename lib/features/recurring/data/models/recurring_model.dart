import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive_ce/hive.dart';
import 'package:spend_analytics/core/enums/payment_type.dart';
import 'package:spend_analytics/core/enums/recurring_frequency.dart';
import 'package:spend_analytics/features/recurring/domain/entities/recurring_entity.dart';

part 'recurring_model.g.dart';

@HiveType(typeId: 3)
class RecurringModel {
  RecurringModel({
    required this.id,
    required this.userId,
    required this.title,
    required this.amount,
    required this.category,
    this.paymentType = PaymentType.other,
    this.frequency = RecurringFrequency.monthly,
    required this.nextDueDate,
    this.isActive = true,
    required this.createdAt,
    required this.updatedAt,
    this.isDeleted = false,
    this.deletedAt,
  });

  @HiveField(0)
  String id;

  @HiveField(1)
  String userId;

  @HiveField(2)
  String title;

  @HiveField(3)
  double amount;

  @HiveField(4)
  String category;

  @HiveField(5)
  PaymentType paymentType;

  @HiveField(6)
  RecurringFrequency frequency;

  @HiveField(7)
  DateTime nextDueDate;

  @HiveField(8)
  bool isActive;

  @HiveField(9)
  DateTime createdAt;

  @HiveField(10)
  DateTime updatedAt;

  @HiveField(11)
  bool isDeleted;

  @HiveField(12)
  DateTime? deletedAt;

  factory RecurringModel.fromEntity(RecurringEntity e) => RecurringModel(
    id: e.id,
    userId: e.userId,
    title: e.title,
    amount: e.amount,
    category: e.category,
    paymentType: e.paymentType,
    frequency: e.frequency,
    nextDueDate: e.nextDueDate,
    isActive: e.isActive,
    createdAt: e.createdAt,
    updatedAt: e.updatedAt,
    isDeleted: e.isDeleted,
    deletedAt: e.deletedAt,
  );

  factory RecurringModel.fromFirestore(String id, Map<String, dynamic> data) =>
      RecurringModel(
        id: id,
        userId: data['userId'] as String? ?? '',
        title: data['title'] as String? ?? '',
        amount: (data['amount'] as num? ?? 0).toDouble(),
        category: data['category'] as String? ?? '',
        paymentType: PaymentType.fromString(
          data['paymentType'] as String? ?? 'other',
        ),
        frequency: RecurringFrequency.fromString(
          data['frequency'] as String? ?? 'monthly',
        ),
        nextDueDate: _ts(data['nextDueDate']),
        isActive: data['isActive'] as bool? ?? true,
        createdAt: _ts(data['createdAt']),
        updatedAt: _ts(data['updatedAt']),
        isDeleted: data['isDeleted'] as bool? ?? false,
        deletedAt: _tsOrNull(data['deletedAt']),
      );

  RecurringEntity toEntity() => RecurringEntity(
    id: id,
    userId: userId,
    title: title,
    amount: amount,
    category: category,
    paymentType: paymentType,
    frequency: frequency,
    nextDueDate: nextDueDate,
    isActive: isActive,
    createdAt: createdAt,
    updatedAt: updatedAt,
    isDeleted: isDeleted,
    deletedAt: deletedAt,
  );

  Map<String, dynamic> toFirestoreMap() => {
    'userId': userId,
    'title': title,
    'amount': amount,
    'category': category,
    'paymentType': paymentType.value,
    'frequency': frequency.value,
    'nextDueDate': nextDueDate.toUtc().toIso8601String(),
    'isActive': isActive,
    'createdAt': createdAt.toUtc().toIso8601String(),
    'updatedAt': updatedAt.toUtc().toIso8601String(),
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
}
