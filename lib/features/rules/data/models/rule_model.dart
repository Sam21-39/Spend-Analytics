import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive_ce/hive.dart';
import 'package:spend_analytics/core/enums/rule_type.dart';
import 'package:spend_analytics/features/rules/domain/entities/rule_entity.dart';

part 'rule_model.g.dart';

@HiveType(typeId: 2)
class RuleModel {
  RuleModel({
    required this.id,
    required this.userId,
    required this.ruleType,
    this.parametersJson = '{}',
    this.isActive = true,
    required this.createdAt,
    required this.updatedAt,
    this.isDeleted = false,
  });

  @HiveField(0)
  String id;

  @HiveField(1)
  String userId;

  @HiveField(2)
  RuleType ruleType;

  @HiveField(3)
  String parametersJson;

  @HiveField(4)
  bool isActive;

  @HiveField(5)
  DateTime createdAt;

  @HiveField(6)
  DateTime updatedAt;

  @HiveField(7)
  bool isDeleted;

  Map<String, dynamic> get parameters {
    try {
      final decoded = jsonDecode(parametersJson);
      if (decoded is Map<String, dynamic>) return decoded;
      if (decoded is Map) {
        return decoded.map((k, v) => MapEntry('$k', v));
      }
    } catch (_) {}
    return const {};
  }

  factory RuleModel.fromEntity(RuleEntity e) => RuleModel(
    id: e.id,
    userId: e.userId,
    ruleType: e.ruleType,
    parametersJson: jsonEncode(e.parameters),
    isActive: e.isActive,
    createdAt: e.createdAt,
    updatedAt: e.updatedAt,
    isDeleted: e.isDeleted,
  );

  factory RuleModel.fromFirestore(String id, Map<String, dynamic> data) =>
      RuleModel(
        id: id,
        userId: data['userId'] as String? ?? '',
        ruleType: RuleType.fromString(data['ruleType'] as String? ?? ''),
        parametersJson: _encodeParams(data['parameters']),
        isActive: data['isActive'] as bool? ?? true,
        createdAt: _ts(data['createdAt']),
        updatedAt: _ts(data['updatedAt']),
        isDeleted: data['isDeleted'] as bool? ?? false,
      );

  RuleEntity toEntity() => RuleEntity(
    id: id,
    userId: userId,
    ruleType: ruleType,
    parameters: parameters,
    isActive: isActive,
    createdAt: createdAt,
    updatedAt: updatedAt,
    isDeleted: isDeleted,
  );

  Map<String, dynamic> toFirestoreMap() => {
    'userId': userId,
    'ruleType': ruleType.value,
    'parameters': parameters,
    'isActive': isActive,
    'createdAt': createdAt.toUtc().toIso8601String(),
    'updatedAt': updatedAt.toUtc().toIso8601String(),
    'isDeleted': isDeleted,
  };

  static String _encodeParams(dynamic v) {
    if (v is Map<String, dynamic>) return jsonEncode(v);
    if (v is Map) return jsonEncode(v.map((k, val) => MapEntry('$k', val)));
    if (v is String) return v;
    return '{}';
  }

  static DateTime _ts(dynamic v) {
    if (v is Timestamp) return v.toDate().toUtc();
    if (v is DateTime) return v.toUtc();
    if (v is String) return DateTime.parse(v).toUtc();
    return DateTime.now().toUtc();
  }
}
