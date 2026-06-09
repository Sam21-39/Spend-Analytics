// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'category_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CategoryState {

 List<CategoryEntity> get expense; List<CategoryEntity> get income; List<CategoryEntity> get transfer; bool get isLoading;
/// Create a copy of CategoryState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CategoryStateCopyWith<CategoryState> get copyWith => _$CategoryStateCopyWithImpl<CategoryState>(this as CategoryState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CategoryState&&const DeepCollectionEquality().equals(other.expense, expense)&&const DeepCollectionEquality().equals(other.income, income)&&const DeepCollectionEquality().equals(other.transfer, transfer)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(expense),const DeepCollectionEquality().hash(income),const DeepCollectionEquality().hash(transfer),isLoading);

@override
String toString() {
  return 'CategoryState(expense: $expense, income: $income, transfer: $transfer, isLoading: $isLoading)';
}


}

/// @nodoc
abstract mixin class $CategoryStateCopyWith<$Res>  {
  factory $CategoryStateCopyWith(CategoryState value, $Res Function(CategoryState) _then) = _$CategoryStateCopyWithImpl;
@useResult
$Res call({
 List<CategoryEntity> expense, List<CategoryEntity> income, List<CategoryEntity> transfer, bool isLoading
});




}
/// @nodoc
class _$CategoryStateCopyWithImpl<$Res>
    implements $CategoryStateCopyWith<$Res> {
  _$CategoryStateCopyWithImpl(this._self, this._then);

  final CategoryState _self;
  final $Res Function(CategoryState) _then;

/// Create a copy of CategoryState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? expense = null,Object? income = null,Object? transfer = null,Object? isLoading = null,}) {
  return _then(_self.copyWith(
expense: null == expense ? _self.expense : expense // ignore: cast_nullable_to_non_nullable
as List<CategoryEntity>,income: null == income ? _self.income : income // ignore: cast_nullable_to_non_nullable
as List<CategoryEntity>,transfer: null == transfer ? _self.transfer : transfer // ignore: cast_nullable_to_non_nullable
as List<CategoryEntity>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [CategoryState].
extension CategoryStatePatterns on CategoryState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CategoryState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CategoryState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CategoryState value)  $default,){
final _that = this;
switch (_that) {
case _CategoryState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CategoryState value)?  $default,){
final _that = this;
switch (_that) {
case _CategoryState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<CategoryEntity> expense,  List<CategoryEntity> income,  List<CategoryEntity> transfer,  bool isLoading)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CategoryState() when $default != null:
return $default(_that.expense,_that.income,_that.transfer,_that.isLoading);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<CategoryEntity> expense,  List<CategoryEntity> income,  List<CategoryEntity> transfer,  bool isLoading)  $default,) {final _that = this;
switch (_that) {
case _CategoryState():
return $default(_that.expense,_that.income,_that.transfer,_that.isLoading);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<CategoryEntity> expense,  List<CategoryEntity> income,  List<CategoryEntity> transfer,  bool isLoading)?  $default,) {final _that = this;
switch (_that) {
case _CategoryState() when $default != null:
return $default(_that.expense,_that.income,_that.transfer,_that.isLoading);case _:
  return null;

}
}

}

/// @nodoc


class _CategoryState implements CategoryState {
  const _CategoryState({final  List<CategoryEntity> expense = const [], final  List<CategoryEntity> income = const [], final  List<CategoryEntity> transfer = const [], this.isLoading = false}): _expense = expense,_income = income,_transfer = transfer;
  

 final  List<CategoryEntity> _expense;
@override@JsonKey() List<CategoryEntity> get expense {
  if (_expense is EqualUnmodifiableListView) return _expense;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_expense);
}

 final  List<CategoryEntity> _income;
@override@JsonKey() List<CategoryEntity> get income {
  if (_income is EqualUnmodifiableListView) return _income;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_income);
}

 final  List<CategoryEntity> _transfer;
@override@JsonKey() List<CategoryEntity> get transfer {
  if (_transfer is EqualUnmodifiableListView) return _transfer;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_transfer);
}

@override@JsonKey() final  bool isLoading;

/// Create a copy of CategoryState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CategoryStateCopyWith<_CategoryState> get copyWith => __$CategoryStateCopyWithImpl<_CategoryState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CategoryState&&const DeepCollectionEquality().equals(other._expense, _expense)&&const DeepCollectionEquality().equals(other._income, _income)&&const DeepCollectionEquality().equals(other._transfer, _transfer)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_expense),const DeepCollectionEquality().hash(_income),const DeepCollectionEquality().hash(_transfer),isLoading);

@override
String toString() {
  return 'CategoryState(expense: $expense, income: $income, transfer: $transfer, isLoading: $isLoading)';
}


}

/// @nodoc
abstract mixin class _$CategoryStateCopyWith<$Res> implements $CategoryStateCopyWith<$Res> {
  factory _$CategoryStateCopyWith(_CategoryState value, $Res Function(_CategoryState) _then) = __$CategoryStateCopyWithImpl;
@override @useResult
$Res call({
 List<CategoryEntity> expense, List<CategoryEntity> income, List<CategoryEntity> transfer, bool isLoading
});




}
/// @nodoc
class __$CategoryStateCopyWithImpl<$Res>
    implements _$CategoryStateCopyWith<$Res> {
  __$CategoryStateCopyWithImpl(this._self, this._then);

  final _CategoryState _self;
  final $Res Function(_CategoryState) _then;

/// Create a copy of CategoryState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? expense = null,Object? income = null,Object? transfer = null,Object? isLoading = null,}) {
  return _then(_CategoryState(
expense: null == expense ? _self._expense : expense // ignore: cast_nullable_to_non_nullable
as List<CategoryEntity>,income: null == income ? _self._income : income // ignore: cast_nullable_to_non_nullable
as List<CategoryEntity>,transfer: null == transfer ? _self._transfer : transfer // ignore: cast_nullable_to_non_nullable
as List<CategoryEntity>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
