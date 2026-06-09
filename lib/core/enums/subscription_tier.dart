import 'package:hive_ce/hive.dart';

part 'subscription_tier.g.dart';

@HiveType(typeId: 105)
enum SubscriptionTier {
  @HiveField(0)
  free,
  @HiveField(1)
  premiumMonthly,
  @HiveField(2)
  premiumLifetime;

  bool get isPremium => this != free;

  String get value => switch (this) {
    free => 'free',
    premiumMonthly => 'premium_monthly',
    premiumLifetime => 'premium_lifetime',
  };

  static SubscriptionTier fromString(String v) => switch (v.trim()) {
    'premium_monthly' => premiumMonthly,
    'premium_lifetime' => premiumLifetime,
    _ => free,
  };
}
