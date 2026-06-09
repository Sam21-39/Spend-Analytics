// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'rules_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RulesEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RulesEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RulesEvent()';
}


}

/// @nodoc
class $RulesEventCopyWith<$Res>  {
$RulesEventCopyWith(RulesEvent _, $Res Function(RulesEvent) __);
}


/// Adds pattern-matching-related methods to [RulesEvent].
extension RulesEventPatterns on RulesEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( RulesLoad value)?  load,TResult Function( RulesCreate value)?  create,TResult Function( RulesUpdate value)?  update,TResult Function( RulesDelete value)?  delete,TResult Function( RulesToggle value)?  toggle,TResult Function( RulesEvaluate value)?  evaluate,required TResult orElse(),}){
final _that = this;
switch (_that) {
case RulesLoad() when load != null:
return load(_that);case RulesCreate() when create != null:
return create(_that);case RulesUpdate() when update != null:
return update(_that);case RulesDelete() when delete != null:
return delete(_that);case RulesToggle() when toggle != null:
return toggle(_that);case RulesEvaluate() when evaluate != null:
return evaluate(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( RulesLoad value)  load,required TResult Function( RulesCreate value)  create,required TResult Function( RulesUpdate value)  update,required TResult Function( RulesDelete value)  delete,required TResult Function( RulesToggle value)  toggle,required TResult Function( RulesEvaluate value)  evaluate,}){
final _that = this;
switch (_that) {
case RulesLoad():
return load(_that);case RulesCreate():
return create(_that);case RulesUpdate():
return update(_that);case RulesDelete():
return delete(_that);case RulesToggle():
return toggle(_that);case RulesEvaluate():
return evaluate(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( RulesLoad value)?  load,TResult? Function( RulesCreate value)?  create,TResult? Function( RulesUpdate value)?  update,TResult? Function( RulesDelete value)?  delete,TResult? Function( RulesToggle value)?  toggle,TResult? Function( RulesEvaluate value)?  evaluate,}){
final _that = this;
switch (_that) {
case RulesLoad() when load != null:
return load(_that);case RulesCreate() when create != null:
return create(_that);case RulesUpdate() when update != null:
return update(_that);case RulesDelete() when delete != null:
return delete(_that);case RulesToggle() when toggle != null:
return toggle(_that);case RulesEvaluate() when evaluate != null:
return evaluate(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String userId)?  load,TResult Function( RuleEntity rule)?  create,TResult Function( RuleEntity rule)?  update,TResult Function( String id,  String userId)?  delete,TResult Function( String id,  bool isActive,  String userId)?  toggle,TResult Function( ExpenseEntity expense)?  evaluate,required TResult orElse(),}) {final _that = this;
switch (_that) {
case RulesLoad() when load != null:
return load(_that.userId);case RulesCreate() when create != null:
return create(_that.rule);case RulesUpdate() when update != null:
return update(_that.rule);case RulesDelete() when delete != null:
return delete(_that.id,_that.userId);case RulesToggle() when toggle != null:
return toggle(_that.id,_that.isActive,_that.userId);case RulesEvaluate() when evaluate != null:
return evaluate(_that.expense);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String userId)  load,required TResult Function( RuleEntity rule)  create,required TResult Function( RuleEntity rule)  update,required TResult Function( String id,  String userId)  delete,required TResult Function( String id,  bool isActive,  String userId)  toggle,required TResult Function( ExpenseEntity expense)  evaluate,}) {final _that = this;
switch (_that) {
case RulesLoad():
return load(_that.userId);case RulesCreate():
return create(_that.rule);case RulesUpdate():
return update(_that.rule);case RulesDelete():
return delete(_that.id,_that.userId);case RulesToggle():
return toggle(_that.id,_that.isActive,_that.userId);case RulesEvaluate():
return evaluate(_that.expense);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String userId)?  load,TResult? Function( RuleEntity rule)?  create,TResult? Function( RuleEntity rule)?  update,TResult? Function( String id,  String userId)?  delete,TResult? Function( String id,  bool isActive,  String userId)?  toggle,TResult? Function( ExpenseEntity expense)?  evaluate,}) {final _that = this;
switch (_that) {
case RulesLoad() when load != null:
return load(_that.userId);case RulesCreate() when create != null:
return create(_that.rule);case RulesUpdate() when update != null:
return update(_that.rule);case RulesDelete() when delete != null:
return delete(_that.id,_that.userId);case RulesToggle() when toggle != null:
return toggle(_that.id,_that.isActive,_that.userId);case RulesEvaluate() when evaluate != null:
return evaluate(_that.expense);case _:
  return null;

}
}

}

/// @nodoc


class RulesLoad implements RulesEvent {
  const RulesLoad({required this.userId});
  

 final  String userId;

/// Create a copy of RulesEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RulesLoadCopyWith<RulesLoad> get copyWith => _$RulesLoadCopyWithImpl<RulesLoad>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RulesLoad&&(identical(other.userId, userId) || other.userId == userId));
}


@override
int get hashCode => Object.hash(runtimeType,userId);

@override
String toString() {
  return 'RulesEvent.load(userId: $userId)';
}


}

/// @nodoc
abstract mixin class $RulesLoadCopyWith<$Res> implements $RulesEventCopyWith<$Res> {
  factory $RulesLoadCopyWith(RulesLoad value, $Res Function(RulesLoad) _then) = _$RulesLoadCopyWithImpl;
@useResult
$Res call({
 String userId
});




}
/// @nodoc
class _$RulesLoadCopyWithImpl<$Res>
    implements $RulesLoadCopyWith<$Res> {
  _$RulesLoadCopyWithImpl(this._self, this._then);

  final RulesLoad _self;
  final $Res Function(RulesLoad) _then;

/// Create a copy of RulesEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? userId = null,}) {
  return _then(RulesLoad(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class RulesCreate implements RulesEvent {
  const RulesCreate({required this.rule});
  

 final  RuleEntity rule;

/// Create a copy of RulesEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RulesCreateCopyWith<RulesCreate> get copyWith => _$RulesCreateCopyWithImpl<RulesCreate>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RulesCreate&&(identical(other.rule, rule) || other.rule == rule));
}


@override
int get hashCode => Object.hash(runtimeType,rule);

@override
String toString() {
  return 'RulesEvent.create(rule: $rule)';
}


}

/// @nodoc
abstract mixin class $RulesCreateCopyWith<$Res> implements $RulesEventCopyWith<$Res> {
  factory $RulesCreateCopyWith(RulesCreate value, $Res Function(RulesCreate) _then) = _$RulesCreateCopyWithImpl;
@useResult
$Res call({
 RuleEntity rule
});


$RuleEntityCopyWith<$Res> get rule;

}
/// @nodoc
class _$RulesCreateCopyWithImpl<$Res>
    implements $RulesCreateCopyWith<$Res> {
  _$RulesCreateCopyWithImpl(this._self, this._then);

  final RulesCreate _self;
  final $Res Function(RulesCreate) _then;

/// Create a copy of RulesEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? rule = null,}) {
  return _then(RulesCreate(
rule: null == rule ? _self.rule : rule // ignore: cast_nullable_to_non_nullable
as RuleEntity,
  ));
}

/// Create a copy of RulesEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RuleEntityCopyWith<$Res> get rule {
  
  return $RuleEntityCopyWith<$Res>(_self.rule, (value) {
    return _then(_self.copyWith(rule: value));
  });
}
}

/// @nodoc


class RulesUpdate implements RulesEvent {
  const RulesUpdate({required this.rule});
  

 final  RuleEntity rule;

/// Create a copy of RulesEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RulesUpdateCopyWith<RulesUpdate> get copyWith => _$RulesUpdateCopyWithImpl<RulesUpdate>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RulesUpdate&&(identical(other.rule, rule) || other.rule == rule));
}


@override
int get hashCode => Object.hash(runtimeType,rule);

@override
String toString() {
  return 'RulesEvent.update(rule: $rule)';
}


}

/// @nodoc
abstract mixin class $RulesUpdateCopyWith<$Res> implements $RulesEventCopyWith<$Res> {
  factory $RulesUpdateCopyWith(RulesUpdate value, $Res Function(RulesUpdate) _then) = _$RulesUpdateCopyWithImpl;
@useResult
$Res call({
 RuleEntity rule
});


$RuleEntityCopyWith<$Res> get rule;

}
/// @nodoc
class _$RulesUpdateCopyWithImpl<$Res>
    implements $RulesUpdateCopyWith<$Res> {
  _$RulesUpdateCopyWithImpl(this._self, this._then);

  final RulesUpdate _self;
  final $Res Function(RulesUpdate) _then;

/// Create a copy of RulesEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? rule = null,}) {
  return _then(RulesUpdate(
rule: null == rule ? _self.rule : rule // ignore: cast_nullable_to_non_nullable
as RuleEntity,
  ));
}

/// Create a copy of RulesEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RuleEntityCopyWith<$Res> get rule {
  
  return $RuleEntityCopyWith<$Res>(_self.rule, (value) {
    return _then(_self.copyWith(rule: value));
  });
}
}

/// @nodoc


class RulesDelete implements RulesEvent {
  const RulesDelete({required this.id, required this.userId});
  

 final  String id;
 final  String userId;

/// Create a copy of RulesEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RulesDeleteCopyWith<RulesDelete> get copyWith => _$RulesDeleteCopyWithImpl<RulesDelete>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RulesDelete&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId));
}


@override
int get hashCode => Object.hash(runtimeType,id,userId);

@override
String toString() {
  return 'RulesEvent.delete(id: $id, userId: $userId)';
}


}

/// @nodoc
abstract mixin class $RulesDeleteCopyWith<$Res> implements $RulesEventCopyWith<$Res> {
  factory $RulesDeleteCopyWith(RulesDelete value, $Res Function(RulesDelete) _then) = _$RulesDeleteCopyWithImpl;
@useResult
$Res call({
 String id, String userId
});




}
/// @nodoc
class _$RulesDeleteCopyWithImpl<$Res>
    implements $RulesDeleteCopyWith<$Res> {
  _$RulesDeleteCopyWithImpl(this._self, this._then);

  final RulesDelete _self;
  final $Res Function(RulesDelete) _then;

/// Create a copy of RulesEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,}) {
  return _then(RulesDelete(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class RulesToggle implements RulesEvent {
  const RulesToggle({required this.id, required this.isActive, required this.userId});
  

 final  String id;
 final  bool isActive;
 final  String userId;

/// Create a copy of RulesEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RulesToggleCopyWith<RulesToggle> get copyWith => _$RulesToggleCopyWithImpl<RulesToggle>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RulesToggle&&(identical(other.id, id) || other.id == id)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.userId, userId) || other.userId == userId));
}


@override
int get hashCode => Object.hash(runtimeType,id,isActive,userId);

@override
String toString() {
  return 'RulesEvent.toggle(id: $id, isActive: $isActive, userId: $userId)';
}


}

/// @nodoc
abstract mixin class $RulesToggleCopyWith<$Res> implements $RulesEventCopyWith<$Res> {
  factory $RulesToggleCopyWith(RulesToggle value, $Res Function(RulesToggle) _then) = _$RulesToggleCopyWithImpl;
@useResult
$Res call({
 String id, bool isActive, String userId
});




}
/// @nodoc
class _$RulesToggleCopyWithImpl<$Res>
    implements $RulesToggleCopyWith<$Res> {
  _$RulesToggleCopyWithImpl(this._self, this._then);

  final RulesToggle _self;
  final $Res Function(RulesToggle) _then;

/// Create a copy of RulesEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? id = null,Object? isActive = null,Object? userId = null,}) {
  return _then(RulesToggle(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class RulesEvaluate implements RulesEvent {
  const RulesEvaluate({required this.expense});
  

 final  ExpenseEntity expense;

/// Create a copy of RulesEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RulesEvaluateCopyWith<RulesEvaluate> get copyWith => _$RulesEvaluateCopyWithImpl<RulesEvaluate>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RulesEvaluate&&(identical(other.expense, expense) || other.expense == expense));
}


@override
int get hashCode => Object.hash(runtimeType,expense);

@override
String toString() {
  return 'RulesEvent.evaluate(expense: $expense)';
}


}

/// @nodoc
abstract mixin class $RulesEvaluateCopyWith<$Res> implements $RulesEventCopyWith<$Res> {
  factory $RulesEvaluateCopyWith(RulesEvaluate value, $Res Function(RulesEvaluate) _then) = _$RulesEvaluateCopyWithImpl;
@useResult
$Res call({
 ExpenseEntity expense
});


$ExpenseEntityCopyWith<$Res> get expense;

}
/// @nodoc
class _$RulesEvaluateCopyWithImpl<$Res>
    implements $RulesEvaluateCopyWith<$Res> {
  _$RulesEvaluateCopyWithImpl(this._self, this._then);

  final RulesEvaluate _self;
  final $Res Function(RulesEvaluate) _then;

/// Create a copy of RulesEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? expense = null,}) {
  return _then(RulesEvaluate(
expense: null == expense ? _self.expense : expense // ignore: cast_nullable_to_non_nullable
as ExpenseEntity,
  ));
}

/// Create a copy of RulesEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ExpenseEntityCopyWith<$Res> get expense {
  
  return $ExpenseEntityCopyWith<$Res>(_self.expense, (value) {
    return _then(_self.copyWith(expense: value));
  });
}
}

// dart format on
