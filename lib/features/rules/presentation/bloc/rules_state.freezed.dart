// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'rules_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RulesState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RulesState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RulesState()';
}


}

/// @nodoc
class $RulesStateCopyWith<$Res>  {
$RulesStateCopyWith(RulesState _, $Res Function(RulesState) __);
}


/// Adds pattern-matching-related methods to [RulesState].
extension RulesStatePatterns on RulesState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( RulesInitial value)?  initial,TResult Function( RulesLoading value)?  loading,TResult Function( RulesLoaded value)?  loaded,TResult Function( RulesSaving value)?  saving,TResult Function( RulesFailure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case RulesInitial() when initial != null:
return initial(_that);case RulesLoading() when loading != null:
return loading(_that);case RulesLoaded() when loaded != null:
return loaded(_that);case RulesSaving() when saving != null:
return saving(_that);case RulesFailure() when failure != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( RulesInitial value)  initial,required TResult Function( RulesLoading value)  loading,required TResult Function( RulesLoaded value)  loaded,required TResult Function( RulesSaving value)  saving,required TResult Function( RulesFailure value)  failure,}){
final _that = this;
switch (_that) {
case RulesInitial():
return initial(_that);case RulesLoading():
return loading(_that);case RulesLoaded():
return loaded(_that);case RulesSaving():
return saving(_that);case RulesFailure():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( RulesInitial value)?  initial,TResult? Function( RulesLoading value)?  loading,TResult? Function( RulesLoaded value)?  loaded,TResult? Function( RulesSaving value)?  saving,TResult? Function( RulesFailure value)?  failure,}){
final _that = this;
switch (_that) {
case RulesInitial() when initial != null:
return initial(_that);case RulesLoading() when loading != null:
return loading(_that);case RulesLoaded() when loaded != null:
return loaded(_that);case RulesSaving() when saving != null:
return saving(_that);case RulesFailure() when failure != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<RuleEntity> rules)?  loaded,TResult Function()?  saving,TResult Function( Failure failure)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case RulesInitial() when initial != null:
return initial();case RulesLoading() when loading != null:
return loading();case RulesLoaded() when loaded != null:
return loaded(_that.rules);case RulesSaving() when saving != null:
return saving();case RulesFailure() when failure != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<RuleEntity> rules)  loaded,required TResult Function()  saving,required TResult Function( Failure failure)  failure,}) {final _that = this;
switch (_that) {
case RulesInitial():
return initial();case RulesLoading():
return loading();case RulesLoaded():
return loaded(_that.rules);case RulesSaving():
return saving();case RulesFailure():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<RuleEntity> rules)?  loaded,TResult? Function()?  saving,TResult? Function( Failure failure)?  failure,}) {final _that = this;
switch (_that) {
case RulesInitial() when initial != null:
return initial();case RulesLoading() when loading != null:
return loading();case RulesLoaded() when loaded != null:
return loaded(_that.rules);case RulesSaving() when saving != null:
return saving();case RulesFailure() when failure != null:
return failure(_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class RulesInitial implements RulesState {
  const RulesInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RulesInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RulesState.initial()';
}


}




/// @nodoc


class RulesLoading implements RulesState {
  const RulesLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RulesLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RulesState.loading()';
}


}




/// @nodoc


class RulesLoaded implements RulesState {
  const RulesLoaded({required final  List<RuleEntity> rules}): _rules = rules;
  

 final  List<RuleEntity> _rules;
 List<RuleEntity> get rules {
  if (_rules is EqualUnmodifiableListView) return _rules;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_rules);
}


/// Create a copy of RulesState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RulesLoadedCopyWith<RulesLoaded> get copyWith => _$RulesLoadedCopyWithImpl<RulesLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RulesLoaded&&const DeepCollectionEquality().equals(other._rules, _rules));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_rules));

@override
String toString() {
  return 'RulesState.loaded(rules: $rules)';
}


}

/// @nodoc
abstract mixin class $RulesLoadedCopyWith<$Res> implements $RulesStateCopyWith<$Res> {
  factory $RulesLoadedCopyWith(RulesLoaded value, $Res Function(RulesLoaded) _then) = _$RulesLoadedCopyWithImpl;
@useResult
$Res call({
 List<RuleEntity> rules
});




}
/// @nodoc
class _$RulesLoadedCopyWithImpl<$Res>
    implements $RulesLoadedCopyWith<$Res> {
  _$RulesLoadedCopyWithImpl(this._self, this._then);

  final RulesLoaded _self;
  final $Res Function(RulesLoaded) _then;

/// Create a copy of RulesState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? rules = null,}) {
  return _then(RulesLoaded(
rules: null == rules ? _self._rules : rules // ignore: cast_nullable_to_non_nullable
as List<RuleEntity>,
  ));
}


}

/// @nodoc


class RulesSaving implements RulesState {
  const RulesSaving();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RulesSaving);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RulesState.saving()';
}


}




/// @nodoc


class RulesFailure implements RulesState {
  const RulesFailure({required this.failure});
  

 final  Failure failure;

/// Create a copy of RulesState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RulesFailureCopyWith<RulesFailure> get copyWith => _$RulesFailureCopyWithImpl<RulesFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RulesFailure&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,failure);

@override
String toString() {
  return 'RulesState.failure(failure: $failure)';
}


}

/// @nodoc
abstract mixin class $RulesFailureCopyWith<$Res> implements $RulesStateCopyWith<$Res> {
  factory $RulesFailureCopyWith(RulesFailure value, $Res Function(RulesFailure) _then) = _$RulesFailureCopyWithImpl;
@useResult
$Res call({
 Failure failure
});


$FailureCopyWith<$Res> get failure;

}
/// @nodoc
class _$RulesFailureCopyWithImpl<$Res>
    implements $RulesFailureCopyWith<$Res> {
  _$RulesFailureCopyWithImpl(this._self, this._then);

  final RulesFailure _self;
  final $Res Function(RulesFailure) _then;

/// Create a copy of RulesState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? failure = null,}) {
  return _then(RulesFailure(
failure: null == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure,
  ));
}

/// Create a copy of RulesState
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
