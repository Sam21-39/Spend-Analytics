// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'expense_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ExpenseEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExpenseEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ExpenseEvent()';
}


}

/// @nodoc
class $ExpenseEventCopyWith<$Res>  {
$ExpenseEventCopyWith(ExpenseEvent _, $Res Function(ExpenseEvent) __);
}


/// Adds pattern-matching-related methods to [ExpenseEvent].
extension ExpenseEventPatterns on ExpenseEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ExpenseLoad value)?  load,TResult Function( ExpenseAdd value)?  add,TResult Function( ExpenseUpdate value)?  update,TResult Function( ExpenseDelete value)?  delete,TResult Function( ExpenseFilter value)?  filter,TResult Function( ExpenseApplyVoiceResult value)?  applyVoiceResult,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ExpenseLoad() when load != null:
return load(_that);case ExpenseAdd() when add != null:
return add(_that);case ExpenseUpdate() when update != null:
return update(_that);case ExpenseDelete() when delete != null:
return delete(_that);case ExpenseFilter() when filter != null:
return filter(_that);case ExpenseApplyVoiceResult() when applyVoiceResult != null:
return applyVoiceResult(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ExpenseLoad value)  load,required TResult Function( ExpenseAdd value)  add,required TResult Function( ExpenseUpdate value)  update,required TResult Function( ExpenseDelete value)  delete,required TResult Function( ExpenseFilter value)  filter,required TResult Function( ExpenseApplyVoiceResult value)  applyVoiceResult,}){
final _that = this;
switch (_that) {
case ExpenseLoad():
return load(_that);case ExpenseAdd():
return add(_that);case ExpenseUpdate():
return update(_that);case ExpenseDelete():
return delete(_that);case ExpenseFilter():
return filter(_that);case ExpenseApplyVoiceResult():
return applyVoiceResult(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ExpenseLoad value)?  load,TResult? Function( ExpenseAdd value)?  add,TResult? Function( ExpenseUpdate value)?  update,TResult? Function( ExpenseDelete value)?  delete,TResult? Function( ExpenseFilter value)?  filter,TResult? Function( ExpenseApplyVoiceResult value)?  applyVoiceResult,}){
final _that = this;
switch (_that) {
case ExpenseLoad() when load != null:
return load(_that);case ExpenseAdd() when add != null:
return add(_that);case ExpenseUpdate() when update != null:
return update(_that);case ExpenseDelete() when delete != null:
return delete(_that);case ExpenseFilter() when filter != null:
return filter(_that);case ExpenseApplyVoiceResult() when applyVoiceResult != null:
return applyVoiceResult(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String userId)?  load,TResult Function( ExpenseEntity expense)?  add,TResult Function( ExpenseEntity expense)?  update,TResult Function( String id,  String userId)?  delete,TResult Function( String? type,  String? category)?  filter,TResult Function( VoiceParseResult result,  String userId)?  applyVoiceResult,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ExpenseLoad() when load != null:
return load(_that.userId);case ExpenseAdd() when add != null:
return add(_that.expense);case ExpenseUpdate() when update != null:
return update(_that.expense);case ExpenseDelete() when delete != null:
return delete(_that.id,_that.userId);case ExpenseFilter() when filter != null:
return filter(_that.type,_that.category);case ExpenseApplyVoiceResult() when applyVoiceResult != null:
return applyVoiceResult(_that.result,_that.userId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String userId)  load,required TResult Function( ExpenseEntity expense)  add,required TResult Function( ExpenseEntity expense)  update,required TResult Function( String id,  String userId)  delete,required TResult Function( String? type,  String? category)  filter,required TResult Function( VoiceParseResult result,  String userId)  applyVoiceResult,}) {final _that = this;
switch (_that) {
case ExpenseLoad():
return load(_that.userId);case ExpenseAdd():
return add(_that.expense);case ExpenseUpdate():
return update(_that.expense);case ExpenseDelete():
return delete(_that.id,_that.userId);case ExpenseFilter():
return filter(_that.type,_that.category);case ExpenseApplyVoiceResult():
return applyVoiceResult(_that.result,_that.userId);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String userId)?  load,TResult? Function( ExpenseEntity expense)?  add,TResult? Function( ExpenseEntity expense)?  update,TResult? Function( String id,  String userId)?  delete,TResult? Function( String? type,  String? category)?  filter,TResult? Function( VoiceParseResult result,  String userId)?  applyVoiceResult,}) {final _that = this;
switch (_that) {
case ExpenseLoad() when load != null:
return load(_that.userId);case ExpenseAdd() when add != null:
return add(_that.expense);case ExpenseUpdate() when update != null:
return update(_that.expense);case ExpenseDelete() when delete != null:
return delete(_that.id,_that.userId);case ExpenseFilter() when filter != null:
return filter(_that.type,_that.category);case ExpenseApplyVoiceResult() when applyVoiceResult != null:
return applyVoiceResult(_that.result,_that.userId);case _:
  return null;

}
}

}

/// @nodoc


class ExpenseLoad implements ExpenseEvent {
  const ExpenseLoad({required this.userId});
  

 final  String userId;

/// Create a copy of ExpenseEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExpenseLoadCopyWith<ExpenseLoad> get copyWith => _$ExpenseLoadCopyWithImpl<ExpenseLoad>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExpenseLoad&&(identical(other.userId, userId) || other.userId == userId));
}


@override
int get hashCode => Object.hash(runtimeType,userId);

@override
String toString() {
  return 'ExpenseEvent.load(userId: $userId)';
}


}

/// @nodoc
abstract mixin class $ExpenseLoadCopyWith<$Res> implements $ExpenseEventCopyWith<$Res> {
  factory $ExpenseLoadCopyWith(ExpenseLoad value, $Res Function(ExpenseLoad) _then) = _$ExpenseLoadCopyWithImpl;
@useResult
$Res call({
 String userId
});




}
/// @nodoc
class _$ExpenseLoadCopyWithImpl<$Res>
    implements $ExpenseLoadCopyWith<$Res> {
  _$ExpenseLoadCopyWithImpl(this._self, this._then);

  final ExpenseLoad _self;
  final $Res Function(ExpenseLoad) _then;

/// Create a copy of ExpenseEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? userId = null,}) {
  return _then(ExpenseLoad(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class ExpenseAdd implements ExpenseEvent {
  const ExpenseAdd({required this.expense});
  

 final  ExpenseEntity expense;

/// Create a copy of ExpenseEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExpenseAddCopyWith<ExpenseAdd> get copyWith => _$ExpenseAddCopyWithImpl<ExpenseAdd>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExpenseAdd&&(identical(other.expense, expense) || other.expense == expense));
}


@override
int get hashCode => Object.hash(runtimeType,expense);

@override
String toString() {
  return 'ExpenseEvent.add(expense: $expense)';
}


}

/// @nodoc
abstract mixin class $ExpenseAddCopyWith<$Res> implements $ExpenseEventCopyWith<$Res> {
  factory $ExpenseAddCopyWith(ExpenseAdd value, $Res Function(ExpenseAdd) _then) = _$ExpenseAddCopyWithImpl;
@useResult
$Res call({
 ExpenseEntity expense
});


$ExpenseEntityCopyWith<$Res> get expense;

}
/// @nodoc
class _$ExpenseAddCopyWithImpl<$Res>
    implements $ExpenseAddCopyWith<$Res> {
  _$ExpenseAddCopyWithImpl(this._self, this._then);

  final ExpenseAdd _self;
  final $Res Function(ExpenseAdd) _then;

/// Create a copy of ExpenseEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? expense = null,}) {
  return _then(ExpenseAdd(
expense: null == expense ? _self.expense : expense // ignore: cast_nullable_to_non_nullable
as ExpenseEntity,
  ));
}

/// Create a copy of ExpenseEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ExpenseEntityCopyWith<$Res> get expense {
  
  return $ExpenseEntityCopyWith<$Res>(_self.expense, (value) {
    return _then(_self.copyWith(expense: value));
  });
}
}

/// @nodoc


class ExpenseUpdate implements ExpenseEvent {
  const ExpenseUpdate({required this.expense});
  

 final  ExpenseEntity expense;

/// Create a copy of ExpenseEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExpenseUpdateCopyWith<ExpenseUpdate> get copyWith => _$ExpenseUpdateCopyWithImpl<ExpenseUpdate>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExpenseUpdate&&(identical(other.expense, expense) || other.expense == expense));
}


@override
int get hashCode => Object.hash(runtimeType,expense);

@override
String toString() {
  return 'ExpenseEvent.update(expense: $expense)';
}


}

/// @nodoc
abstract mixin class $ExpenseUpdateCopyWith<$Res> implements $ExpenseEventCopyWith<$Res> {
  factory $ExpenseUpdateCopyWith(ExpenseUpdate value, $Res Function(ExpenseUpdate) _then) = _$ExpenseUpdateCopyWithImpl;
@useResult
$Res call({
 ExpenseEntity expense
});


$ExpenseEntityCopyWith<$Res> get expense;

}
/// @nodoc
class _$ExpenseUpdateCopyWithImpl<$Res>
    implements $ExpenseUpdateCopyWith<$Res> {
  _$ExpenseUpdateCopyWithImpl(this._self, this._then);

  final ExpenseUpdate _self;
  final $Res Function(ExpenseUpdate) _then;

/// Create a copy of ExpenseEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? expense = null,}) {
  return _then(ExpenseUpdate(
expense: null == expense ? _self.expense : expense // ignore: cast_nullable_to_non_nullable
as ExpenseEntity,
  ));
}

/// Create a copy of ExpenseEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ExpenseEntityCopyWith<$Res> get expense {
  
  return $ExpenseEntityCopyWith<$Res>(_self.expense, (value) {
    return _then(_self.copyWith(expense: value));
  });
}
}

/// @nodoc


class ExpenseDelete implements ExpenseEvent {
  const ExpenseDelete({required this.id, required this.userId});
  

 final  String id;
 final  String userId;

/// Create a copy of ExpenseEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExpenseDeleteCopyWith<ExpenseDelete> get copyWith => _$ExpenseDeleteCopyWithImpl<ExpenseDelete>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExpenseDelete&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId));
}


@override
int get hashCode => Object.hash(runtimeType,id,userId);

@override
String toString() {
  return 'ExpenseEvent.delete(id: $id, userId: $userId)';
}


}

/// @nodoc
abstract mixin class $ExpenseDeleteCopyWith<$Res> implements $ExpenseEventCopyWith<$Res> {
  factory $ExpenseDeleteCopyWith(ExpenseDelete value, $Res Function(ExpenseDelete) _then) = _$ExpenseDeleteCopyWithImpl;
@useResult
$Res call({
 String id, String userId
});




}
/// @nodoc
class _$ExpenseDeleteCopyWithImpl<$Res>
    implements $ExpenseDeleteCopyWith<$Res> {
  _$ExpenseDeleteCopyWithImpl(this._self, this._then);

  final ExpenseDelete _self;
  final $Res Function(ExpenseDelete) _then;

/// Create a copy of ExpenseEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,}) {
  return _then(ExpenseDelete(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class ExpenseFilter implements ExpenseEvent {
  const ExpenseFilter({this.type, this.category});
  

 final  String? type;
 final  String? category;

/// Create a copy of ExpenseEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExpenseFilterCopyWith<ExpenseFilter> get copyWith => _$ExpenseFilterCopyWithImpl<ExpenseFilter>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExpenseFilter&&(identical(other.type, type) || other.type == type)&&(identical(other.category, category) || other.category == category));
}


@override
int get hashCode => Object.hash(runtimeType,type,category);

@override
String toString() {
  return 'ExpenseEvent.filter(type: $type, category: $category)';
}


}

/// @nodoc
abstract mixin class $ExpenseFilterCopyWith<$Res> implements $ExpenseEventCopyWith<$Res> {
  factory $ExpenseFilterCopyWith(ExpenseFilter value, $Res Function(ExpenseFilter) _then) = _$ExpenseFilterCopyWithImpl;
@useResult
$Res call({
 String? type, String? category
});




}
/// @nodoc
class _$ExpenseFilterCopyWithImpl<$Res>
    implements $ExpenseFilterCopyWith<$Res> {
  _$ExpenseFilterCopyWithImpl(this._self, this._then);

  final ExpenseFilter _self;
  final $Res Function(ExpenseFilter) _then;

/// Create a copy of ExpenseEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? type = freezed,Object? category = freezed,}) {
  return _then(ExpenseFilter(
type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class ExpenseApplyVoiceResult implements ExpenseEvent {
  const ExpenseApplyVoiceResult({required this.result, required this.userId});
  

 final  VoiceParseResult result;
 final  String userId;

/// Create a copy of ExpenseEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExpenseApplyVoiceResultCopyWith<ExpenseApplyVoiceResult> get copyWith => _$ExpenseApplyVoiceResultCopyWithImpl<ExpenseApplyVoiceResult>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExpenseApplyVoiceResult&&(identical(other.result, result) || other.result == result)&&(identical(other.userId, userId) || other.userId == userId));
}


@override
int get hashCode => Object.hash(runtimeType,result,userId);

@override
String toString() {
  return 'ExpenseEvent.applyVoiceResult(result: $result, userId: $userId)';
}


}

/// @nodoc
abstract mixin class $ExpenseApplyVoiceResultCopyWith<$Res> implements $ExpenseEventCopyWith<$Res> {
  factory $ExpenseApplyVoiceResultCopyWith(ExpenseApplyVoiceResult value, $Res Function(ExpenseApplyVoiceResult) _then) = _$ExpenseApplyVoiceResultCopyWithImpl;
@useResult
$Res call({
 VoiceParseResult result, String userId
});




}
/// @nodoc
class _$ExpenseApplyVoiceResultCopyWithImpl<$Res>
    implements $ExpenseApplyVoiceResultCopyWith<$Res> {
  _$ExpenseApplyVoiceResultCopyWithImpl(this._self, this._then);

  final ExpenseApplyVoiceResult _self;
  final $Res Function(ExpenseApplyVoiceResult) _then;

/// Create a copy of ExpenseEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? result = null,Object? userId = null,}) {
  return _then(ExpenseApplyVoiceResult(
result: null == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as VoiceParseResult,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
