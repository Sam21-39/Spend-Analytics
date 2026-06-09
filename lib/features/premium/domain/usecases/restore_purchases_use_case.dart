import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:spend_analytics/core/error/failures.dart';
import 'package:spend_analytics/features/premium/domain/repositories/i_premium_repository.dart';

@injectable
class RestorePurchasesUseCase {
  const RestorePurchasesUseCase(this._repo);
  final IPremiumRepository _repo;

  Future<Either<Failure, void>> call(String userId) =>
      _repo.restorePurchases(userId);
}
