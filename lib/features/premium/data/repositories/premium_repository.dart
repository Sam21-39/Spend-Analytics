import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:spend_analytics/core/enums/subscription_tier.dart';
import 'package:spend_analytics/core/error/failures.dart';
import 'package:spend_analytics/features/premium/domain/repositories/i_premium_repository.dart';

// TODO(Phase 5): Replace with full IAP + Razorpay implementation.
@LazySingleton(as: IPremiumRepository)
class PremiumRepository implements IPremiumRepository {
  @override
  Future<Either<Failure, SubscriptionTier>> getStatus(String userId) async =>
      const Right(SubscriptionTier.free);

  @override
  Future<Either<Failure, void>> purchasePremium(String productId) async =>
      Left(const Failure.payment('Not implemented'));

  @override
  Future<Either<Failure, void>> restorePurchases(String userId) async =>
      Left(const Failure.payment('Not implemented'));

  @override
  Future<Either<Failure, void>> verifyPurchase({
    required String userId,
    required String purchaseToken,
  }) async =>
      Left(const Failure.payment('Not implemented'));
}
