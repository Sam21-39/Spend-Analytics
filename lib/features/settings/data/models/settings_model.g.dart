// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SettingsModelAdapter extends TypeAdapter<SettingsModel> {
  @override
  final typeId = 6;

  @override
  SettingsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SettingsModel(
      currency: fields[0] == null ? 'INR' : fields[0] as String,
      notificationsEnabled: fields[1] == null ? true : fields[1] as bool,
      biometricLockEnabled: fields[2] == null ? false : fields[2] as bool,
      voiceEntryEnabled: fields[3] == null ? true : fields[3] as bool,
      themeModeIndex: fields[4] == null ? 0 : (fields[4] as num).toInt(),
      subscriptionTier:
          fields[5] == null
              ? SubscriptionTier.free
              : fields[5] as SubscriptionTier,
      hasCompletedOnboarding: fields[6] == null ? false : fields[6] as bool,
      privacyAccepted: fields[7] == null ? false : fields[7] as bool,
      lastSyncedAt: fields[8] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, SettingsModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.currency)
      ..writeByte(1)
      ..write(obj.notificationsEnabled)
      ..writeByte(2)
      ..write(obj.biometricLockEnabled)
      ..writeByte(3)
      ..write(obj.voiceEntryEnabled)
      ..writeByte(4)
      ..write(obj.themeModeIndex)
      ..writeByte(5)
      ..write(obj.subscriptionTier)
      ..writeByte(6)
      ..write(obj.hasCompletedOnboarding)
      ..writeByte(7)
      ..write(obj.privacyAccepted)
      ..writeByte(8)
      ..write(obj.lastSyncedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SettingsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
