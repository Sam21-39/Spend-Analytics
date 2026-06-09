import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:spend_analytics/core/enums/subscription_tier.dart';

part 'user_entity.freezed.dart';

@freezed
abstract class UserEntity with _$UserEntity {
  const factory UserEntity({
    required String uid,
    String? email,
    String? displayName,
    String? photoUrl,
    @Default(false) bool isAnonymous,
    @Default(SubscriptionTier.free) SubscriptionTier subscriptionTier,
  }) = _UserEntity;
}
