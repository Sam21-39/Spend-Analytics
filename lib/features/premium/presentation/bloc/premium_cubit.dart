import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:spend_analytics/features/premium/domain/usecases/get_subscription_status_use_case.dart';
import 'package:spend_analytics/features/premium/domain/usecases/purchase_premium_use_case.dart';
import 'package:spend_analytics/features/premium/domain/usecases/restore_purchases_use_case.dart';
import 'package:spend_analytics/features/premium/domain/usecases/verify_purchase_use_case.dart';

import 'premium_state.dart';

@lazySingleton
class PremiumCubit extends Cubit<PremiumState> {
  PremiumCubit(
    this._getStatus,
    this._purchase,
    this._restore,
    this._verify,
  ) : super(const PremiumState());

  final GetSubscriptionStatusUseCase _getStatus;
  final PurchasePremiumUseCase _purchase;
  final RestorePurchasesUseCase _restore;
  final VerifyPurchaseUseCase _verify;

  Future<void> loadStatus(String userId) async {
    emit(state.copyWith(isLoading: true, failure: null));
    final result = await _getStatus(userId);
    result.fold(
      (f) => emit(state.copyWith(isLoading: false, failure: f)),
      (tier) => emit(state.copyWith(isLoading: false, tier: tier, failure: null)),
    );
  }

  Future<void> purchase(String productId, String userId) async {
    emit(state.copyWith(isLoading: true, failure: null));
    final result = await _purchase(productId);
    result.fold(
      (f) => emit(state.copyWith(isLoading: false, failure: f)),
      (_) => loadStatus(userId),
    );
  }

  Future<void> restorePurchases(String userId) async {
    emit(state.copyWith(isLoading: true, failure: null));
    final result = await _restore(userId);
    result.fold(
      (f) => emit(state.copyWith(isLoading: false, failure: f)),
      (_) => loadStatus(userId),
    );
  }

  Future<void> verifyPurchase({
    required String userId,
    required String purchaseToken,
  }) async {
    emit(state.copyWith(isLoading: true, failure: null));
    final result = await _verify(userId: userId, purchaseToken: purchaseToken);
    result.fold(
      (f) => emit(state.copyWith(isLoading: false, failure: f)),
      (_) => loadStatus(userId),
    );
  }

  bool get isPremium => false; // resolved after Freezed generates: state.tier != SubscriptionTier.free
}
