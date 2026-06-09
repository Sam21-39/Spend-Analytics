import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:spend_analytics/core/enums/subscription_tier.dart';
import 'package:spend_analytics/core/error/failures.dart';

part 'premium_state.freezed.dart';

@freezed
abstract class PremiumState with _$PremiumState {
  const factory PremiumState({
    @Default(SubscriptionTier.free) SubscriptionTier tier,
    @Default(false) bool isLoading,
    Failure? failure,
  }) = _PremiumState;
}
