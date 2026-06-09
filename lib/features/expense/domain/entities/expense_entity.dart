import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:spend_analytics/core/enums/expense_type.dart';
import 'package:spend_analytics/core/enums/payment_type.dart';

part 'expense_entity.freezed.dart';

@freezed
abstract class ExpenseEntity with _$ExpenseEntity {
  const factory ExpenseEntity({
    required String id,
    required String userId,
    required double amount,
    required ExpenseType expenseType,
    required String category,
    required PaymentType paymentType,
    required DateTime transactionDate,
    required DateTime updatedAt,
    required DateTime createdAt,
    String? note,
    @Default([]) List<String> tags,
  }) = _ExpenseEntity;
}
