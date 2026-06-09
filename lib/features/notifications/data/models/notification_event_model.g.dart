// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_event_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NotificationEventModelAdapter
    extends TypeAdapter<NotificationEventModel> {
  @override
  final typeId = 5;

  @override
  NotificationEventModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NotificationEventModel(
      id: fields[0] as String,
      userId: fields[1] as String?,
      title: fields[2] as String,
      body: fields[3] as String,
      route: fields[4] as String?,
      payloadJson: fields[5] == null ? '{}' : fields[5] as String,
      source: fields[6] == null ? 'system' : fields[6] as String,
      isRead: fields[7] == null ? false : fields[7] as bool,
      createdAt: fields[8] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, NotificationEventModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.userId)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.body)
      ..writeByte(4)
      ..write(obj.route)
      ..writeByte(5)
      ..write(obj.payloadJson)
      ..writeByte(6)
      ..write(obj.source)
      ..writeByte(7)
      ..write(obj.isRead)
      ..writeByte(8)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NotificationEventModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
