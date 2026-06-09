import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:spend_analytics/core/error/failures.dart';
import 'package:spend_analytics/features/rules/domain/entities/rule_entity.dart';

part 'rules_state.freezed.dart';

@freezed
sealed class RulesState with _$RulesState {
  const factory RulesState.initial() = RulesInitial;
  const factory RulesState.loading() = RulesLoading;
  const factory RulesState.loaded({required List<RuleEntity> rules}) =
      RulesLoaded;
  const factory RulesState.saving() = RulesSaving;
  const factory RulesState.failure({required Failure failure}) = RulesFailure;
}
