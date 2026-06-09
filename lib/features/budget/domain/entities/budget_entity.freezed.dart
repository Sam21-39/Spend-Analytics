// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'budget_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BudgetEntity {

 String get id; String get userId; String get category; int get month; int get year; double get limitAmount; BudgetPeriod get period; DateTime get createdAt; DateTime get updatedAt; bool get isDeleted; DateTime? get deletedAt;
/// Create a copy of BudgetEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BudgetEntityCopyWith<BudgetEntity> get copyWith => _$BudgetEntityCopyWithImpl<BudgetEntity>(this as BudgetEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BudgetEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.category, category) || other.category == category)&&(identical(other.month, month) || other.month == month)&&(identical(other.year, year) || other.year == year)&&(identical(other.limitAmount, limitAmount) || other.limitAmount == limitAmount)&&(identical(other.period, period) || other.period == period)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.isDeleted, isDeleted) || other.isDeleted == isDeleted)&&(identical(other.deletedAt, deletedAt) || other.deletedAt == deletedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,userId,category,month,year,limitAmount,period,createdAt,updatedAt,isDeleted,deletedAt);

@override
String toString() {
  return 'BudgetEntity(id: $id, userId: $userId, category: $category, month: $month, year: $year, limitAmount: $limitAmount, period: $period, createdAt: $createdAt, updatedAt: $updatedAt, isDeleted: $isDeleted, deletedAt: $deletedAt)';
}


}

/// @nodoc
abstract mixin class $BudgetEntityCopyWith<$Res>  {
  factory $BudgetEntityCopyWith(BudgetEntity value, $Res Function(BudgetEntity) _then) = _$BudgetEntityCopyWithImpl;
@useResult
$Res call({
 String id, String userId, String category, int month, int year, double limitAmount, BudgetPeriod period, DateTime createdAt, DateTime updatedAt, bool isDeleted, DateTime? deletedAt
});




}
/// @nodoc
class _$BudgetEntityCopyWithImpl<$Res>
    implements $BudgetEntityCopyWith<$Res> {
  _$BudgetEntityCopyWithImpl(this._self, this._then);

  final BudgetEntity _self;
  final $Res Function(BudgetEntity) _then;

/// Create a copy of BudgetEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? category = null,Object? month = null,Object? year = null,Object? limitAmount = null,Object? period = null,Object? createdAt = null,Object? updatedAt = null,Object? isDeleted = null,Object? deletedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,month: null == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as int,year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,limitAmount: null == limitAmount ? _self.limitAmount : limitAmount // ignore: cast_nullable_to_non_nullable
as double,period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as BudgetPeriod,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,isDeleted: null == isDeleted ? _self.isDeleted : isDeleted // ignore: cast_nullable_to_non_nullable
as bool,deletedAt: freezed == deletedAt ? _self.deletedAt : deletedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [BudgetEntity].
extension BudgetEntityPatterns on BudgetEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BudgetEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BudgetEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BudgetEntity value)  $default,){
final _that = this;
switch (_that) {
case _BudgetEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BudgetEntity value)?  $default,){
final _that = this;
switch (_that) {
case _BudgetEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String userId,  String category,  int month,  int year,  double limitAmount,  BudgetPeriod period,  DateTime createdAt,  DateTime updatedAt,  bool isDeleted,  DateTime? deletedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BudgetEntity() when $default != null:
return $default(_that.id,_that.userId,_that.category,_that.month,_that.year,_that.limitAmount,_that.period,_that.createdAt,_that.updatedAt,_that.isDeleted,_that.deletedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String userId,  String category,  int month,  int year,  double limitAmount,  BudgetPeriod period,  DateTime createdAt,  DateTime updatedAt,  bool isDeleted,  DateTime? deletedAt)  $default,) {final _that = this;
switch (_that) {
case _BudgetEntity():
return $default(_that.id,_that.userId,_that.category,_that.month,_that.year,_that.limitAmount,_that.period,_that.createdAt,_that.updatedAt,_that.isDeleted,_that.deletedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String userId,  String category,  int month,  int year,  double limitAmount,  BudgetPeriod period,  DateTime createdAt,  DateTime updatedAt,  bool isDeleted,  DateTime? deletedAt)?  $default,) {final _that = this;
switch (_that) {
case _BudgetEntity() when $default != null:
return $default(_that.id,_that.userId,_that.category,_that.month,_that.year,_that.limitAmount,_that.period,_that.createdAt,_that.updatedAt,_that.isDeleted,_that.deletedAt);case _:
  return null;

}
}

}

/// @nodoc


class _BudgetEntity implements BudgetEntity {
  const _BudgetEntity({required this.id, required this.userId, required this.category, required this.month, required this.year, required this.limitAmount, this.period = BudgetPeriod.monthly, required this.createdAt, required this.updatedAt, this.isDeleted = false, this.deletedAt});
  

@override final  String id;
@override final  String userId;
@override final  String category;
@override final  int month;
@override final  int year;
@override final  double limitAmount;
@override@JsonKey() final  BudgetPeriod period;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;
@override@JsonKey() final  bool isDeleted;
@override final  DateTime? deletedAt;

/// Create a copy of BudgetEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BudgetEntityCopyWith<_BudgetEntity> get copyWith => __$BudgetEntityCopyWithImpl<_BudgetEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BudgetEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.category, category) || other.category == category)&&(identical(other.month, month) || other.month == month)&&(identical(other.year, year) || other.year == year)&&(identical(other.limitAmount, limitAmount) || other.limitAmount == limitAmount)&&(identical(other.period, period) || other.period == period)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.isDeleted, isDeleted) || other.isDeleted == isDeleted)&&(identical(other.deletedAt, deletedAt) || other.deletedAt == deletedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,userId,category,month,year,limitAmount,period,createdAt,updatedAt,isDeleted,deletedAt);

@override
String toString() {
  return 'BudgetEntity(id: $id, userId: $userId, category: $category, month: $month, year: $year, limitAmount: $limitAmount, period: $period, createdAt: $createdAt, updatedAt: $updatedAt, isDeleted: $isDeleted, deletedAt: $deletedAt)';
}


}

/// @nodoc
abstract mixin class _$BudgetEntityCopyWith<$Res> implements $BudgetEntityCopyWith<$Res> {
  factory _$BudgetEntityCopyWith(_BudgetEntity value, $Res Function(_BudgetEntity) _then) = __$BudgetEntityCopyWithImpl;
@override @useResult
$Res call({
 String id, String userId, String category, int month, int year, double limitAmount, BudgetPeriod period, DateTime createdAt, DateTime updatedAt, bool isDeleted, DateTime? deletedAt
});




}
/// @nodoc
class __$BudgetEntityCopyWithImpl<$Res>
    implements _$BudgetEntityCopyWith<$Res> {
  __$BudgetEntityCopyWithImpl(this._self, this._then);

  final _BudgetEntity _self;
  final $Res Function(_BudgetEntity) _then;

/// Create a copy of BudgetEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? category = null,Object? month = null,Object? year = null,Object? limitAmount = null,Object? period = null,Object? createdAt = null,Object? updatedAt = null,Object? isDeleted = null,Object? deletedAt = freezed,}) {
  return _then(_BudgetEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,month: null == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as int,year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,limitAmount: null == limitAmount ? _self.limitAmount : limitAmount // ignore: cast_nullable_to_non_nullable
as double,period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as BudgetPeriod,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,isDeleted: null == isDeleted ? _self.isDeleted : isDeleted // ignore: cast_nullable_to_non_nullable
as bool,deletedAt: freezed == deletedAt ? _self.deletedAt : deletedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
