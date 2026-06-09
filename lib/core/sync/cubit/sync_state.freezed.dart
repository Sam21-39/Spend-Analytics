// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sync_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SyncState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SyncState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SyncState()';
}


}

/// @nodoc
class $SyncStateCopyWith<$Res>  {
$SyncStateCopyWith(SyncState _, $Res Function(SyncState) __);
}


/// Adds pattern-matching-related methods to [SyncState].
extension SyncStatePatterns on SyncState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( SyncIdle value)?  idle,TResult Function( SyncSyncing value)?  syncing,TResult Function( SyncSynced value)?  synced,required TResult orElse(),}){
final _that = this;
switch (_that) {
case SyncIdle() when idle != null:
return idle(_that);case SyncSyncing() when syncing != null:
return syncing(_that);case SyncSynced() when synced != null:
return synced(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( SyncIdle value)  idle,required TResult Function( SyncSyncing value)  syncing,required TResult Function( SyncSynced value)  synced,}){
final _that = this;
switch (_that) {
case SyncIdle():
return idle(_that);case SyncSyncing():
return syncing(_that);case SyncSynced():
return synced(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( SyncIdle value)?  idle,TResult? Function( SyncSyncing value)?  syncing,TResult? Function( SyncSynced value)?  synced,}){
final _that = this;
switch (_that) {
case SyncIdle() when idle != null:
return idle(_that);case SyncSyncing() when syncing != null:
return syncing(_that);case SyncSynced() when synced != null:
return synced(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  idle,TResult Function()?  syncing,TResult Function( int pendingCount)?  synced,required TResult orElse(),}) {final _that = this;
switch (_that) {
case SyncIdle() when idle != null:
return idle();case SyncSyncing() when syncing != null:
return syncing();case SyncSynced() when synced != null:
return synced(_that.pendingCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  idle,required TResult Function()  syncing,required TResult Function( int pendingCount)  synced,}) {final _that = this;
switch (_that) {
case SyncIdle():
return idle();case SyncSyncing():
return syncing();case SyncSynced():
return synced(_that.pendingCount);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  idle,TResult? Function()?  syncing,TResult? Function( int pendingCount)?  synced,}) {final _that = this;
switch (_that) {
case SyncIdle() when idle != null:
return idle();case SyncSyncing() when syncing != null:
return syncing();case SyncSynced() when synced != null:
return synced(_that.pendingCount);case _:
  return null;

}
}

}

/// @nodoc


class SyncIdle implements SyncState {
  const SyncIdle();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SyncIdle);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SyncState.idle()';
}


}




/// @nodoc


class SyncSyncing implements SyncState {
  const SyncSyncing();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SyncSyncing);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SyncState.syncing()';
}


}




/// @nodoc


class SyncSynced implements SyncState {
  const SyncSynced({required this.pendingCount});
  

 final  int pendingCount;

/// Create a copy of SyncState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SyncSyncedCopyWith<SyncSynced> get copyWith => _$SyncSyncedCopyWithImpl<SyncSynced>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SyncSynced&&(identical(other.pendingCount, pendingCount) || other.pendingCount == pendingCount));
}


@override
int get hashCode => Object.hash(runtimeType,pendingCount);

@override
String toString() {
  return 'SyncState.synced(pendingCount: $pendingCount)';
}


}

/// @nodoc
abstract mixin class $SyncSyncedCopyWith<$Res> implements $SyncStateCopyWith<$Res> {
  factory $SyncSyncedCopyWith(SyncSynced value, $Res Function(SyncSynced) _then) = _$SyncSyncedCopyWithImpl;
@useResult
$Res call({
 int pendingCount
});




}
/// @nodoc
class _$SyncSyncedCopyWithImpl<$Res>
    implements $SyncSyncedCopyWith<$Res> {
  _$SyncSyncedCopyWithImpl(this._self, this._then);

  final SyncSynced _self;
  final $Res Function(SyncSynced) _then;

/// Create a copy of SyncState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? pendingCount = null,}) {
  return _then(SyncSynced(
pendingCount: null == pendingCount ? _self.pendingCount : pendingCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
