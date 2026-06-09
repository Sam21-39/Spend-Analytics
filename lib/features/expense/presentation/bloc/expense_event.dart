import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:spend_analytics/features/expense/domain/entities/expense_entity.dart';
import 'package:spend_analytics/features/voice/voice_parser.dart';

part 'expense_event.freezed.dart';

@freezed
sealed class ExpenseEvent with _$ExpenseEvent {
  const factory ExpenseEvent.load({required String userId}) = ExpenseLoad;
  const factory ExpenseEvent.add({required ExpenseEntity expense}) = ExpenseAdd;
  const factory ExpenseEvent.update({required ExpenseEntity expense}) =
      ExpenseUpdate;
  const factory ExpenseEvent.delete({
    required String id,
    required String userId,
  }) = ExpenseDelete;
  const factory ExpenseEvent.filter({
    String? type,
    String? category,
  }) = ExpenseFilter;
  const factory ExpenseEvent.applyVoiceResult({
    required VoiceParseResult result,
    required String userId,
  }) = ExpenseApplyVoiceResult;
}
