import 'package:hive_ce/hive.dart';

part 'payment_type.g.dart';

@HiveType(typeId: 100)
enum PaymentType {
  @HiveField(0)
  cash,
  @HiveField(1)
  upi,
  @HiveField(2)
  card,
  @HiveField(3)
  netbanking,
  @HiveField(4)
  bankTransfer,
  @HiveField(5)
  wallet,
  @HiveField(6)
  cheque,
  @HiveField(7)
  other;

  String get value => switch (this) {
    cash => 'cash',
    upi => 'upi',
    card => 'card',
    netbanking => 'netbanking',
    bankTransfer => 'bank_transfer',
    wallet => 'wallet',
    cheque => 'cheque',
    other => 'other',
  };

  static PaymentType fromString(String v) => switch (v.trim().toLowerCase()) {
    'cash' => cash,
    'upi' => upi,
    'card' || 'credit_card' || 'debit_card' => card,
    'netbanking' || 'net_banking' || 'net banking' => netbanking,
    'bank_transfer' || 'bank transfer' => bankTransfer,
    'wallet' => wallet,
    'cheque' || 'check' => cheque,
    _ => other,
  };
}
