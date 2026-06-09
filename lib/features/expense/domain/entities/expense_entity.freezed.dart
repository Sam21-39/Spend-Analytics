// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'expense_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ExpenseEntity {

 String get id; String get userId; double get amount; ExpenseType get expenseType; String get category; PaymentType get paymentType; DateTime get transactionDate; DateTime get updatedAt; DateTime get createdAt; String? get note; List<String> get tags;
/// Create a copy of ExpenseEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExpenseEntityCopyWith<ExpenseEntity> get copyWith => _$ExpenseEntityCopyWithImpl<ExpenseEntity>(this as ExpenseEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExpenseEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.expenseType, expenseType) || other.expenseType == expenseType)&&(identical(other.category, category) || other.category == category)&&(identical(other.paymentType, paymentType) || other.paymentType == paymentType)&&(identical(other.transactionDate, transactionDate) || other.transactionDate == transactionDate)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.note, note) || other.note == note)&&const DeepCollectionEquality().equals(other.tags, tags));
}


@override
int get hashCode => Object.hash(runtimeType,id,userId,amount,expenseType,category,paymentType,transactionDate,updatedAt,createdAt,note,const DeepCollectionEquality().hash(tags));

@override
String toString() {
  return 'ExpenseEntity(id: $id, userId: $userId, amount: $amount, expenseType: $expenseType, category: $category, paymentType: $paymentType, transactionDate: $transactionDate, updatedAt: $updatedAt, createdAt: $createdAt, note: $note, tags: $tags)';
}


}

/// @nodoc
abstract mixin class $ExpenseEntityCopyWith<$Res>  {
  factory $ExpenseEntityCopyWith(ExpenseEntity value, $Res Function(ExpenseEntity) _then) = _$ExpenseEntityCopyWithImpl;
@useResult
$Res call({
 String id, String userId, double amount, ExpenseType expenseType, String category, PaymentType paymentType, DateTime transactionDate, DateTime updatedAt, DateTime createdAt, String? note, List<String> tags
});




}
/// @nodoc
class _$ExpenseEntityCopyWithImpl<$Res>
    implements $ExpenseEntityCopyWith<$Res> {
  _$ExpenseEntityCopyWithImpl(this._self, this._then);

  final ExpenseEntity _self;
  final $Res Function(ExpenseEntity) _then;

/// Create a copy of ExpenseEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? amount = null,Object? expenseType = null,Object? category = null,Object? paymentType = null,Object? transactionDate = null,Object? updatedAt = null,Object? createdAt = null,Object? note = freezed,Object? tags = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,expenseType: null == expenseType ? _self.expenseType : expenseType // ignore: cast_nullable_to_non_nullable
as ExpenseType,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,paymentType: null == paymentType ? _self.paymentType : paymentType // ignore: cast_nullable_to_non_nullable
as PaymentType,transactionDate: null == transactionDate ? _self.transactionDate : transactionDate // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,tags: null == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [ExpenseEntity].
extension ExpenseEntityPatterns on ExpenseEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ExpenseEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ExpenseEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ExpenseEntity value)  $default,){
final _that = this;
switch (_that) {
case _ExpenseEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ExpenseEntity value)?  $default,){
final _that = this;
switch (_that) {
case _ExpenseEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String userId,  double amount,  ExpenseType expenseType,  String category,  PaymentType paymentType,  DateTime transactionDate,  DateTime updatedAt,  DateTime createdAt,  String? note,  List<String> tags)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ExpenseEntity() when $default != null:
return $default(_that.id,_that.userId,_that.amount,_that.expenseType,_that.category,_that.paymentType,_that.transactionDate,_that.updatedAt,_that.createdAt,_that.note,_that.tags);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String userId,  double amount,  ExpenseType expenseType,  String category,  PaymentType paymentType,  DateTime transactionDate,  DateTime updatedAt,  DateTime createdAt,  String? note,  List<String> tags)  $default,) {final _that = this;
switch (_that) {
case _ExpenseEntity():
return $default(_that.id,_that.userId,_that.amount,_that.expenseType,_that.category,_that.paymentType,_that.transactionDate,_that.updatedAt,_that.createdAt,_that.note,_that.tags);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String userId,  double amount,  ExpenseType expenseType,  String category,  PaymentType paymentType,  DateTime transactionDate,  DateTime updatedAt,  DateTime createdAt,  String? note,  List<String> tags)?  $default,) {final _that = this;
switch (_that) {
case _ExpenseEntity() when $default != null:
return $default(_that.id,_that.userId,_that.amount,_that.expenseType,_that.category,_that.paymentType,_that.transactionDate,_that.updatedAt,_that.createdAt,_that.note,_that.tags);case _:
  return null;

}
}

}

/// @nodoc


class _ExpenseEntity implements ExpenseEntity {
  const _ExpenseEntity({required this.id, required this.userId, required this.amount, required this.expenseType, required this.category, required this.paymentType, required this.transactionDate, required this.updatedAt, required this.createdAt, this.note, final  List<String> tags = const []}): _tags = tags;
  

@override final  String id;
@override final  String userId;
@override final  double amount;
@override final  ExpenseType expenseType;
@override final  String category;
@override final  PaymentType paymentType;
@override final  DateTime transactionDate;
@override final  DateTime updatedAt;
@override final  DateTime createdAt;
@override final  String? note;
 final  List<String> _tags;
@override@JsonKey() List<String> get tags {
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tags);
}


/// Create a copy of ExpenseEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExpenseEntityCopyWith<_ExpenseEntity> get copyWith => __$ExpenseEntityCopyWithImpl<_ExpenseEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ExpenseEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.expenseType, expenseType) || other.expenseType == expenseType)&&(identical(other.category, category) || other.category == category)&&(identical(other.paymentType, paymentType) || other.paymentType == paymentType)&&(identical(other.transactionDate, transactionDate) || other.transactionDate == transactionDate)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.note, note) || other.note == note)&&const DeepCollectionEquality().equals(other._tags, _tags));
}


@override
int get hashCode => Object.hash(runtimeType,id,userId,amount,expenseType,category,paymentType,transactionDate,updatedAt,createdAt,note,const DeepCollectionEquality().hash(_tags));

@override
String toString() {
  return 'ExpenseEntity(id: $id, userId: $userId, amount: $amount, expenseType: $expenseType, category: $category, paymentType: $paymentType, transactionDate: $transactionDate, updatedAt: $updatedAt, createdAt: $createdAt, note: $note, tags: $tags)';
}


}

/// @nodoc
abstract mixin class _$ExpenseEntityCopyWith<$Res> implements $ExpenseEntityCopyWith<$Res> {
  factory _$ExpenseEntityCopyWith(_ExpenseEntity value, $Res Function(_ExpenseEntity) _then) = __$ExpenseEntityCopyWithImpl;
@override @useResult
$Res call({
 String id, String userId, double amount, ExpenseType expenseType, String category, PaymentType paymentType, DateTime transactionDate, DateTime updatedAt, DateTime createdAt, String? note, List<String> tags
});




}
/// @nodoc
class __$ExpenseEntityCopyWithImpl<$Res>
    implements _$ExpenseEntityCopyWith<$Res> {
  __$ExpenseEntityCopyWithImpl(this._self, this._then);

  final _ExpenseEntity _self;
  final $Res Function(_ExpenseEntity) _then;

/// Create a copy of ExpenseEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? amount = null,Object? expenseType = null,Object? category = null,Object? paymentType = null,Object? transactionDate = null,Object? updatedAt = null,Object? createdAt = null,Object? note = freezed,Object? tags = null,}) {
  return _then(_ExpenseEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,expenseType: null == expenseType ? _self.expenseType : expenseType // ignore: cast_nullable_to_non_nullable
as ExpenseType,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,paymentType: null == paymentType ? _self.paymentType : paymentType // ignore: cast_nullable_to_non_nullable
as PaymentType,transactionDate: null == transactionDate ? _self.transactionDate : transactionDate // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,tags: null == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
