// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rule_type.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RuleTypeAdapter extends TypeAdapter<RuleType> {
  @override
  final typeId = 103;

  @override
  RuleType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return RuleType.budgetThreshold;
      case 1:
        return RuleType.dailyLimit;
      case 2:
        return RuleType.noEntryReminder;
      case 3:
        return RuleType.categorySpike;
      case 4:
        return RuleType.weekendOverspend;
      case 5:
        return RuleType.recurringDue;
      default:
        return RuleType.budgetThreshold;
    }
  }

  @override
  void write(BinaryWriter writer, RuleType obj) {
    switch (obj) {
      case RuleType.budgetThreshold:
        writer.writeByte(0);
      case RuleType.dailyLimit:
        writer.writeByte(1);
      case RuleType.noEntryReminder:
        writer.writeByte(2);
      case RuleType.categorySpike:
        writer.writeByte(3);
      case RuleType.weekendOverspend:
        writer.writeByte(4);
      case RuleType.recurringDue:
        writer.writeByte(5);
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RuleTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
