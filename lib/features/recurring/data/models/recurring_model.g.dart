// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recurring_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RecurringModelAdapter extends TypeAdapter<RecurringModel> {
  @override
  final typeId = 3;

  @override
  RecurringModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RecurringModel(
      id: fields[0] as String,
      userId: fields[1] as String,
      title: fields[2] as String,
      amount: (fields[3] as num).toDouble(),
      category: fields[4] as String,
      paymentType:
          fields[5] == null ? PaymentType.other : fields[5] as PaymentType,
      frequency:
          fields[6] == null
              ? RecurringFrequency.monthly
              : fields[6] as RecurringFrequency,
      nextDueDate: fields[7] as DateTime,
      isActive: fields[8] == null ? true : fields[8] as bool,
      createdAt: fields[9] as DateTime,
      updatedAt: fields[10] as DateTime,
      isDeleted: fields[11] == null ? false : fields[11] as bool,
      deletedAt: fields[12] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, RecurringModel obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.userId)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.amount)
      ..writeByte(4)
      ..write(obj.category)
      ..writeByte(5)
      ..write(obj.paymentType)
      ..writeByte(6)
      ..write(obj.frequency)
      ..writeByte(7)
      ..write(obj.nextDueDate)
      ..writeByte(8)
      ..write(obj.isActive)
      ..writeByte(9)
      ..write(obj.createdAt)
      ..writeByte(10)
      ..write(obj.updatedAt)
      ..writeByte(11)
      ..write(obj.isDeleted)
      ..writeByte(12)
      ..write(obj.deletedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RecurringModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
