// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reports_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ReportsState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReportsState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ReportsState()';
}


}

/// @nodoc
class $ReportsStateCopyWith<$Res>  {
$ReportsStateCopyWith(ReportsState _, $Res Function(ReportsState) __);
}


/// Adds pattern-matching-related methods to [ReportsState].
extension ReportsStatePatterns on ReportsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ReportsInitial value)?  initial,TResult Function( ReportsLoading value)?  loading,TResult Function( ReportsLoaded value)?  loaded,TResult Function( ReportsExporting value)?  exporting,TResult Function( ReportsExported value)?  exported,TResult Function( ReportsFailure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ReportsInitial() when initial != null:
return initial(_that);case ReportsLoading() when loading != null:
return loading(_that);case ReportsLoaded() when loaded != null:
return loaded(_that);case ReportsExporting() when exporting != null:
return exporting(_that);case ReportsExported() when exported != null:
return exported(_that);case ReportsFailure() when failure != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ReportsInitial value)  initial,required TResult Function( ReportsLoading value)  loading,required TResult Function( ReportsLoaded value)  loaded,required TResult Function( ReportsExporting value)  exporting,required TResult Function( ReportsExported value)  exported,required TResult Function( ReportsFailure value)  failure,}){
final _that = this;
switch (_that) {
case ReportsInitial():
return initial(_that);case ReportsLoading():
return loading(_that);case ReportsLoaded():
return loaded(_that);case ReportsExporting():
return exporting(_that);case ReportsExported():
return exported(_that);case ReportsFailure():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ReportsInitial value)?  initial,TResult? Function( ReportsLoading value)?  loading,TResult? Function( ReportsLoaded value)?  loaded,TResult? Function( ReportsExporting value)?  exporting,TResult? Function( ReportsExported value)?  exported,TResult? Function( ReportsFailure value)?  failure,}){
final _that = this;
switch (_that) {
case ReportsInitial() when initial != null:
return initial(_that);case ReportsLoading() when loading != null:
return loading(_that);case ReportsLoaded() when loaded != null:
return loaded(_that);case ReportsExporting() when exporting != null:
return exporting(_that);case ReportsExported() when exported != null:
return exported(_that);case ReportsFailure() when failure != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<ExpenseEntity> allExpenses,  String selectedRange,  ReportsData data)?  loaded,TResult Function()?  exporting,TResult Function()?  exported,TResult Function( Failure failure)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ReportsInitial() when initial != null:
return initial();case ReportsLoading() when loading != null:
return loading();case ReportsLoaded() when loaded != null:
return loaded(_that.allExpenses,_that.selectedRange,_that.data);case ReportsExporting() when exporting != null:
return exporting();case ReportsExported() when exported != null:
return exported();case ReportsFailure() when failure != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<ExpenseEntity> allExpenses,  String selectedRange,  ReportsData data)  loaded,required TResult Function()  exporting,required TResult Function()  exported,required TResult Function( Failure failure)  failure,}) {final _that = this;
switch (_that) {
case ReportsInitial():
return initial();case ReportsLoading():
return loading();case ReportsLoaded():
return loaded(_that.allExpenses,_that.selectedRange,_that.data);case ReportsExporting():
return exporting();case ReportsExported():
return exported();case ReportsFailure():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<ExpenseEntity> allExpenses,  String selectedRange,  ReportsData data)?  loaded,TResult? Function()?  exporting,TResult? Function()?  exported,TResult? Function( Failure failure)?  failure,}) {final _that = this;
switch (_that) {
case ReportsInitial() when initial != null:
return initial();case ReportsLoading() when loading != null:
return loading();case ReportsLoaded() when loaded != null:
return loaded(_that.allExpenses,_that.selectedRange,_that.data);case ReportsExporting() when exporting != null:
return exporting();case ReportsExported() when exported != null:
return exported();case ReportsFailure() when failure != null:
return failure(_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class ReportsInitial implements ReportsState {
  const ReportsInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReportsInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ReportsState.initial()';
}


}




/// @nodoc


class ReportsLoading implements ReportsState {
  const ReportsLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReportsLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ReportsState.loading()';
}


}




/// @nodoc


class ReportsLoaded implements ReportsState {
  const ReportsLoaded({required final  List<ExpenseEntity> allExpenses, required this.selectedRange, required this.data}): _allExpenses = allExpenses;
  

 final  List<ExpenseEntity> _allExpenses;
 List<ExpenseEntity> get allExpenses {
  if (_allExpenses is EqualUnmodifiableListView) return _allExpenses;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_allExpenses);
}

 final  String selectedRange;
 final  ReportsData data;

/// Create a copy of ReportsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReportsLoadedCopyWith<ReportsLoaded> get copyWith => _$ReportsLoadedCopyWithImpl<ReportsLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReportsLoaded&&const DeepCollectionEquality().equals(other._allExpenses, _allExpenses)&&(identical(other.selectedRange, selectedRange) || other.selectedRange == selectedRange)&&(identical(other.data, data) || other.data == data));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_allExpenses),selectedRange,data);

@override
String toString() {
  return 'ReportsState.loaded(allExpenses: $allExpenses, selectedRange: $selectedRange, data: $data)';
}


}

/// @nodoc
abstract mixin class $ReportsLoadedCopyWith<$Res> implements $ReportsStateCopyWith<$Res> {
  factory $ReportsLoadedCopyWith(ReportsLoaded value, $Res Function(ReportsLoaded) _then) = _$ReportsLoadedCopyWithImpl;
@useResult
$Res call({
 List<ExpenseEntity> allExpenses, String selectedRange, ReportsData data
});




}
/// @nodoc
class _$ReportsLoadedCopyWithImpl<$Res>
    implements $ReportsLoadedCopyWith<$Res> {
  _$ReportsLoadedCopyWithImpl(this._self, this._then);

  final ReportsLoaded _self;
  final $Res Function(ReportsLoaded) _then;

/// Create a copy of ReportsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? allExpenses = null,Object? selectedRange = null,Object? data = null,}) {
  return _then(ReportsLoaded(
allExpenses: null == allExpenses ? _self._allExpenses : allExpenses // ignore: cast_nullable_to_non_nullable
as List<ExpenseEntity>,selectedRange: null == selectedRange ? _self.selectedRange : selectedRange // ignore: cast_nullable_to_non_nullable
as String,data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as ReportsData,
  ));
}


}

/// @nodoc


class ReportsExporting implements ReportsState {
  const ReportsExporting();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReportsExporting);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ReportsState.exporting()';
}


}




/// @nodoc


class ReportsExported implements ReportsState {
  const ReportsExported();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReportsExported);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ReportsState.exported()';
}


}




/// @nodoc


class ReportsFailure implements ReportsState {
  const ReportsFailure({required this.failure});
  

 final  Failure failure;

/// Create a copy of ReportsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReportsFailureCopyWith<ReportsFailure> get copyWith => _$ReportsFailureCopyWithImpl<ReportsFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReportsFailure&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,failure);

@override
String toString() {
  return 'ReportsState.failure(failure: $failure)';
}


}

/// @nodoc
abstract mixin class $ReportsFailureCopyWith<$Res> implements $ReportsStateCopyWith<$Res> {
  factory $ReportsFailureCopyWith(ReportsFailure value, $Res Function(ReportsFailure) _then) = _$ReportsFailureCopyWithImpl;
@useResult
$Res call({
 Failure failure
});


$FailureCopyWith<$Res> get failure;

}
/// @nodoc
class _$ReportsFailureCopyWithImpl<$Res>
    implements $ReportsFailureCopyWith<$Res> {
  _$ReportsFailureCopyWithImpl(this._self, this._then);

  final ReportsFailure _self;
  final $Res Function(ReportsFailure) _then;

/// Create a copy of ReportsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? failure = null,}) {
  return _then(ReportsFailure(
failure: null == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure,
  ));
}

/// Create a copy of ReportsState
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
