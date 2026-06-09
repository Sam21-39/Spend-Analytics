import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:spend_analytics/core/enums/rule_type.dart';

part 'rule_entity.freezed.dart';

@freezed
abstract class RuleEntity with _$RuleEntity {
  const factory RuleEntity({
    required String id,
    required String userId,
    required RuleType ruleType,
    @Default({}) Map<String, dynamic> parameters,
    @Default(true) bool isActive,
    required DateTime createdAt,
    required DateTime updatedAt,
    @Default(false) bool isDeleted,
  }) = _RuleEntity;
}
