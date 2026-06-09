// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_type.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PaymentTypeAdapter extends TypeAdapter<PaymentType> {
  @override
  final typeId = 100;

  @override
  PaymentType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return PaymentType.cash;
      case 1:
        return PaymentType.upi;
      case 2:
        return PaymentType.card;
      case 3:
        return PaymentType.netbanking;
      case 4:
        return PaymentType.bankTransfer;
      case 5:
        return PaymentType.wallet;
      case 6:
        return PaymentType.cheque;
      case 7:
        return PaymentType.other;
      default:
        return PaymentType.cash;
    }
  }

  @override
  void write(BinaryWriter writer, PaymentType obj) {
    switch (obj) {
      case PaymentType.cash:
        writer.writeByte(0);
      case PaymentType.upi:
        writer.writeByte(1);
      case PaymentType.card:
        writer.writeByte(2);
      case PaymentType.netbanking:
        writer.writeByte(3);
      case PaymentType.bankTransfer:
        writer.writeByte(4);
      case PaymentType.wallet:
        writer.writeByte(5);
      case PaymentType.cheque:
        writer.writeByte(6);
      case PaymentType.other:
        writer.writeByte(7);
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PaymentTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
