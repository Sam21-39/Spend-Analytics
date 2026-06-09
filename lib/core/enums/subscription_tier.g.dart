// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription_tier.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SubscriptionTierAdapter extends TypeAdapter<SubscriptionTier> {
  @override
  final typeId = 105;

  @override
  SubscriptionTier read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return SubscriptionTier.free;
      case 1:
        return SubscriptionTier.premiumMonthly;
      case 2:
        return SubscriptionTier.premiumLifetime;
      default:
        return SubscriptionTier.free;
    }
  }

  @override
  void write(BinaryWriter writer, SubscriptionTier obj) {
    switch (obj) {
      case SubscriptionTier.free:
        writer.writeByte(0);
      case SubscriptionTier.premiumMonthly:
        writer.writeByte(1);
      case SubscriptionTier.premiumLifetime:
        writer.writeByte(2);
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SubscriptionTierAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
