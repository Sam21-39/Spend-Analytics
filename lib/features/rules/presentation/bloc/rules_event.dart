import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:spend_analytics/features/expense/domain/entities/expense_entity.dart';
import 'package:spend_analytics/features/rules/domain/entities/rule_entity.dart';

part 'rules_event.freezed.dart';

@freezed
sealed class RulesEvent with _$RulesEvent {
  const factory RulesEvent.load({required String userId}) = RulesLoad;
  const factory RulesEvent.create({required RuleEntity rule}) = RulesCreate;
  const factory RulesEvent.update({required RuleEntity rule}) = RulesUpdate;
  const factory RulesEvent.delete({
    required String id,
    required String userId,
  }) = RulesDelete;
  const factory RulesEvent.toggle({
    required String id,
    required bool isActive,
    required String userId,
  }) = RulesToggle;
  const factory RulesEvent.evaluate({required ExpenseEntity expense}) =
      RulesEvaluate;
}
