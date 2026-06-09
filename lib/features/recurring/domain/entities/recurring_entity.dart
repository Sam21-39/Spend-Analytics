import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:spend_analytics/core/enums/payment_type.dart';
import 'package:spend_analytics/core/enums/recurring_frequency.dart';

part 'recurring_entity.freezed.dart';

@freezed
abstract class RecurringEntity with _$RecurringEntity {
  const factory RecurringEntity({
    required String id,
    required String userId,
    required String title,
    required double amount,
    required String category,
    @Default(PaymentType.other) PaymentType paymentType,
    @Default(RecurringFrequency.monthly) RecurringFrequency frequency,
    required DateTime nextDueDate,
    @Default(true) bool isActive,
    required DateTime createdAt,
    required DateTime updatedAt,
    @Default(false) bool isDeleted,
    DateTime? deletedAt,
  }) = _RecurringEntity;
}
