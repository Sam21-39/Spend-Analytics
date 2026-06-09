// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reports_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ReportsEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReportsEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ReportsEvent()';
}


}

/// @nodoc
class $ReportsEventCopyWith<$Res>  {
$ReportsEventCopyWith(ReportsEvent _, $Res Function(ReportsEvent) __);
}


/// Adds pattern-matching-related methods to [ReportsEvent].
extension ReportsEventPatterns on ReportsEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ReportsLoad value)?  load,TResult Function( ReportsChangeRange value)?  changeRange,TResult Function( ReportsExport value)?  export,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ReportsLoad() when load != null:
return load(_that);case ReportsChangeRange() when changeRange != null:
return changeRange(_that);case ReportsExport() when export != null:
return export(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ReportsLoad value)  load,required TResult Function( ReportsChangeRange value)  changeRange,required TResult Function( ReportsExport value)  export,}){
final _that = this;
switch (_that) {
case ReportsLoad():
return load(_that);case ReportsChangeRange():
return changeRange(_that);case ReportsExport():
return export(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ReportsLoad value)?  load,TResult? Function( ReportsChangeRange value)?  changeRange,TResult? Function( ReportsExport value)?  export,}){
final _that = this;
switch (_that) {
case ReportsLoad() when load != null:
return load(_that);case ReportsChangeRange() when changeRange != null:
return changeRange(_that);case ReportsExport() when export != null:
return export(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String userId,  String range)?  load,TResult Function( String range)?  changeRange,TResult Function( String format,  String userId)?  export,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ReportsLoad() when load != null:
return load(_that.userId,_that.range);case ReportsChangeRange() when changeRange != null:
return changeRange(_that.range);case ReportsExport() when export != null:
return export(_that.format,_that.userId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String userId,  String range)  load,required TResult Function( String range)  changeRange,required TResult Function( String format,  String userId)  export,}) {final _that = this;
switch (_that) {
case ReportsLoad():
return load(_that.userId,_that.range);case ReportsChangeRange():
return changeRange(_that.range);case ReportsExport():
return export(_that.format,_that.userId);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String userId,  String range)?  load,TResult? Function( String range)?  changeRange,TResult? Function( String format,  String userId)?  export,}) {final _that = this;
switch (_that) {
case ReportsLoad() when load != null:
return load(_that.userId,_that.range);case ReportsChangeRange() when changeRange != null:
return changeRange(_that.range);case ReportsExport() when export != null:
return export(_that.format,_that.userId);case _:
  return null;

}
}

}

/// @nodoc


class ReportsLoad implements ReportsEvent {
  const ReportsLoad({required this.userId, this.range = 'Month'});
  

 final  String userId;
@JsonKey() final  String range;

/// Create a copy of ReportsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReportsLoadCopyWith<ReportsLoad> get copyWith => _$ReportsLoadCopyWithImpl<ReportsLoad>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReportsLoad&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.range, range) || other.range == range));
}


@override
int get hashCode => Object.hash(runtimeType,userId,range);

@override
String toString() {
  return 'ReportsEvent.load(userId: $userId, range: $range)';
}


}

/// @nodoc
abstract mixin class $ReportsLoadCopyWith<$Res> implements $ReportsEventCopyWith<$Res> {
  factory $ReportsLoadCopyWith(ReportsLoad value, $Res Function(ReportsLoad) _then) = _$ReportsLoadCopyWithImpl;
@useResult
$Res call({
 String userId, String range
});




}
/// @nodoc
class _$ReportsLoadCopyWithImpl<$Res>
    implements $ReportsLoadCopyWith<$Res> {
  _$ReportsLoadCopyWithImpl(this._self, this._then);

  final ReportsLoad _self;
  final $Res Function(ReportsLoad) _then;

/// Create a copy of ReportsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? range = null,}) {
  return _then(ReportsLoad(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,range: null == range ? _self.range : range // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class ReportsChangeRange implements ReportsEvent {
  const ReportsChangeRange({required this.range});
  

 final  String range;

/// Create a copy of ReportsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReportsChangeRangeCopyWith<ReportsChangeRange> get copyWith => _$ReportsChangeRangeCopyWithImpl<ReportsChangeRange>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReportsChangeRange&&(identical(other.range, range) || other.range == range));
}


@override
int get hashCode => Object.hash(runtimeType,range);

@override
String toString() {
  return 'ReportsEvent.changeRange(range: $range)';
}


}

/// @nodoc
abstract mixin class $ReportsChangeRangeCopyWith<$Res> implements $ReportsEventCopyWith<$Res> {
  factory $ReportsChangeRangeCopyWith(ReportsChangeRange value, $Res Function(ReportsChangeRange) _then) = _$ReportsChangeRangeCopyWithImpl;
@useResult
$Res call({
 String range
});




}
/// @nodoc
class _$ReportsChangeRangeCopyWithImpl<$Res>
    implements $ReportsChangeRangeCopyWith<$Res> {
  _$ReportsChangeRangeCopyWithImpl(this._self, this._then);

  final ReportsChangeRange _self;
  final $Res Function(ReportsChangeRange) _then;

/// Create a copy of ReportsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? range = null,}) {
  return _then(ReportsChangeRange(
range: null == range ? _self.range : range // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class ReportsExport implements ReportsEvent {
  const ReportsExport({required this.format, required this.userId});
  

 final  String format;
 final  String userId;

/// Create a copy of ReportsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReportsExportCopyWith<ReportsExport> get copyWith => _$ReportsExportCopyWithImpl<ReportsExport>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReportsExport&&(identical(other.format, format) || other.format == format)&&(identical(other.userId, userId) || other.userId == userId));
}


@override
int get hashCode => Object.hash(runtimeType,format,userId);

@override
String toString() {
  return 'ReportsEvent.export(format: $format, userId: $userId)';
}


}

/// @nodoc
abstract mixin class $ReportsExportCopyWith<$Res> implements $ReportsEventCopyWith<$Res> {
  factory $ReportsExportCopyWith(ReportsExport value, $Res Function(ReportsExport) _then) = _$ReportsExportCopyWithImpl;
@useResult
$Res call({
 String format, String userId
});




}
/// @nodoc
class _$ReportsExportCopyWithImpl<$Res>
    implements $ReportsExportCopyWith<$Res> {
  _$ReportsExportCopyWithImpl(this._self, this._then);

  final ReportsExport _self;
  final $Res Function(ReportsExport) _then;

/// Create a copy of ReportsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? format = null,Object? userId = null,}) {
  return _then(ReportsExport(
format: null == format ? _self.format : format // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
