// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'budget_period.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BudgetPeriodAdapter extends TypeAdapter<BudgetPeriod> {
  @override
  final typeId = 102;

  @override
  BudgetPeriod read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return BudgetPeriod.monthly;
      case 1:
        return BudgetPeriod.weekly;
      case 2:
        return BudgetPeriod.yearly;
      default:
        return BudgetPeriod.monthly;
    }
  }

  @override
  void write(BinaryWriter writer, BudgetPeriod obj) {
    switch (obj) {
      case BudgetPeriod.monthly:
        writer.writeByte(0);
      case BudgetPeriod.weekly:
        writer.writeByte(1);
      case BudgetPeriod.yearly:
        writer.writeByte(2);
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BudgetPeriodAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
