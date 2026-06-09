import 'package:dartz/dartz.dart';
import 'package:spend_analytics/core/enums/subscription_tier.dart';
import 'package:spend_analytics/core/error/failures.dart';

abstract interface class IPremiumRepository {
  Future<Either<Failure, SubscriptionTier>> getStatus(String userId);
  Future<Either<Failure, void>> purchasePremium(String productId);
  Future<Either<Failure, void>> restorePurchases(String userId);
  Future<Either<Failure, void>> verifyPurchase({
    required String userId,
    required String purchaseToken,
  });
}
