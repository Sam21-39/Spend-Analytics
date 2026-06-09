// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dashboard_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DashboardEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DashboardEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DashboardEvent()';
}


}

/// @nodoc
class $DashboardEventCopyWith<$Res>  {
$DashboardEventCopyWith(DashboardEvent _, $Res Function(DashboardEvent) __);
}


/// Adds pattern-matching-related methods to [DashboardEvent].
extension DashboardEventPatterns on DashboardEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( DashboardLoad value)?  load,TResult Function( DashboardRefresh value)?  refresh,required TResult orElse(),}){
final _that = this;
switch (_that) {
case DashboardLoad() when load != null:
return load(_that);case DashboardRefresh() when refresh != null:
return refresh(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( DashboardLoad value)  load,required TResult Function( DashboardRefresh value)  refresh,}){
final _that = this;
switch (_that) {
case DashboardLoad():
return load(_that);case DashboardRefresh():
return refresh(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( DashboardLoad value)?  load,TResult? Function( DashboardRefresh value)?  refresh,}){
final _that = this;
switch (_that) {
case DashboardLoad() when load != null:
return load(_that);case DashboardRefresh() when refresh != null:
return refresh(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String userId,  String firstName,  bool isGuestMode)?  load,TResult Function()?  refresh,required TResult orElse(),}) {final _that = this;
switch (_that) {
case DashboardLoad() when load != null:
return load(_that.userId,_that.firstName,_that.isGuestMode);case DashboardRefresh() when refresh != null:
return refresh();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String userId,  String firstName,  bool isGuestMode)  load,required TResult Function()  refresh,}) {final _that = this;
switch (_that) {
case DashboardLoad():
return load(_that.userId,_that.firstName,_that.isGuestMode);case DashboardRefresh():
return refresh();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String userId,  String firstName,  bool isGuestMode)?  load,TResult? Function()?  refresh,}) {final _that = this;
switch (_that) {
case DashboardLoad() when load != null:
return load(_that.userId,_that.firstName,_that.isGuestMode);case DashboardRefresh() when refresh != null:
return refresh();case _:
  return null;

}
}

}

/// @nodoc


class DashboardLoad implements DashboardEvent {
  const DashboardLoad({required this.userId, this.firstName = 'User', this.isGuestMode = true});
  

 final  String userId;
@JsonKey() final  String firstName;
@JsonKey() final  bool isGuestMode;

/// Create a copy of DashboardEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DashboardLoadCopyWith<DashboardLoad> get copyWith => _$DashboardLoadCopyWithImpl<DashboardLoad>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DashboardLoad&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.isGuestMode, isGuestMode) || other.isGuestMode == isGuestMode));
}


@override
int get hashCode => Object.hash(runtimeType,userId,firstName,isGuestMode);

@override
String toString() {
  return 'DashboardEvent.load(userId: $userId, firstName: $firstName, isGuestMode: $isGuestMode)';
}


}

/// @nodoc
abstract mixin class $DashboardLoadCopyWith<$Res> implements $DashboardEventCopyWith<$Res> {
  factory $DashboardLoadCopyWith(DashboardLoad value, $Res Function(DashboardLoad) _then) = _$DashboardLoadCopyWithImpl;
@useResult
$Res call({
 String userId, String firstName, bool isGuestMode
});




}
/// @nodoc
class _$DashboardLoadCopyWithImpl<$Res>
    implements $DashboardLoadCopyWith<$Res> {
  _$DashboardLoadCopyWithImpl(this._self, this._then);

  final DashboardLoad _self;
  final $Res Function(DashboardLoad) _then;

/// Create a copy of DashboardEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? firstName = null,Object? isGuestMode = null,}) {
  return _then(DashboardLoad(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,isGuestMode: null == isGuestMode ? _self.isGuestMode : isGuestMode // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class DashboardRefresh implements DashboardEvent {
  const DashboardRefresh();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DashboardRefresh);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DashboardEvent.refresh()';
}


}




// dart format on
