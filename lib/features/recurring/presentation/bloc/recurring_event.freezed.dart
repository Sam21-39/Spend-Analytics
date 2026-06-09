// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recurring_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RecurringEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RecurringEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RecurringEvent()';
}


}

/// @nodoc
class $RecurringEventCopyWith<$Res>  {
$RecurringEventCopyWith(RecurringEvent _, $Res Function(RecurringEvent) __);
}


/// Adds pattern-matching-related methods to [RecurringEvent].
extension RecurringEventPatterns on RecurringEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( RecurringLoad value)?  load,TResult Function( RecurringCreate value)?  create,TResult Function( RecurringUpdate value)?  update,TResult Function( RecurringDelete value)?  delete,TResult Function( RecurringAdvanceDueDate value)?  advanceDueDate,TResult Function( RecurringCheckDue value)?  checkDue,required TResult orElse(),}){
final _that = this;
switch (_that) {
case RecurringLoad() when load != null:
return load(_that);case RecurringCreate() when create != null:
return create(_that);case RecurringUpdate() when update != null:
return update(_that);case RecurringDelete() when delete != null:
return delete(_that);case RecurringAdvanceDueDate() when advanceDueDate != null:
return advanceDueDate(_that);case RecurringCheckDue() when checkDue != null:
return checkDue(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( RecurringLoad value)  load,required TResult Function( RecurringCreate value)  create,required TResult Function( RecurringUpdate value)  update,required TResult Function( RecurringDelete value)  delete,required TResult Function( RecurringAdvanceDueDate value)  advanceDueDate,required TResult Function( RecurringCheckDue value)  checkDue,}){
final _that = this;
switch (_that) {
case RecurringLoad():
return load(_that);case RecurringCreate():
return create(_that);case RecurringUpdate():
return update(_that);case RecurringDelete():
return delete(_that);case RecurringAdvanceDueDate():
return advanceDueDate(_that);case RecurringCheckDue():
return checkDue(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( RecurringLoad value)?  load,TResult? Function( RecurringCreate value)?  create,TResult? Function( RecurringUpdate value)?  update,TResult? Function( RecurringDelete value)?  delete,TResult? Function( RecurringAdvanceDueDate value)?  advanceDueDate,TResult? Function( RecurringCheckDue value)?  checkDue,}){
final _that = this;
switch (_that) {
case RecurringLoad() when load != null:
return load(_that);case RecurringCreate() when create != null:
return create(_that);case RecurringUpdate() when update != null:
return update(_that);case RecurringDelete() when delete != null:
return delete(_that);case RecurringAdvanceDueDate() when advanceDueDate != null:
return advanceDueDate(_that);case RecurringCheckDue() when checkDue != null:
return checkDue(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String userId)?  load,TResult Function( RecurringEntity item)?  create,TResult Function( RecurringEntity item)?  update,TResult Function( String id,  String userId)?  delete,TResult Function( String id,  String userId)?  advanceDueDate,TResult Function( String userId)?  checkDue,required TResult orElse(),}) {final _that = this;
switch (_that) {
case RecurringLoad() when load != null:
return load(_that.userId);case RecurringCreate() when create != null:
return create(_that.item);case RecurringUpdate() when update != null:
return update(_that.item);case RecurringDelete() when delete != null:
return delete(_that.id,_that.userId);case RecurringAdvanceDueDate() when advanceDueDate != null:
return advanceDueDate(_that.id,_that.userId);case RecurringCheckDue() when checkDue != null:
return checkDue(_that.userId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String userId)  load,required TResult Function( RecurringEntity item)  create,required TResult Function( RecurringEntity item)  update,required TResult Function( String id,  String userId)  delete,required TResult Function( String id,  String userId)  advanceDueDate,required TResult Function( String userId)  checkDue,}) {final _that = this;
switch (_that) {
case RecurringLoad():
return load(_that.userId);case RecurringCreate():
return create(_that.item);case RecurringUpdate():
return update(_that.item);case RecurringDelete():
return delete(_that.id,_that.userId);case RecurringAdvanceDueDate():
return advanceDueDate(_that.id,_that.userId);case RecurringCheckDue():
return checkDue(_that.userId);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String userId)?  load,TResult? Function( RecurringEntity item)?  create,TResult? Function( RecurringEntity item)?  update,TResult? Function( String id,  String userId)?  delete,TResult? Function( String id,  String userId)?  advanceDueDate,TResult? Function( String userId)?  checkDue,}) {final _that = this;
switch (_that) {
case RecurringLoad() when load != null:
return load(_that.userId);case RecurringCreate() when create != null:
return create(_that.item);case RecurringUpdate() when update != null:
return update(_that.item);case RecurringDelete() when delete != null:
return delete(_that.id,_that.userId);case RecurringAdvanceDueDate() when advanceDueDate != null:
return advanceDueDate(_that.id,_that.userId);case RecurringCheckDue() when checkDue != null:
return checkDue(_that.userId);case _:
  return null;

}
}

}

/// @nodoc


class RecurringLoad implements RecurringEvent {
  const RecurringLoad({required this.userId});
  

 final  String userId;

/// Create a copy of RecurringEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RecurringLoadCopyWith<RecurringLoad> get copyWith => _$RecurringLoadCopyWithImpl<RecurringLoad>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RecurringLoad&&(identical(other.userId, userId) || other.userId == userId));
}


@override
int get hashCode => Object.hash(runtimeType,userId);

@override
String toString() {
  return 'RecurringEvent.load(userId: $userId)';
}


}

/// @nodoc
abstract mixin class $RecurringLoadCopyWith<$Res> implements $RecurringEventCopyWith<$Res> {
  factory $RecurringLoadCopyWith(RecurringLoad value, $Res Function(RecurringLoad) _then) = _$RecurringLoadCopyWithImpl;
@useResult
$Res call({
 String userId
});




}
/// @nodoc
class _$RecurringLoadCopyWithImpl<$Res>
    implements $RecurringLoadCopyWith<$Res> {
  _$RecurringLoadCopyWithImpl(this._self, this._then);

  final RecurringLoad _self;
  final $Res Function(RecurringLoad) _then;

/// Create a copy of RecurringEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? userId = null,}) {
  return _then(RecurringLoad(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class RecurringCreate implements RecurringEvent {
  const RecurringCreate({required this.item});
  

 final  RecurringEntity item;

/// Create a copy of RecurringEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RecurringCreateCopyWith<RecurringCreate> get copyWith => _$RecurringCreateCopyWithImpl<RecurringCreate>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RecurringCreate&&(identical(other.item, item) || other.item == item));
}


@override
int get hashCode => Object.hash(runtimeType,item);

@override
String toString() {
  return 'RecurringEvent.create(item: $item)';
}


}

/// @nodoc
abstract mixin class $RecurringCreateCopyWith<$Res> implements $RecurringEventCopyWith<$Res> {
  factory $RecurringCreateCopyWith(RecurringCreate value, $Res Function(RecurringCreate) _then) = _$RecurringCreateCopyWithImpl;
@useResult
$Res call({
 RecurringEntity item
});


$RecurringEntityCopyWith<$Res> get item;

}
/// @nodoc
class _$RecurringCreateCopyWithImpl<$Res>
    implements $RecurringCreateCopyWith<$Res> {
  _$RecurringCreateCopyWithImpl(this._self, this._then);

  final RecurringCreate _self;
  final $Res Function(RecurringCreate) _then;

/// Create a copy of RecurringEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? item = null,}) {
  return _then(RecurringCreate(
item: null == item ? _self.item : item // ignore: cast_nullable_to_non_nullable
as RecurringEntity,
  ));
}

/// Create a copy of RecurringEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RecurringEntityCopyWith<$Res> get item {
  
  return $RecurringEntityCopyWith<$Res>(_self.item, (value) {
    return _then(_self.copyWith(item: value));
  });
}
}

/// @nodoc


class RecurringUpdate implements RecurringEvent {
  const RecurringUpdate({required this.item});
  

 final  RecurringEntity item;

/// Create a copy of RecurringEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RecurringUpdateCopyWith<RecurringUpdate> get copyWith => _$RecurringUpdateCopyWithImpl<RecurringUpdate>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RecurringUpdate&&(identical(other.item, item) || other.item == item));
}


@override
int get hashCode => Object.hash(runtimeType,item);

@override
String toString() {
  return 'RecurringEvent.update(item: $item)';
}


}

/// @nodoc
abstract mixin class $RecurringUpdateCopyWith<$Res> implements $RecurringEventCopyWith<$Res> {
  factory $RecurringUpdateCopyWith(RecurringUpdate value, $Res Function(RecurringUpdate) _then) = _$RecurringUpdateCopyWithImpl;
@useResult
$Res call({
 RecurringEntity item
});


$RecurringEntityCopyWith<$Res> get item;

}
/// @nodoc
class _$RecurringUpdateCopyWithImpl<$Res>
    implements $RecurringUpdateCopyWith<$Res> {
  _$RecurringUpdateCopyWithImpl(this._self, this._then);

  final RecurringUpdate _self;
  final $Res Function(RecurringUpdate) _then;

/// Create a copy of RecurringEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? item = null,}) {
  return _then(RecurringUpdate(
item: null == item ? _self.item : item // ignore: cast_nullable_to_non_nullable
as RecurringEntity,
  ));
}

/// Create a copy of RecurringEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RecurringEntityCopyWith<$Res> get item {
  
  return $RecurringEntityCopyWith<$Res>(_self.item, (value) {
    return _then(_self.copyWith(item: value));
  });
}
}

/// @nodoc


class RecurringDelete implements RecurringEvent {
  const RecurringDelete({required this.id, required this.userId});
  

 final  String id;
 final  String userId;

/// Create a copy of RecurringEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RecurringDeleteCopyWith<RecurringDelete> get copyWith => _$RecurringDeleteCopyWithImpl<RecurringDelete>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RecurringDelete&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId));
}


@override
int get hashCode => Object.hash(runtimeType,id,userId);

@override
String toString() {
  return 'RecurringEvent.delete(id: $id, userId: $userId)';
}


}

/// @nodoc
abstract mixin class $RecurringDeleteCopyWith<$Res> implements $RecurringEventCopyWith<$Res> {
  factory $RecurringDeleteCopyWith(RecurringDelete value, $Res Function(RecurringDelete) _then) = _$RecurringDeleteCopyWithImpl;
@useResult
$Res call({
 String id, String userId
});




}
/// @nodoc
class _$RecurringDeleteCopyWithImpl<$Res>
    implements $RecurringDeleteCopyWith<$Res> {
  _$RecurringDeleteCopyWithImpl(this._self, this._then);

  final RecurringDelete _self;
  final $Res Function(RecurringDelete) _then;

/// Create a copy of RecurringEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,}) {
  return _then(RecurringDelete(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class RecurringAdvanceDueDate implements RecurringEvent {
  const RecurringAdvanceDueDate({required this.id, required this.userId});
  

 final  String id;
 final  String userId;

/// Create a copy of RecurringEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RecurringAdvanceDueDateCopyWith<RecurringAdvanceDueDate> get copyWith => _$RecurringAdvanceDueDateCopyWithImpl<RecurringAdvanceDueDate>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RecurringAdvanceDueDate&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId));
}


@override
int get hashCode => Object.hash(runtimeType,id,userId);

@override
String toString() {
  return 'RecurringEvent.advanceDueDate(id: $id, userId: $userId)';
}


}

/// @nodoc
abstract mixin class $RecurringAdvanceDueDateCopyWith<$Res> implements $RecurringEventCopyWith<$Res> {
  factory $RecurringAdvanceDueDateCopyWith(RecurringAdvanceDueDate value, $Res Function(RecurringAdvanceDueDate) _then) = _$RecurringAdvanceDueDateCopyWithImpl;
@useResult
$Res call({
 String id, String userId
});




}
/// @nodoc
class _$RecurringAdvanceDueDateCopyWithImpl<$Res>
    implements $RecurringAdvanceDueDateCopyWith<$Res> {
  _$RecurringAdvanceDueDateCopyWithImpl(this._self, this._then);

  final RecurringAdvanceDueDate _self;
  final $Res Function(RecurringAdvanceDueDate) _then;

/// Create a copy of RecurringEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,}) {
  return _then(RecurringAdvanceDueDate(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class RecurringCheckDue implements RecurringEvent {
  const RecurringCheckDue({required this.userId});
  

 final  String userId;

/// Create a copy of RecurringEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RecurringCheckDueCopyWith<RecurringCheckDue> get copyWith => _$RecurringCheckDueCopyWithImpl<RecurringCheckDue>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RecurringCheckDue&&(identical(other.userId, userId) || other.userId == userId));
}


@override
int get hashCode => Object.hash(runtimeType,userId);

@override
String toString() {
  return 'RecurringEvent.checkDue(userId: $userId)';
}


}

/// @nodoc
abstract mixin class $RecurringCheckDueCopyWith<$Res> implements $RecurringEventCopyWith<$Res> {
  factory $RecurringCheckDueCopyWith(RecurringCheckDue value, $Res Function(RecurringCheckDue) _then) = _$RecurringCheckDueCopyWithImpl;
@useResult
$Res call({
 String userId
});




}
/// @nodoc
class _$RecurringCheckDueCopyWithImpl<$Res>
    implements $RecurringCheckDueCopyWith<$Res> {
  _$RecurringCheckDueCopyWithImpl(this._self, this._then);

  final RecurringCheckDue _self;
  final $Res Function(RecurringCheckDue) _then;

/// Create a copy of RecurringEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? userId = null,}) {
  return _then(RecurringCheckDue(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
