// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_event_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$NotificationEventEntity {

 String get id; String? get userId; String get title; String get body; String? get route; Map<String, dynamic> get payload; String get source; bool get isRead; DateTime get createdAt;
/// Create a copy of NotificationEventEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationEventEntityCopyWith<NotificationEventEntity> get copyWith => _$NotificationEventEntityCopyWithImpl<NotificationEventEntity>(this as NotificationEventEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationEventEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.title, title) || other.title == title)&&(identical(other.body, body) || other.body == body)&&(identical(other.route, route) || other.route == route)&&const DeepCollectionEquality().equals(other.payload, payload)&&(identical(other.source, source) || other.source == source)&&(identical(other.isRead, isRead) || other.isRead == isRead)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,userId,title,body,route,const DeepCollectionEquality().hash(payload),source,isRead,createdAt);

@override
String toString() {
  return 'NotificationEventEntity(id: $id, userId: $userId, title: $title, body: $body, route: $route, payload: $payload, source: $source, isRead: $isRead, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $NotificationEventEntityCopyWith<$Res>  {
  factory $NotificationEventEntityCopyWith(NotificationEventEntity value, $Res Function(NotificationEventEntity) _then) = _$NotificationEventEntityCopyWithImpl;
@useResult
$Res call({
 String id, String? userId, String title, String body, String? route, Map<String, dynamic> payload, String source, bool isRead, DateTime createdAt
});




}
/// @nodoc
class _$NotificationEventEntityCopyWithImpl<$Res>
    implements $NotificationEventEntityCopyWith<$Res> {
  _$NotificationEventEntityCopyWithImpl(this._self, this._then);

  final NotificationEventEntity _self;
  final $Res Function(NotificationEventEntity) _then;

/// Create a copy of NotificationEventEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = freezed,Object? title = null,Object? body = null,Object? route = freezed,Object? payload = null,Object? source = null,Object? isRead = null,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String?,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,route: freezed == route ? _self.route : route // ignore: cast_nullable_to_non_nullable
as String?,payload: null == payload ? _self.payload : payload // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String,isRead: null == isRead ? _self.isRead : isRead // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [NotificationEventEntity].
extension NotificationEventEntityPatterns on NotificationEventEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NotificationEventEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NotificationEventEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NotificationEventEntity value)  $default,){
final _that = this;
switch (_that) {
case _NotificationEventEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NotificationEventEntity value)?  $default,){
final _that = this;
switch (_that) {
case _NotificationEventEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String? userId,  String title,  String body,  String? route,  Map<String, dynamic> payload,  String source,  bool isRead,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NotificationEventEntity() when $default != null:
return $default(_that.id,_that.userId,_that.title,_that.body,_that.route,_that.payload,_that.source,_that.isRead,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String? userId,  String title,  String body,  String? route,  Map<String, dynamic> payload,  String source,  bool isRead,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _NotificationEventEntity():
return $default(_that.id,_that.userId,_that.title,_that.body,_that.route,_that.payload,_that.source,_that.isRead,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String? userId,  String title,  String body,  String? route,  Map<String, dynamic> payload,  String source,  bool isRead,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _NotificationEventEntity() when $default != null:
return $default(_that.id,_that.userId,_that.title,_that.body,_that.route,_that.payload,_that.source,_that.isRead,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc


class _NotificationEventEntity implements NotificationEventEntity {
  const _NotificationEventEntity({required this.id, this.userId, required this.title, required this.body, this.route, final  Map<String, dynamic> payload = const {}, this.source = 'system', this.isRead = false, required this.createdAt}): _payload = payload;
  

@override final  String id;
@override final  String? userId;
@override final  String title;
@override final  String body;
@override final  String? route;
 final  Map<String, dynamic> _payload;
@override@JsonKey() Map<String, dynamic> get payload {
  if (_payload is EqualUnmodifiableMapView) return _payload;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_payload);
}

@override@JsonKey() final  String source;
@override@JsonKey() final  bool isRead;
@override final  DateTime createdAt;

/// Create a copy of NotificationEventEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NotificationEventEntityCopyWith<_NotificationEventEntity> get copyWith => __$NotificationEventEntityCopyWithImpl<_NotificationEventEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NotificationEventEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.title, title) || other.title == title)&&(identical(other.body, body) || other.body == body)&&(identical(other.route, route) || other.route == route)&&const DeepCollectionEquality().equals(other._payload, _payload)&&(identical(other.source, source) || other.source == source)&&(identical(other.isRead, isRead) || other.isRead == isRead)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,userId,title,body,route,const DeepCollectionEquality().hash(_payload),source,isRead,createdAt);

@override
String toString() {
  return 'NotificationEventEntity(id: $id, userId: $userId, title: $title, body: $body, route: $route, payload: $payload, source: $source, isRead: $isRead, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$NotificationEventEntityCopyWith<$Res> implements $NotificationEventEntityCopyWith<$Res> {
  factory _$NotificationEventEntityCopyWith(_NotificationEventEntity value, $Res Function(_NotificationEventEntity) _then) = __$NotificationEventEntityCopyWithImpl;
@override @useResult
$Res call({
 String id, String? userId, String title, String body, String? route, Map<String, dynamic> payload, String source, bool isRead, DateTime createdAt
});




}
/// @nodoc
class __$NotificationEventEntityCopyWithImpl<$Res>
    implements _$NotificationEventEntityCopyWith<$Res> {
  __$NotificationEventEntityCopyWithImpl(this._self, this._then);

  final _NotificationEventEntity _self;
  final $Res Function(_NotificationEventEntity) _then;

/// Create a copy of NotificationEventEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = freezed,Object? title = null,Object? body = null,Object? route = freezed,Object? payload = null,Object? source = null,Object? isRead = null,Object? createdAt = null,}) {
  return _then(_NotificationEventEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String?,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,route: freezed == route ? _self.route : route // ignore: cast_nullable_to_non_nullable
as String?,payload: null == payload ? _self._payload : payload // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String,isRead: null == isRead ? _self.isRead : isRead // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
