// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'budget_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BudgetState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BudgetState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'BudgetState()';
}


}

/// @nodoc
class $BudgetStateCopyWith<$Res>  {
$BudgetStateCopyWith(BudgetState _, $Res Function(BudgetState) __);
}


/// Adds pattern-matching-related methods to [BudgetState].
extension BudgetStatePatterns on BudgetState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( BudgetInitial value)?  initial,TResult Function( BudgetLoading value)?  loading,TResult Function( BudgetLoaded value)?  loaded,TResult Function( BudgetFailure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case BudgetInitial() when initial != null:
return initial(_that);case BudgetLoading() when loading != null:
return loading(_that);case BudgetLoaded() when loaded != null:
return loaded(_that);case BudgetFailure() when failure != null:
return failure(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( BudgetInitial value)  initial,required TResult Function( BudgetLoading value)  loading,required TResult Function( BudgetLoaded value)  loaded,required TResult Function( BudgetFailure value)  failure,}){
final _that = this;
switch (_that) {
case BudgetInitial():
return initial(_that);case BudgetLoading():
return loading(_that);case BudgetLoaded():
return loaded(_that);case BudgetFailure():
return failure(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( BudgetInitial value)?  initial,TResult? Function( BudgetLoading value)?  loading,TResult? Function( BudgetLoaded value)?  loaded,TResult? Function( BudgetFailure value)?  failure,}){
final _that = this;
switch (_that) {
case BudgetInitial() when initial != null:
return initial(_that);case BudgetLoading() when loading != null:
return loading(_that);case BudgetLoaded() when loaded != null:
return loaded(_that);case BudgetFailure() when failure != null:
return failure(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<BudgetProgress> progresses)?  loaded,TResult Function( Failure failure)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case BudgetInitial() when initial != null:
return initial();case BudgetLoading() when loading != null:
return loading();case BudgetLoaded() when loaded != null:
return loaded(_that.progresses);case BudgetFailure() when failure != null:
return failure(_that.failure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<BudgetProgress> progresses)  loaded,required TResult Function( Failure failure)  failure,}) {final _that = this;
switch (_that) {
case BudgetInitial():
return initial();case BudgetLoading():
return loading();case BudgetLoaded():
return loaded(_that.progresses);case BudgetFailure():
return failure(_that.failure);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<BudgetProgress> progresses)?  loaded,TResult? Function( Failure failure)?  failure,}) {final _that = this;
switch (_that) {
case BudgetInitial() when initial != null:
return initial();case BudgetLoading() when loading != null:
return loading();case BudgetLoaded() when loaded != null:
return loaded(_that.progresses);case BudgetFailure() when failure != null:
return failure(_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class BudgetInitial implements BudgetState {
  const BudgetInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BudgetInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'BudgetState.initial()';
}


}




/// @nodoc


class BudgetLoading implements BudgetState {
  const BudgetLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BudgetLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'BudgetState.loading()';
}


}




/// @nodoc


class BudgetLoaded implements BudgetState {
  const BudgetLoaded({required final  List<BudgetProgress> progresses}): _progresses = progresses;
  

 final  List<BudgetProgress> _progresses;
 List<BudgetProgress> get progresses {
  if (_progresses is EqualUnmodifiableListView) return _progresses;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_progresses);
}


/// Create a copy of BudgetState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BudgetLoadedCopyWith<BudgetLoaded> get copyWith => _$BudgetLoadedCopyWithImpl<BudgetLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BudgetLoaded&&const DeepCollectionEquality().equals(other._progresses, _progresses));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_progresses));

@override
String toString() {
  return 'BudgetState.loaded(progresses: $progresses)';
}


}

/// @nodoc
abstract mixin class $BudgetLoadedCopyWith<$Res> implements $BudgetStateCopyWith<$Res> {
  factory $BudgetLoadedCopyWith(BudgetLoaded value, $Res Function(BudgetLoaded) _then) = _$BudgetLoadedCopyWithImpl;
@useResult
$Res call({
 List<BudgetProgress> progresses
});




}
/// @nodoc
class _$BudgetLoadedCopyWithImpl<$Res>
    implements $BudgetLoadedCopyWith<$Res> {
  _$BudgetLoadedCopyWithImpl(this._self, this._then);

  final BudgetLoaded _self;
  final $Res Function(BudgetLoaded) _then;

/// Create a copy of BudgetState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? progresses = null,}) {
  return _then(BudgetLoaded(
progresses: null == progresses ? _self._progresses : progresses // ignore: cast_nullable_to_non_nullable
as List<BudgetProgress>,
  ));
}


}

/// @nodoc


class BudgetFailure implements BudgetState {
  const BudgetFailure({required this.failure});
  

 final  Failure failure;

/// Create a copy of BudgetState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BudgetFailureCopyWith<BudgetFailure> get copyWith => _$BudgetFailureCopyWithImpl<BudgetFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BudgetFailure&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,failure);

@override
String toString() {
  return 'BudgetState.failure(failure: $failure)';
}


}

/// @nodoc
abstract mixin class $BudgetFailureCopyWith<$Res> implements $BudgetStateCopyWith<$Res> {
  factory $BudgetFailureCopyWith(BudgetFailure value, $Res Function(BudgetFailure) _then) = _$BudgetFailureCopyWithImpl;
@useResult
$Res call({
 Failure failure
});


$FailureCopyWith<$Res> get failure;

}
/// @nodoc
class _$BudgetFailureCopyWithImpl<$Res>
    implements $BudgetFailureCopyWith<$Res> {
  _$BudgetFailureCopyWithImpl(this._self, this._then);

  final BudgetFailure _self;
  final $Res Function(BudgetFailure) _then;

/// Create a copy of BudgetState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? failure = null,}) {
  return _then(BudgetFailure(
failure: null == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure,
  ));
}

/// Create a copy of BudgetState
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
