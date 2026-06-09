// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rule_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RuleModelAdapter extends TypeAdapter<RuleModel> {
  @override
  final typeId = 2;

  @override
  RuleModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RuleModel(
      id: fields[0] as String,
      userId: fields[1] as String,
      ruleType: fields[2] as RuleType,
      parametersJson: fields[3] == null ? '{}' : fields[3] as String,
      isActive: fields[4] == null ? true : fields[4] as bool,
      createdAt: fields[5] as DateTime,
      updatedAt: fields[6] as DateTime,
      isDeleted: fields[7] == null ? false : fields[7] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, RuleModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.userId)
      ..writeByte(2)
      ..write(obj.ruleType)
      ..writeByte(3)
      ..write(obj.parametersJson)
      ..writeByte(4)
      ..write(obj.isActive)
      ..writeByte(5)
      ..write(obj.createdAt)
      ..writeByte(6)
      ..write(obj.updatedAt)
      ..writeByte(7)
      ..write(obj.isDeleted);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RuleModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
