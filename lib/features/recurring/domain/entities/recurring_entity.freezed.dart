// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recurring_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RecurringEntity {

 String get id; String get userId; String get title; double get amount; String get category; PaymentType get paymentType; RecurringFrequency get frequency; DateTime get nextDueDate; bool get isActive; DateTime get createdAt; DateTime get updatedAt; bool get isDeleted; DateTime? get deletedAt;
/// Create a copy of RecurringEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RecurringEntityCopyWith<RecurringEntity> get copyWith => _$RecurringEntityCopyWithImpl<RecurringEntity>(this as RecurringEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RecurringEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.title, title) || other.title == title)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.category, category) || other.category == category)&&(identical(other.paymentType, paymentType) || other.paymentType == paymentType)&&(identical(other.frequency, frequency) || other.frequency == frequency)&&(identical(other.nextDueDate, nextDueDate) || other.nextDueDate == nextDueDate)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.isDeleted, isDeleted) || other.isDeleted == isDeleted)&&(identical(other.deletedAt, deletedAt) || other.deletedAt == deletedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,userId,title,amount,category,paymentType,frequency,nextDueDate,isActive,createdAt,updatedAt,isDeleted,deletedAt);

@override
String toString() {
  return 'RecurringEntity(id: $id, userId: $userId, title: $title, amount: $amount, category: $category, paymentType: $paymentType, frequency: $frequency, nextDueDate: $nextDueDate, isActive: $isActive, createdAt: $createdAt, updatedAt: $updatedAt, isDeleted: $isDeleted, deletedAt: $deletedAt)';
}


}

/// @nodoc
abstract mixin class $RecurringEntityCopyWith<$Res>  {
  factory $RecurringEntityCopyWith(RecurringEntity value, $Res Function(RecurringEntity) _then) = _$RecurringEntityCopyWithImpl;
@useResult
$Res call({
 String id, String userId, String title, double amount, String category, PaymentType paymentType, RecurringFrequency frequency, DateTime nextDueDate, bool isActive, DateTime createdAt, DateTime updatedAt, bool isDeleted, DateTime? deletedAt
});




}
/// @nodoc
class _$RecurringEntityCopyWithImpl<$Res>
    implements $RecurringEntityCopyWith<$Res> {
  _$RecurringEntityCopyWithImpl(this._self, this._then);

  final RecurringEntity _self;
  final $Res Function(RecurringEntity) _then;

/// Create a copy of RecurringEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? title = null,Object? amount = null,Object? category = null,Object? paymentType = null,Object? frequency = null,Object? nextDueDate = null,Object? isActive = null,Object? createdAt = null,Object? updatedAt = null,Object? isDeleted = null,Object? deletedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,paymentType: null == paymentType ? _self.paymentType : paymentType // ignore: cast_nullable_to_non_nullable
as PaymentType,frequency: null == frequency ? _self.frequency : frequency // ignore: cast_nullable_to_non_nullable
as RecurringFrequency,nextDueDate: null == nextDueDate ? _self.nextDueDate : nextDueDate // ignore: cast_nullable_to_non_nullable
as DateTime,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,isDeleted: null == isDeleted ? _self.isDeleted : isDeleted // ignore: cast_nullable_to_non_nullable
as bool,deletedAt: freezed == deletedAt ? _self.deletedAt : deletedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [RecurringEntity].
extension RecurringEntityPatterns on RecurringEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RecurringEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RecurringEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RecurringEntity value)  $default,){
final _that = this;
switch (_that) {
case _RecurringEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RecurringEntity value)?  $default,){
final _that = this;
switch (_that) {
case _RecurringEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String userId,  String title,  double amount,  String category,  PaymentType paymentType,  RecurringFrequency frequency,  DateTime nextDueDate,  bool isActive,  DateTime createdAt,  DateTime updatedAt,  bool isDeleted,  DateTime? deletedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RecurringEntity() when $default != null:
return $default(_that.id,_that.userId,_that.title,_that.amount,_that.category,_that.paymentType,_that.frequency,_that.nextDueDate,_that.isActive,_that.createdAt,_that.updatedAt,_that.isDeleted,_that.deletedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String userId,  String title,  double amount,  String category,  PaymentType paymentType,  RecurringFrequency frequency,  DateTime nextDueDate,  bool isActive,  DateTime createdAt,  DateTime updatedAt,  bool isDeleted,  DateTime? deletedAt)  $default,) {final _that = this;
switch (_that) {
case _RecurringEntity():
return $default(_that.id,_that.userId,_that.title,_that.amount,_that.category,_that.paymentType,_that.frequency,_that.nextDueDate,_that.isActive,_that.createdAt,_that.updatedAt,_that.isDeleted,_that.deletedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String userId,  String title,  double amount,  String category,  PaymentType paymentType,  RecurringFrequency frequency,  DateTime nextDueDate,  bool isActive,  DateTime createdAt,  DateTime updatedAt,  bool isDeleted,  DateTime? deletedAt)?  $default,) {final _that = this;
switch (_that) {
case _RecurringEntity() when $default != null:
return $default(_that.id,_that.userId,_that.title,_that.amount,_that.category,_that.paymentType,_that.frequency,_that.nextDueDate,_that.isActive,_that.createdAt,_that.updatedAt,_that.isDeleted,_that.deletedAt);case _:
  return null;

}
}

}

/// @nodoc


class _RecurringEntity implements RecurringEntity {
  const _RecurringEntity({required this.id, required this.userId, required this.title, required this.amount, required this.category, this.paymentType = PaymentType.other, this.frequency = RecurringFrequency.monthly, required this.nextDueDate, this.isActive = true, required this.createdAt, required this.updatedAt, this.isDeleted = false, this.deletedAt});
  

@override final  String id;
@override final  String userId;
@override final  String title;
@override final  double amount;
@override final  String category;
@override@JsonKey() final  PaymentType paymentType;
@override@JsonKey() final  RecurringFrequency frequency;
@override final  DateTime nextDueDate;
@override@JsonKey() final  bool isActive;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;
@override@JsonKey() final  bool isDeleted;
@override final  DateTime? deletedAt;

/// Create a copy of RecurringEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RecurringEntityCopyWith<_RecurringEntity> get copyWith => __$RecurringEntityCopyWithImpl<_RecurringEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RecurringEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.title, title) || other.title == title)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.category, category) || other.category == category)&&(identical(other.paymentType, paymentType) || other.paymentType == paymentType)&&(identical(other.frequency, frequency) || other.frequency == frequency)&&(identical(other.nextDueDate, nextDueDate) || other.nextDueDate == nextDueDate)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.isDeleted, isDeleted) || other.isDeleted == isDeleted)&&(identical(other.deletedAt, deletedAt) || other.deletedAt == deletedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,userId,title,amount,category,paymentType,frequency,nextDueDate,isActive,createdAt,updatedAt,isDeleted,deletedAt);

@override
String toString() {
  return 'RecurringEntity(id: $id, userId: $userId, title: $title, amount: $amount, category: $category, paymentType: $paymentType, frequency: $frequency, nextDueDate: $nextDueDate, isActive: $isActive, createdAt: $createdAt, updatedAt: $updatedAt, isDeleted: $isDeleted, deletedAt: $deletedAt)';
}


}

/// @nodoc
abstract mixin class _$RecurringEntityCopyWith<$Res> implements $RecurringEntityCopyWith<$Res> {
  factory _$RecurringEntityCopyWith(_RecurringEntity value, $Res Function(_RecurringEntity) _then) = __$RecurringEntityCopyWithImpl;
@override @useResult
$Res call({
 String id, String userId, String title, double amount, String category, PaymentType paymentType, RecurringFrequency frequency, DateTime nextDueDate, bool isActive, DateTime createdAt, DateTime updatedAt, bool isDeleted, DateTime? deletedAt
});




}
/// @nodoc
class __$RecurringEntityCopyWithImpl<$Res>
    implements _$RecurringEntityCopyWith<$Res> {
  __$RecurringEntityCopyWithImpl(this._self, this._then);

  final _RecurringEntity _self;
  final $Res Function(_RecurringEntity) _then;

/// Create a copy of RecurringEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? title = null,Object? amount = null,Object? category = null,Object? paymentType = null,Object? frequency = null,Object? nextDueDate = null,Object? isActive = null,Object? createdAt = null,Object? updatedAt = null,Object? isDeleted = null,Object? deletedAt = freezed,}) {
  return _then(_RecurringEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,paymentType: null == paymentType ? _self.paymentType : paymentType // ignore: cast_nullable_to_non_nullable
as PaymentType,frequency: null == frequency ? _self.frequency : frequency // ignore: cast_nullable_to_non_nullable
as RecurringFrequency,nextDueDate: null == nextDueDate ? _self.nextDueDate : nextDueDate // ignore: cast_nullable_to_non_nullable
as DateTime,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,isDeleted: null == isDeleted ? _self.isDeleted : isDeleted // ignore: cast_nullable_to_non_nullable
as bool,deletedAt: freezed == deletedAt ? _self.deletedAt : deletedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
