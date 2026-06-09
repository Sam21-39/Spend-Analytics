import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:spend_analytics/core/error/failures.dart';
import 'package:spend_analytics/features/premium/domain/repositories/i_premium_repository.dart';

@injectable
class PurchasePremiumUseCase {
  const PurchasePremiumUseCase(this._repo);
  final IPremiumRepository _repo;

  Future<Either<Failure, void>> call(String productId) =>
      _repo.purchasePremium(productId);
}
