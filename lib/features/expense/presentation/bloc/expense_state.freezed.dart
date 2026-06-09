// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'expense_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ExpenseState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExpenseState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ExpenseState()';
}


}

/// @nodoc
class $ExpenseStateCopyWith<$Res>  {
$ExpenseStateCopyWith(ExpenseState _, $Res Function(ExpenseState) __);
}


/// Adds pattern-matching-related methods to [ExpenseState].
extension ExpenseStatePatterns on ExpenseState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ExpenseInitial value)?  initial,TResult Function( ExpenseLoading value)?  loading,TResult Function( ExpenseLoaded value)?  loaded,TResult Function( ExpenseSaving value)?  saving,TResult Function( ExpenseSaved value)?  saved,TResult Function( ExpenseFailure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ExpenseInitial() when initial != null:
return initial(_that);case ExpenseLoading() when loading != null:
return loading(_that);case ExpenseLoaded() when loaded != null:
return loaded(_that);case ExpenseSaving() when saving != null:
return saving(_that);case ExpenseSaved() when saved != null:
return saved(_that);case ExpenseFailure() when failure != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ExpenseInitial value)  initial,required TResult Function( ExpenseLoading value)  loading,required TResult Function( ExpenseLoaded value)  loaded,required TResult Function( ExpenseSaving value)  saving,required TResult Function( ExpenseSaved value)  saved,required TResult Function( ExpenseFailure value)  failure,}){
final _that = this;
switch (_that) {
case ExpenseInitial():
return initial(_that);case ExpenseLoading():
return loading(_that);case ExpenseLoaded():
return loaded(_that);case ExpenseSaving():
return saving(_that);case ExpenseSaved():
return saved(_that);case ExpenseFailure():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ExpenseInitial value)?  initial,TResult? Function( ExpenseLoading value)?  loading,TResult? Function( ExpenseLoaded value)?  loaded,TResult? Function( ExpenseSaving value)?  saving,TResult? Function( ExpenseSaved value)?  saved,TResult? Function( ExpenseFailure value)?  failure,}){
final _that = this;
switch (_that) {
case ExpenseInitial() when initial != null:
return initial(_that);case ExpenseLoading() when loading != null:
return loading(_that);case ExpenseLoaded() when loaded != null:
return loaded(_that);case ExpenseSaving() when saving != null:
return saving(_that);case ExpenseSaved() when saved != null:
return saved(_that);case ExpenseFailure() when failure != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<ExpenseEntity> expenses,  String? filterType,  String? filterCategory)?  loaded,TResult Function()?  saving,TResult Function()?  saved,TResult Function( Failure failure)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ExpenseInitial() when initial != null:
return initial();case ExpenseLoading() when loading != null:
return loading();case ExpenseLoaded() when loaded != null:
return loaded(_that.expenses,_that.filterType,_that.filterCategory);case ExpenseSaving() when saving != null:
return saving();case ExpenseSaved() when saved != null:
return saved();case ExpenseFailure() when failure != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<ExpenseEntity> expenses,  String? filterType,  String? filterCategory)  loaded,required TResult Function()  saving,required TResult Function()  saved,required TResult Function( Failure failure)  failure,}) {final _that = this;
switch (_that) {
case ExpenseInitial():
return initial();case ExpenseLoading():
return loading();case ExpenseLoaded():
return loaded(_that.expenses,_that.filterType,_that.filterCategory);case ExpenseSaving():
return saving();case ExpenseSaved():
return saved();case ExpenseFailure():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<ExpenseEntity> expenses,  String? filterType,  String? filterCategory)?  loaded,TResult? Function()?  saving,TResult? Function()?  saved,TResult? Function( Failure failure)?  failure,}) {final _that = this;
switch (_that) {
case ExpenseInitial() when initial != null:
return initial();case ExpenseLoading() when loading != null:
return loading();case ExpenseLoaded() when loaded != null:
return loaded(_that.expenses,_that.filterType,_that.filterCategory);case ExpenseSaving() when saving != null:
return saving();case ExpenseSaved() when saved != null:
return saved();case ExpenseFailure() when failure != null:
return failure(_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class ExpenseInitial implements ExpenseState {
  const ExpenseInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExpenseInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ExpenseState.initial()';
}


}




/// @nodoc


class ExpenseLoading implements ExpenseState {
  const ExpenseLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExpenseLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ExpenseState.loading()';
}


}




/// @nodoc


class ExpenseLoaded implements ExpenseState {
  const ExpenseLoaded({required final  List<ExpenseEntity> expenses, this.filterType, this.filterCategory}): _expenses = expenses;
  

 final  List<ExpenseEntity> _expenses;
 List<ExpenseEntity> get expenses {
  if (_expenses is EqualUnmodifiableListView) return _expenses;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_expenses);
}

 final  String? filterType;
 final  String? filterCategory;

/// Create a copy of ExpenseState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExpenseLoadedCopyWith<ExpenseLoaded> get copyWith => _$ExpenseLoadedCopyWithImpl<ExpenseLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExpenseLoaded&&const DeepCollectionEquality().equals(other._expenses, _expenses)&&(identical(other.filterType, filterType) || other.filterType == filterType)&&(identical(other.filterCategory, filterCategory) || other.filterCategory == filterCategory));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_expenses),filterType,filterCategory);

@override
String toString() {
  return 'ExpenseState.loaded(expenses: $expenses, filterType: $filterType, filterCategory: $filterCategory)';
}


}

/// @nodoc
abstract mixin class $ExpenseLoadedCopyWith<$Res> implements $ExpenseStateCopyWith<$Res> {
  factory $ExpenseLoadedCopyWith(ExpenseLoaded value, $Res Function(ExpenseLoaded) _then) = _$ExpenseLoadedCopyWithImpl;
@useResult
$Res call({
 List<ExpenseEntity> expenses, String? filterType, String? filterCategory
});




}
/// @nodoc
class _$ExpenseLoadedCopyWithImpl<$Res>
    implements $ExpenseLoadedCopyWith<$Res> {
  _$ExpenseLoadedCopyWithImpl(this._self, this._then);

  final ExpenseLoaded _self;
  final $Res Function(ExpenseLoaded) _then;

/// Create a copy of ExpenseState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? expenses = null,Object? filterType = freezed,Object? filterCategory = freezed,}) {
  return _then(ExpenseLoaded(
expenses: null == expenses ? _self._expenses : expenses // ignore: cast_nullable_to_non_nullable
as List<ExpenseEntity>,filterType: freezed == filterType ? _self.filterType : filterType // ignore: cast_nullable_to_non_nullable
as String?,filterCategory: freezed == filterCategory ? _self.filterCategory : filterCategory // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class ExpenseSaving implements ExpenseState {
  const ExpenseSaving();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExpenseSaving);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ExpenseState.saving()';
}


}




/// @nodoc


class ExpenseSaved implements ExpenseState {
  const ExpenseSaved();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExpenseSaved);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ExpenseState.saved()';
}


}




/// @nodoc


class ExpenseFailure implements ExpenseState {
  const ExpenseFailure({required this.failure});
  

 final  Failure failure;

/// Create a copy of ExpenseState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExpenseFailureCopyWith<ExpenseFailure> get copyWith => _$ExpenseFailureCopyWithImpl<ExpenseFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExpenseFailure&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,failure);

@override
String toString() {
  return 'ExpenseState.failure(failure: $failure)';
}


}

/// @nodoc
abstract mixin class $ExpenseFailureCopyWith<$Res> implements $ExpenseStateCopyWith<$Res> {
  factory $ExpenseFailureCopyWith(ExpenseFailure value, $Res Function(ExpenseFailure) _then) = _$ExpenseFailureCopyWithImpl;
@useResult
$Res call({
 Failure failure
});


$FailureCopyWith<$Res> get failure;

}
/// @nodoc
class _$ExpenseFailureCopyWithImpl<$Res>
    implements $ExpenseFailureCopyWith<$Res> {
  _$ExpenseFailureCopyWithImpl(this._self, this._then);

  final ExpenseFailure _self;
  final $Res Function(ExpenseFailure) _then;

/// Create a copy of ExpenseState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? failure = null,}) {
  return _then(ExpenseFailure(
failure: null == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure,
  ));
}

/// Create a copy of ExpenseState
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
