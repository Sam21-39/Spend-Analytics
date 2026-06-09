// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'budget_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BudgetEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BudgetEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'BudgetEvent()';
}


}

/// @nodoc
class $BudgetEventCopyWith<$Res>  {
$BudgetEventCopyWith(BudgetEvent _, $Res Function(BudgetEvent) __);
}


/// Adds pattern-matching-related methods to [BudgetEvent].
extension BudgetEventPatterns on BudgetEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( BudgetLoad value)?  load,TResult Function( BudgetUpsert value)?  upsert,TResult Function( BudgetArchive value)?  archive,TResult Function( BudgetSeedDefaults value)?  seedDefaults,required TResult orElse(),}){
final _that = this;
switch (_that) {
case BudgetLoad() when load != null:
return load(_that);case BudgetUpsert() when upsert != null:
return upsert(_that);case BudgetArchive() when archive != null:
return archive(_that);case BudgetSeedDefaults() when seedDefaults != null:
return seedDefaults(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( BudgetLoad value)  load,required TResult Function( BudgetUpsert value)  upsert,required TResult Function( BudgetArchive value)  archive,required TResult Function( BudgetSeedDefaults value)  seedDefaults,}){
final _that = this;
switch (_that) {
case BudgetLoad():
return load(_that);case BudgetUpsert():
return upsert(_that);case BudgetArchive():
return archive(_that);case BudgetSeedDefaults():
return seedDefaults(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( BudgetLoad value)?  load,TResult? Function( BudgetUpsert value)?  upsert,TResult? Function( BudgetArchive value)?  archive,TResult? Function( BudgetSeedDefaults value)?  seedDefaults,}){
final _that = this;
switch (_that) {
case BudgetLoad() when load != null:
return load(_that);case BudgetUpsert() when upsert != null:
return upsert(_that);case BudgetArchive() when archive != null:
return archive(_that);case BudgetSeedDefaults() when seedDefaults != null:
return seedDefaults(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String userId,  int month,  int year)?  load,TResult Function( BudgetEntity budget)?  upsert,TResult Function( String id,  String userId)?  archive,TResult Function( String userId,  int month,  int year)?  seedDefaults,required TResult orElse(),}) {final _that = this;
switch (_that) {
case BudgetLoad() when load != null:
return load(_that.userId,_that.month,_that.year);case BudgetUpsert() when upsert != null:
return upsert(_that.budget);case BudgetArchive() when archive != null:
return archive(_that.id,_that.userId);case BudgetSeedDefaults() when seedDefaults != null:
return seedDefaults(_that.userId,_that.month,_that.year);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String userId,  int month,  int year)  load,required TResult Function( BudgetEntity budget)  upsert,required TResult Function( String id,  String userId)  archive,required TResult Function( String userId,  int month,  int year)  seedDefaults,}) {final _that = this;
switch (_that) {
case BudgetLoad():
return load(_that.userId,_that.month,_that.year);case BudgetUpsert():
return upsert(_that.budget);case BudgetArchive():
return archive(_that.id,_that.userId);case BudgetSeedDefaults():
return seedDefaults(_that.userId,_that.month,_that.year);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String userId,  int month,  int year)?  load,TResult? Function( BudgetEntity budget)?  upsert,TResult? Function( String id,  String userId)?  archive,TResult? Function( String userId,  int month,  int year)?  seedDefaults,}) {final _that = this;
switch (_that) {
case BudgetLoad() when load != null:
return load(_that.userId,_that.month,_that.year);case BudgetUpsert() when upsert != null:
return upsert(_that.budget);case BudgetArchive() when archive != null:
return archive(_that.id,_that.userId);case BudgetSeedDefaults() when seedDefaults != null:
return seedDefaults(_that.userId,_that.month,_that.year);case _:
  return null;

}
}

}

/// @nodoc


class BudgetLoad implements BudgetEvent {
  const BudgetLoad({required this.userId, required this.month, required this.year});
  

 final  String userId;
 final  int month;
 final  int year;

/// Create a copy of BudgetEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BudgetLoadCopyWith<BudgetLoad> get copyWith => _$BudgetLoadCopyWithImpl<BudgetLoad>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BudgetLoad&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.month, month) || other.month == month)&&(identical(other.year, year) || other.year == year));
}


@override
int get hashCode => Object.hash(runtimeType,userId,month,year);

@override
String toString() {
  return 'BudgetEvent.load(userId: $userId, month: $month, year: $year)';
}


}

/// @nodoc
abstract mixin class $BudgetLoadCopyWith<$Res> implements $BudgetEventCopyWith<$Res> {
  factory $BudgetLoadCopyWith(BudgetLoad value, $Res Function(BudgetLoad) _then) = _$BudgetLoadCopyWithImpl;
@useResult
$Res call({
 String userId, int month, int year
});




}
/// @nodoc
class _$BudgetLoadCopyWithImpl<$Res>
    implements $BudgetLoadCopyWith<$Res> {
  _$BudgetLoadCopyWithImpl(this._self, this._then);

  final BudgetLoad _self;
  final $Res Function(BudgetLoad) _then;

/// Create a copy of BudgetEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? month = null,Object? year = null,}) {
  return _then(BudgetLoad(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,month: null == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as int,year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class BudgetUpsert implements BudgetEvent {
  const BudgetUpsert({required this.budget});
  

 final  BudgetEntity budget;

/// Create a copy of BudgetEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BudgetUpsertCopyWith<BudgetUpsert> get copyWith => _$BudgetUpsertCopyWithImpl<BudgetUpsert>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BudgetUpsert&&(identical(other.budget, budget) || other.budget == budget));
}


@override
int get hashCode => Object.hash(runtimeType,budget);

@override
String toString() {
  return 'BudgetEvent.upsert(budget: $budget)';
}


}

/// @nodoc
abstract mixin class $BudgetUpsertCopyWith<$Res> implements $BudgetEventCopyWith<$Res> {
  factory $BudgetUpsertCopyWith(BudgetUpsert value, $Res Function(BudgetUpsert) _then) = _$BudgetUpsertCopyWithImpl;
@useResult
$Res call({
 BudgetEntity budget
});


$BudgetEntityCopyWith<$Res> get budget;

}
/// @nodoc
class _$BudgetUpsertCopyWithImpl<$Res>
    implements $BudgetUpsertCopyWith<$Res> {
  _$BudgetUpsertCopyWithImpl(this._self, this._then);

  final BudgetUpsert _self;
  final $Res Function(BudgetUpsert) _then;

/// Create a copy of BudgetEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? budget = null,}) {
  return _then(BudgetUpsert(
budget: null == budget ? _self.budget : budget // ignore: cast_nullable_to_non_nullable
as BudgetEntity,
  ));
}

/// Create a copy of BudgetEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BudgetEntityCopyWith<$Res> get budget {
  
  return $BudgetEntityCopyWith<$Res>(_self.budget, (value) {
    return _then(_self.copyWith(budget: value));
  });
}
}

/// @nodoc


class BudgetArchive implements BudgetEvent {
  const BudgetArchive({required this.id, required this.userId});
  

 final  String id;
 final  String userId;

/// Create a copy of BudgetEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BudgetArchiveCopyWith<BudgetArchive> get copyWith => _$BudgetArchiveCopyWithImpl<BudgetArchive>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BudgetArchive&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId));
}


@override
int get hashCode => Object.hash(runtimeType,id,userId);

@override
String toString() {
  return 'BudgetEvent.archive(id: $id, userId: $userId)';
}


}

/// @nodoc
abstract mixin class $BudgetArchiveCopyWith<$Res> implements $BudgetEventCopyWith<$Res> {
  factory $BudgetArchiveCopyWith(BudgetArchive value, $Res Function(BudgetArchive) _then) = _$BudgetArchiveCopyWithImpl;
@useResult
$Res call({
 String id, String userId
});




}
/// @nodoc
class _$BudgetArchiveCopyWithImpl<$Res>
    implements $BudgetArchiveCopyWith<$Res> {
  _$BudgetArchiveCopyWithImpl(this._self, this._then);

  final BudgetArchive _self;
  final $Res Function(BudgetArchive) _then;

/// Create a copy of BudgetEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,}) {
  return _then(BudgetArchive(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class BudgetSeedDefaults implements BudgetEvent {
  const BudgetSeedDefaults({required this.userId, required this.month, required this.year});
  

 final  String userId;
 final  int month;
 final  int year;

/// Create a copy of BudgetEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BudgetSeedDefaultsCopyWith<BudgetSeedDefaults> get copyWith => _$BudgetSeedDefaultsCopyWithImpl<BudgetSeedDefaults>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BudgetSeedDefaults&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.month, month) || other.month == month)&&(identical(other.year, year) || other.year == year));
}


@override
int get hashCode => Object.hash(runtimeType,userId,month,year);

@override
String toString() {
  return 'BudgetEvent.seedDefaults(userId: $userId, month: $month, year: $year)';
}


}

/// @nodoc
abstract mixin class $BudgetSeedDefaultsCopyWith<$Res> implements $BudgetEventCopyWith<$Res> {
  factory $BudgetSeedDefaultsCopyWith(BudgetSeedDefaults value, $Res Function(BudgetSeedDefaults) _then) = _$BudgetSeedDefaultsCopyWithImpl;
@useResult
$Res call({
 String userId, int month, int year
});




}
/// @nodoc
class _$BudgetSeedDefaultsCopyWithImpl<$Res>
    implements $BudgetSeedDefaultsCopyWith<$Res> {
  _$BudgetSeedDefaultsCopyWithImpl(this._self, this._then);

  final BudgetSeedDefaults _self;
  final $Res Function(BudgetSeedDefaults) _then;

/// Create a copy of BudgetEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? month = null,Object? year = null,}) {
  return _then(BudgetSeedDefaults(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,month: null == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as int,year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
