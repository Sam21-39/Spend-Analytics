// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'settings_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SettingsEntity {

 String get currency; bool get notificationsEnabled; bool get biometricLockEnabled; bool get voiceEntryEnabled; ThemeMode get themeMode; SubscriptionTier get subscriptionTier; bool get hasCompletedOnboarding; bool get privacyAccepted; DateTime? get lastSyncedAt;
/// Create a copy of SettingsEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SettingsEntityCopyWith<SettingsEntity> get copyWith => _$SettingsEntityCopyWithImpl<SettingsEntity>(this as SettingsEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SettingsEntity&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.notificationsEnabled, notificationsEnabled) || other.notificationsEnabled == notificationsEnabled)&&(identical(other.biometricLockEnabled, biometricLockEnabled) || other.biometricLockEnabled == biometricLockEnabled)&&(identical(other.voiceEntryEnabled, voiceEntryEnabled) || other.voiceEntryEnabled == voiceEntryEnabled)&&(identical(other.themeMode, themeMode) || other.themeMode == themeMode)&&(identical(other.subscriptionTier, subscriptionTier) || other.subscriptionTier == subscriptionTier)&&(identical(other.hasCompletedOnboarding, hasCompletedOnboarding) || other.hasCompletedOnboarding == hasCompletedOnboarding)&&(identical(other.privacyAccepted, privacyAccepted) || other.privacyAccepted == privacyAccepted)&&(identical(other.lastSyncedAt, lastSyncedAt) || other.lastSyncedAt == lastSyncedAt));
}


@override
int get hashCode => Object.hash(runtimeType,currency,notificationsEnabled,biometricLockEnabled,voiceEntryEnabled,themeMode,subscriptionTier,hasCompletedOnboarding,privacyAccepted,lastSyncedAt);

@override
String toString() {
  return 'SettingsEntity(currency: $currency, notificationsEnabled: $notificationsEnabled, biometricLockEnabled: $biometricLockEnabled, voiceEntryEnabled: $voiceEntryEnabled, themeMode: $themeMode, subscriptionTier: $subscriptionTier, hasCompletedOnboarding: $hasCompletedOnboarding, privacyAccepted: $privacyAccepted, lastSyncedAt: $lastSyncedAt)';
}


}

/// @nodoc
abstract mixin class $SettingsEntityCopyWith<$Res>  {
  factory $SettingsEntityCopyWith(SettingsEntity value, $Res Function(SettingsEntity) _then) = _$SettingsEntityCopyWithImpl;
@useResult
$Res call({
 String currency, bool notificationsEnabled, bool biometricLockEnabled, bool voiceEntryEnabled, ThemeMode themeMode, SubscriptionTier subscriptionTier, bool hasCompletedOnboarding, bool privacyAccepted, DateTime? lastSyncedAt
});




}
/// @nodoc
class _$SettingsEntityCopyWithImpl<$Res>
    implements $SettingsEntityCopyWith<$Res> {
  _$SettingsEntityCopyWithImpl(this._self, this._then);

  final SettingsEntity _self;
  final $Res Function(SettingsEntity) _then;

/// Create a copy of SettingsEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? currency = null,Object? notificationsEnabled = null,Object? biometricLockEnabled = null,Object? voiceEntryEnabled = null,Object? themeMode = null,Object? subscriptionTier = null,Object? hasCompletedOnboarding = null,Object? privacyAccepted = null,Object? lastSyncedAt = freezed,}) {
  return _then(_self.copyWith(
currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,notificationsEnabled: null == notificationsEnabled ? _self.notificationsEnabled : notificationsEnabled // ignore: cast_nullable_to_non_nullable
as bool,biometricLockEnabled: null == biometricLockEnabled ? _self.biometricLockEnabled : biometricLockEnabled // ignore: cast_nullable_to_non_nullable
as bool,voiceEntryEnabled: null == voiceEntryEnabled ? _self.voiceEntryEnabled : voiceEntryEnabled // ignore: cast_nullable_to_non_nullable
as bool,themeMode: null == themeMode ? _self.themeMode : themeMode // ignore: cast_nullable_to_non_nullable
as ThemeMode,subscriptionTier: null == subscriptionTier ? _self.subscriptionTier : subscriptionTier // ignore: cast_nullable_to_non_nullable
as SubscriptionTier,hasCompletedOnboarding: null == hasCompletedOnboarding ? _self.hasCompletedOnboarding : hasCompletedOnboarding // ignore: cast_nullable_to_non_nullable
as bool,privacyAccepted: null == privacyAccepted ? _self.privacyAccepted : privacyAccepted // ignore: cast_nullable_to_non_nullable
as bool,lastSyncedAt: freezed == lastSyncedAt ? _self.lastSyncedAt : lastSyncedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [SettingsEntity].
extension SettingsEntityPatterns on SettingsEntity {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SettingsEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SettingsEntity() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SettingsEntity value)  $default,){
final _that = this;
switch (_that) {
case _SettingsEntity():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SettingsEntity value)?  $default,){
final _that = this;
switch (_that) {
case _SettingsEntity() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String currency,  bool notificationsEnabled,  bool biometricLockEnabled,  bool voiceEntryEnabled,  ThemeMode themeMode,  SubscriptionTier subscriptionTier,  bool hasCompletedOnboarding,  bool privacyAccepted,  DateTime? lastSyncedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SettingsEntity() when $default != null:
return $default(_that.currency,_that.notificationsEnabled,_that.biometricLockEnabled,_that.voiceEntryEnabled,_that.themeMode,_that.subscriptionTier,_that.hasCompletedOnboarding,_that.privacyAccepted,_that.lastSyncedAt);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String currency,  bool notificationsEnabled,  bool biometricLockEnabled,  bool voiceEntryEnabled,  ThemeMode themeMode,  SubscriptionTier subscriptionTier,  bool hasCompletedOnboarding,  bool privacyAccepted,  DateTime? lastSyncedAt)  $default,) {final _that = this;
switch (_that) {
case _SettingsEntity():
return $default(_that.currency,_that.notificationsEnabled,_that.biometricLockEnabled,_that.voiceEntryEnabled,_that.themeMode,_that.subscriptionTier,_that.hasCompletedOnboarding,_that.privacyAccepted,_that.lastSyncedAt);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String currency,  bool notificationsEnabled,  bool biometricLockEnabled,  bool voiceEntryEnabled,  ThemeMode themeMode,  SubscriptionTier subscriptionTier,  bool hasCompletedOnboarding,  bool privacyAccepted,  DateTime? lastSyncedAt)?  $default,) {final _that = this;
switch (_that) {
case _SettingsEntity() when $default != null:
return $default(_that.currency,_that.notificationsEnabled,_that.biometricLockEnabled,_that.voiceEntryEnabled,_that.themeMode,_that.subscriptionTier,_that.hasCompletedOnboarding,_that.privacyAccepted,_that.lastSyncedAt);case _:
  return null;

}
}

}

/// @nodoc


class _SettingsEntity implements SettingsEntity {
  const _SettingsEntity({this.currency = 'INR', this.notificationsEnabled = true, this.biometricLockEnabled = false, this.voiceEntryEnabled = true, this.themeMode = ThemeMode.system, this.subscriptionTier = SubscriptionTier.free, this.hasCompletedOnboarding = false, this.privacyAccepted = false, this.lastSyncedAt});
  

@override@JsonKey() final  String currency;
@override@JsonKey() final  bool notificationsEnabled;
@override@JsonKey() final  bool biometricLockEnabled;
@override@JsonKey() final  bool voiceEntryEnabled;
@override@JsonKey() final  ThemeMode themeMode;
@override@JsonKey() final  SubscriptionTier subscriptionTier;
@override@JsonKey() final  bool hasCompletedOnboarding;
@override@JsonKey() final  bool privacyAccepted;
@override final  DateTime? lastSyncedAt;

/// Create a copy of SettingsEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SettingsEntityCopyWith<_SettingsEntity> get copyWith => __$SettingsEntityCopyWithImpl<_SettingsEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SettingsEntity&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.notificationsEnabled, notificationsEnabled) || other.notificationsEnabled == notificationsEnabled)&&(identical(other.biometricLockEnabled, biometricLockEnabled) || other.biometricLockEnabled == biometricLockEnabled)&&(identical(other.voiceEntryEnabled, voiceEntryEnabled) || other.voiceEntryEnabled == voiceEntryEnabled)&&(identical(other.themeMode, themeMode) || other.themeMode == themeMode)&&(identical(other.subscriptionTier, subscriptionTier) || other.subscriptionTier == subscriptionTier)&&(identical(other.hasCompletedOnboarding, hasCompletedOnboarding) || other.hasCompletedOnboarding == hasCompletedOnboarding)&&(identical(other.privacyAccepted, privacyAccepted) || other.privacyAccepted == privacyAccepted)&&(identical(other.lastSyncedAt, lastSyncedAt) || other.lastSyncedAt == lastSyncedAt));
}


@override
int get hashCode => Object.hash(runtimeType,currency,notificationsEnabled,biometricLockEnabled,voiceEntryEnabled,themeMode,subscriptionTier,hasCompletedOnboarding,privacyAccepted,lastSyncedAt);

@override
String toString() {
  return 'SettingsEntity(currency: $currency, notificationsEnabled: $notificationsEnabled, biometricLockEnabled: $biometricLockEnabled, voiceEntryEnabled: $voiceEntryEnabled, themeMode: $themeMode, subscriptionTier: $subscriptionTier, hasCompletedOnboarding: $hasCompletedOnboarding, privacyAccepted: $privacyAccepted, lastSyncedAt: $lastSyncedAt)';
}


}

/// @nodoc
abstract mixin class _$SettingsEntityCopyWith<$Res> implements $SettingsEntityCopyWith<$Res> {
  factory _$SettingsEntityCopyWith(_SettingsEntity value, $Res Function(_SettingsEntity) _then) = __$SettingsEntityCopyWithImpl;
@override @useResult
$Res call({
 String currency, bool notificationsEnabled, bool biometricLockEnabled, bool voiceEntryEnabled, ThemeMode themeMode, SubscriptionTier subscriptionTier, bool hasCompletedOnboarding, bool privacyAccepted, DateTime? lastSyncedAt
});




}
/// @nodoc
class __$SettingsEntityCopyWithImpl<$Res>
    implements _$SettingsEntityCopyWith<$Res> {
  __$SettingsEntityCopyWithImpl(this._self, this._then);

  final _SettingsEntity _self;
  final $Res Function(_SettingsEntity) _then;

/// Create a copy of SettingsEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? currency = null,Object? notificationsEnabled = null,Object? biometricLockEnabled = null,Object? voiceEntryEnabled = null,Object? themeMode = null,Object? subscriptionTier = null,Object? hasCompletedOnboarding = null,Object? privacyAccepted = null,Object? lastSyncedAt = freezed,}) {
  return _then(_SettingsEntity(
currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,notificationsEnabled: null == notificationsEnabled ? _self.notificationsEnabled : notificationsEnabled // ignore: cast_nullable_to_non_nullable
as bool,biometricLockEnabled: null == biometricLockEnabled ? _self.biometricLockEnabled : biometricLockEnabled // ignore: cast_nullable_to_non_nullable
as bool,voiceEntryEnabled: null == voiceEntryEnabled ? _self.voiceEntryEnabled : voiceEntryEnabled // ignore: cast_nullable_to_non_nullable
as bool,themeMode: null == themeMode ? _self.themeMode : themeMode // ignore: cast_nullable_to_non_nullable
as ThemeMode,subscriptionTier: null == subscriptionTier ? _self.subscriptionTier : subscriptionTier // ignore: cast_nullable_to_non_nullable
as SubscriptionTier,hasCompletedOnboarding: null == hasCompletedOnboarding ? _self.hasCompletedOnboarding : hasCompletedOnboarding // ignore: cast_nullable_to_non_nullable
as bool,privacyAccepted: null == privacyAccepted ? _self.privacyAccepted : privacyAccepted // ignore: cast_nullable_to_non_nullable
as bool,lastSyncedAt: freezed == lastSyncedAt ? _self.lastSyncedAt : lastSyncedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
