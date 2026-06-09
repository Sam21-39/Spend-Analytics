// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'rule_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RuleEntity {

 String get id; String get userId; RuleType get ruleType; Map<String, dynamic> get parameters; bool get isActive; DateTime get createdAt; DateTime get updatedAt; bool get isDeleted;
/// Create a copy of RuleEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RuleEntityCopyWith<RuleEntity> get copyWith => _$RuleEntityCopyWithImpl<RuleEntity>(this as RuleEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RuleEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.ruleType, ruleType) || other.ruleType == ruleType)&&const DeepCollectionEquality().equals(other.parameters, parameters)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.isDeleted, isDeleted) || other.isDeleted == isDeleted));
}


@override
int get hashCode => Object.hash(runtimeType,id,userId,ruleType,const DeepCollectionEquality().hash(parameters),isActive,createdAt,updatedAt,isDeleted);

@override
String toString() {
  return 'RuleEntity(id: $id, userId: $userId, ruleType: $ruleType, parameters: $parameters, isActive: $isActive, createdAt: $createdAt, updatedAt: $updatedAt, isDeleted: $isDeleted)';
}


}

/// @nodoc
abstract mixin class $RuleEntityCopyWith<$Res>  {
  factory $RuleEntityCopyWith(RuleEntity value, $Res Function(RuleEntity) _then) = _$RuleEntityCopyWithImpl;
@useResult
$Res call({
 String id, String userId, RuleType ruleType, Map<String, dynamic> parameters, bool isActive, DateTime createdAt, DateTime updatedAt, bool isDeleted
});




}
/// @nodoc
class _$RuleEntityCopyWithImpl<$Res>
    implements $RuleEntityCopyWith<$Res> {
  _$RuleEntityCopyWithImpl(this._self, this._then);

  final RuleEntity _self;
  final $Res Function(RuleEntity) _then;

/// Create a copy of RuleEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? ruleType = null,Object? parameters = null,Object? isActive = null,Object? createdAt = null,Object? updatedAt = null,Object? isDeleted = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,ruleType: null == ruleType ? _self.ruleType : ruleType // ignore: cast_nullable_to_non_nullable
as RuleType,parameters: null == parameters ? _self.parameters : parameters // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,isDeleted: null == isDeleted ? _self.isDeleted : isDeleted // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [RuleEntity].
extension RuleEntityPatterns on RuleEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RuleEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RuleEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RuleEntity value)  $default,){
final _that = this;
switch (_that) {
case _RuleEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RuleEntity value)?  $default,){
final _that = this;
switch (_that) {
case _RuleEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String userId,  RuleType ruleType,  Map<String, dynamic> parameters,  bool isActive,  DateTime createdAt,  DateTime updatedAt,  bool isDeleted)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RuleEntity() when $default != null:
return $default(_that.id,_that.userId,_that.ruleType,_that.parameters,_that.isActive,_that.createdAt,_that.updatedAt,_that.isDeleted);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String userId,  RuleType ruleType,  Map<String, dynamic> parameters,  bool isActive,  DateTime createdAt,  DateTime updatedAt,  bool isDeleted)  $default,) {final _that = this;
switch (_that) {
case _RuleEntity():
return $default(_that.id,_that.userId,_that.ruleType,_that.parameters,_that.isActive,_that.createdAt,_that.updatedAt,_that.isDeleted);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String userId,  RuleType ruleType,  Map<String, dynamic> parameters,  bool isActive,  DateTime createdAt,  DateTime updatedAt,  bool isDeleted)?  $default,) {final _that = this;
switch (_that) {
case _RuleEntity() when $default != null:
return $default(_that.id,_that.userId,_that.ruleType,_that.parameters,_that.isActive,_that.createdAt,_that.updatedAt,_that.isDeleted);case _:
  return null;

}
}

}

/// @nodoc


class _RuleEntity implements RuleEntity {
  const _RuleEntity({required this.id, required this.userId, required this.ruleType, final  Map<String, dynamic> parameters = const {}, this.isActive = true, required this.createdAt, required this.updatedAt, this.isDeleted = false}): _parameters = parameters;
  

@override final  String id;
@override final  String userId;
@override final  RuleType ruleType;
 final  Map<String, dynamic> _parameters;
@override@JsonKey() Map<String, dynamic> get parameters {
  if (_parameters is EqualUnmodifiableMapView) return _parameters;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_parameters);
}

@override@JsonKey() final  bool isActive;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;
@override@JsonKey() final  bool isDeleted;

/// Create a copy of RuleEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RuleEntityCopyWith<_RuleEntity> get copyWith => __$RuleEntityCopyWithImpl<_RuleEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RuleEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.ruleType, ruleType) || other.ruleType == ruleType)&&const DeepCollectionEquality().equals(other._parameters, _parameters)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.isDeleted, isDeleted) || other.isDeleted == isDeleted));
}


@override
int get hashCode => Object.hash(runtimeType,id,userId,ruleType,const DeepCollectionEquality().hash(_parameters),isActive,createdAt,updatedAt,isDeleted);

@override
String toString() {
  return 'RuleEntity(id: $id, userId: $userId, ruleType: $ruleType, parameters: $parameters, isActive: $isActive, createdAt: $createdAt, updatedAt: $updatedAt, isDeleted: $isDeleted)';
}


}

/// @nodoc
abstract mixin class _$RuleEntityCopyWith<$Res> implements $RuleEntityCopyWith<$Res> {
  factory _$RuleEntityCopyWith(_RuleEntity value, $Res Function(_RuleEntity) _then) = __$RuleEntityCopyWithImpl;
@override @useResult
$Res call({
 String id, String userId, RuleType ruleType, Map<String, dynamic> parameters, bool isActive, DateTime createdAt, DateTime updatedAt, bool isDeleted
});




}
/// @nodoc
class __$RuleEntityCopyWithImpl<$Res>
    implements _$RuleEntityCopyWith<$Res> {
  __$RuleEntityCopyWithImpl(this._self, this._then);

  final _RuleEntity _self;
  final $Res Function(_RuleEntity) _then;

/// Create a copy of RuleEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? ruleType = null,Object? parameters = null,Object? isActive = null,Object? createdAt = null,Object? updatedAt = null,Object? isDeleted = null,}) {
  return _then(_RuleEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,ruleType: null == ruleType ? _self.ruleType : ruleType // ignore: cast_nullable_to_non_nullable
as RuleType,parameters: null == parameters ? _self._parameters : parameters // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,isDeleted: null == isDeleted ? _self.isDeleted : isDeleted // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
