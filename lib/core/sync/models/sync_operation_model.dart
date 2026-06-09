import 'package:hive_ce/hive.dart';

part 'sync_operation_model.g.dart';

@HiveType(typeId: 7)
class SyncOperationModel {
  SyncOperationModel({
    required this.id,
    required this.entityType,
    required this.operation,
    required this.entityId,
    required this.payloadJson,
    this.userId,
    required this.createdAt,
    required this.updatedAt,
    this.retryCount = 0,
    this.lastError,
  });

  @HiveField(0)
  String id;

  /// 'expense' | 'budget' | 'rule' | 'recurring' | 'category' | 'notification'
  @HiveField(1)
  String entityType;

  /// 'upsert' | 'delete'
  @HiveField(2)
  String operation;

  @HiveField(3)
  String entityId;

  @HiveField(4)
  String payloadJson;

  @HiveField(5)
  String? userId;

  @HiveField(6)
  DateTime createdAt;

  @HiveField(7)
  DateTime updatedAt;

  @HiveField(8)
  int retryCount;

  @HiveField(9)
  String? lastError;
}
