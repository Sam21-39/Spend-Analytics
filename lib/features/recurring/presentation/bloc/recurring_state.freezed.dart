// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recurring_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RecurringState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RecurringState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RecurringState()';
}


}

/// @nodoc
class $RecurringStateCopyWith<$Res>  {
$RecurringStateCopyWith(RecurringState _, $Res Function(RecurringState) __);
}


/// Adds pattern-matching-related methods to [RecurringState].
extension RecurringStatePatterns on RecurringState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( RecurringInitial value)?  initial,TResult Function( RecurringLoading value)?  loading,TResult Function( RecurringLoaded value)?  loaded,TResult Function( RecurringSaving value)?  saving,TResult Function( RecurringFailure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case RecurringInitial() when initial != null:
return initial(_that);case RecurringLoading() when loading != null:
return loading(_that);case RecurringLoaded() when loaded != null:
return loaded(_that);case RecurringSaving() when saving != null:
return saving(_that);case RecurringFailure() when failure != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( RecurringInitial value)  initial,required TResult Function( RecurringLoading value)  loading,required TResult Function( RecurringLoaded value)  loaded,required TResult Function( RecurringSaving value)  saving,required TResult Function( RecurringFailure value)  failure,}){
final _that = this;
switch (_that) {
case RecurringInitial():
return initial(_that);case RecurringLoading():
return loading(_that);case RecurringLoaded():
return loaded(_that);case RecurringSaving():
return saving(_that);case RecurringFailure():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( RecurringInitial value)?  initial,TResult? Function( RecurringLoading value)?  loading,TResult? Function( RecurringLoaded value)?  loaded,TResult? Function( RecurringSaving value)?  saving,TResult? Function( RecurringFailure value)?  failure,}){
final _that = this;
switch (_that) {
case RecurringInitial() when initial != null:
return initial(_that);case RecurringLoading() when loading != null:
return loading(_that);case RecurringLoaded() when loaded != null:
return loaded(_that);case RecurringSaving() when saving != null:
return saving(_that);case RecurringFailure() when failure != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<RecurringEntity> items)?  loaded,TResult Function()?  saving,TResult Function( Failure failure)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case RecurringInitial() when initial != null:
return initial();case RecurringLoading() when loading != null:
return loading();case RecurringLoaded() when loaded != null:
return loaded(_that.items);case RecurringSaving() when saving != null:
return saving();case RecurringFailure() when failure != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<RecurringEntity> items)  loaded,required TResult Function()  saving,required TResult Function( Failure failure)  failure,}) {final _that = this;
switch (_that) {
case RecurringInitial():
return initial();case RecurringLoading():
return loading();case RecurringLoaded():
return loaded(_that.items);case RecurringSaving():
return saving();case RecurringFailure():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<RecurringEntity> items)?  loaded,TResult? Function()?  saving,TResult? Function( Failure failure)?  failure,}) {final _that = this;
switch (_that) {
case RecurringInitial() when initial != null:
return initial();case RecurringLoading() when loading != null:
return loading();case RecurringLoaded() when loaded != null:
return loaded(_that.items);case RecurringSaving() when saving != null:
return saving();case RecurringFailure() when failure != null:
return failure(_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class RecurringInitial implements RecurringState {
  const RecurringInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RecurringInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RecurringState.initial()';
}


}




/// @nodoc


class RecurringLoading implements RecurringState {
  const RecurringLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RecurringLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RecurringState.loading()';
}


}




/// @nodoc


class RecurringLoaded implements RecurringState {
  const RecurringLoaded({required final  List<RecurringEntity> items}): _items = items;
  

 final  List<RecurringEntity> _items;
 List<RecurringEntity> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}


/// Create a copy of RecurringState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RecurringLoadedCopyWith<RecurringLoaded> get copyWith => _$RecurringLoadedCopyWithImpl<RecurringLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RecurringLoaded&&const DeepCollectionEquality().equals(other._items, _items));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_items));

@override
String toString() {
  return 'RecurringState.loaded(items: $items)';
}


}

/// @nodoc
abstract mixin class $RecurringLoadedCopyWith<$Res> implements $RecurringStateCopyWith<$Res> {
  factory $RecurringLoadedCopyWith(RecurringLoaded value, $Res Function(RecurringLoaded) _then) = _$RecurringLoadedCopyWithImpl;
@useResult
$Res call({
 List<RecurringEntity> items
});




}
/// @nodoc
class _$RecurringLoadedCopyWithImpl<$Res>
    implements $RecurringLoadedCopyWith<$Res> {
  _$RecurringLoadedCopyWithImpl(this._self, this._then);

  final RecurringLoaded _self;
  final $Res Function(RecurringLoaded) _then;

/// Create a copy of RecurringState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? items = null,}) {
  return _then(RecurringLoaded(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<RecurringEntity>,
  ));
}


}

/// @nodoc


class RecurringSaving implements RecurringState {
  const RecurringSaving();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RecurringSaving);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RecurringState.saving()';
}


}




/// @nodoc


class RecurringFailure implements RecurringState {
  const RecurringFailure({required this.failure});
  

 final  Failure failure;

/// Create a copy of RecurringState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RecurringFailureCopyWith<RecurringFailure> get copyWith => _$RecurringFailureCopyWithImpl<RecurringFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RecurringFailure&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,failure);

@override
String toString() {
  return 'RecurringState.failure(failure: $failure)';
}


}

/// @nodoc
abstract mixin class $RecurringFailureCopyWith<$Res> implements $RecurringStateCopyWith<$Res> {
  factory $RecurringFailureCopyWith(RecurringFailure value, $Res Function(RecurringFailure) _then) = _$RecurringFailureCopyWithImpl;
@useResult
$Res call({
 Failure failure
});


$FailureCopyWith<$Res> get failure;

}
/// @nodoc
class _$RecurringFailureCopyWithImpl<$Res>
    implements $RecurringFailureCopyWith<$Res> {
  _$RecurringFailureCopyWithImpl(this._self, this._then);

  final RecurringFailure _self;
  final $Res Function(RecurringFailure) _then;

/// Create a copy of RecurringState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? failure = null,}) {
  return _then(RecurringFailure(
failure: null == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure,
  ));
}

/// Create a copy of RecurringState
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
