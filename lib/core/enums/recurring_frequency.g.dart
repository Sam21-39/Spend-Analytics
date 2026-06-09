// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recurring_frequency.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RecurringFrequencyAdapter extends TypeAdapter<RecurringFrequency> {
  @override
  final typeId = 104;

  @override
  RecurringFrequency read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return RecurringFrequency.daily;
      case 1:
        return RecurringFrequency.weekly;
      case 2:
        return RecurringFrequency.monthly;
      case 3:
        return RecurringFrequency.yearly;
      default:
        return RecurringFrequency.daily;
    }
  }

  @override
  void write(BinaryWriter writer, RecurringFrequency obj) {
    switch (obj) {
      case RecurringFrequency.daily:
        writer.writeByte(0);
      case RecurringFrequency.weekly:
        writer.writeByte(1);
      case RecurringFrequency.monthly:
        writer.writeByte(2);
      case RecurringFrequency.yearly:
        writer.writeByte(3);
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RecurringFrequencyAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
