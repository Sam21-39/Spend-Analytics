// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'biometric_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BiometricState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BiometricState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'BiometricState()';
}


}

/// @nodoc
class $BiometricStateCopyWith<$Res>  {
$BiometricStateCopyWith(BiometricState _, $Res Function(BiometricState) __);
}


/// Adds pattern-matching-related methods to [BiometricState].
extension BiometricStatePatterns on BiometricState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( BiometricUnlocked value)?  unlocked,TResult Function( BiometricLocked value)?  locked,TResult Function( BiometricUnlocking value)?  unlocking,TResult Function( BiometricError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case BiometricUnlocked() when unlocked != null:
return unlocked(_that);case BiometricLocked() when locked != null:
return locked(_that);case BiometricUnlocking() when unlocking != null:
return unlocking(_that);case BiometricError() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( BiometricUnlocked value)  unlocked,required TResult Function( BiometricLocked value)  locked,required TResult Function( BiometricUnlocking value)  unlocking,required TResult Function( BiometricError value)  error,}){
final _that = this;
switch (_that) {
case BiometricUnlocked():
return unlocked(_that);case BiometricLocked():
return locked(_that);case BiometricUnlocking():
return unlocking(_that);case BiometricError():
return error(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( BiometricUnlocked value)?  unlocked,TResult? Function( BiometricLocked value)?  locked,TResult? Function( BiometricUnlocking value)?  unlocking,TResult? Function( BiometricError value)?  error,}){
final _that = this;
switch (_that) {
case BiometricUnlocked() when unlocked != null:
return unlocked(_that);case BiometricLocked() when locked != null:
return locked(_that);case BiometricUnlocking() when unlocking != null:
return unlocking(_that);case BiometricError() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  unlocked,TResult Function()?  locked,TResult Function()?  unlocking,TResult Function( Failure failure)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case BiometricUnlocked() when unlocked != null:
return unlocked();case BiometricLocked() when locked != null:
return locked();case BiometricUnlocking() when unlocking != null:
return unlocking();case BiometricError() when error != null:
return error(_that.failure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  unlocked,required TResult Function()  locked,required TResult Function()  unlocking,required TResult Function( Failure failure)  error,}) {final _that = this;
switch (_that) {
case BiometricUnlocked():
return unlocked();case BiometricLocked():
return locked();case BiometricUnlocking():
return unlocking();case BiometricError():
return error(_that.failure);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  unlocked,TResult? Function()?  locked,TResult? Function()?  unlocking,TResult? Function( Failure failure)?  error,}) {final _that = this;
switch (_that) {
case BiometricUnlocked() when unlocked != null:
return unlocked();case BiometricLocked() when locked != null:
return locked();case BiometricUnlocking() when unlocking != null:
return unlocking();case BiometricError() when error != null:
return error(_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class BiometricUnlocked implements BiometricState {
  const BiometricUnlocked();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BiometricUnlocked);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'BiometricState.unlocked()';
}


}




/// @nodoc


class BiometricLocked implements BiometricState {
  const BiometricLocked();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BiometricLocked);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'BiometricState.locked()';
}


}




/// @nodoc


class BiometricUnlocking implements BiometricState {
  const BiometricUnlocking();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BiometricUnlocking);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'BiometricState.unlocking()';
}


}




/// @nodoc


class BiometricError implements BiometricState {
  const BiometricError({required this.failure});
  

 final  Failure failure;

/// Create a copy of BiometricState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BiometricErrorCopyWith<BiometricError> get copyWith => _$BiometricErrorCopyWithImpl<BiometricError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BiometricError&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,failure);

@override
String toString() {
  return 'BiometricState.error(failure: $failure)';
}


}

/// @nodoc
abstract mixin class $BiometricErrorCopyWith<$Res> implements $BiometricStateCopyWith<$Res> {
  factory $BiometricErrorCopyWith(BiometricError value, $Res Function(BiometricError) _then) = _$BiometricErrorCopyWithImpl;
@useResult
$Res call({
 Failure failure
});


$FailureCopyWith<$Res> get failure;

}
/// @nodoc
class _$BiometricErrorCopyWithImpl<$Res>
    implements $BiometricErrorCopyWith<$Res> {
  _$BiometricErrorCopyWithImpl(this._self, this._then);

  final BiometricError _self;
  final $Res Function(BiometricError) _then;

/// Create a copy of BiometricState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? failure = null,}) {
  return _then(BiometricError(
failure: null == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure,
  ));
}

/// Create a copy of BiometricState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FailureCopyWith<$Res> get failure {
  
  return $FailureCopyWith<$Res>(_self.failure, (value) {
    return _then(_self.copyWith(failure: value));
  });
}
}

// dart format on
