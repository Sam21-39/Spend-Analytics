// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'onboarding_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$OnboardingEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OnboardingEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OnboardingEvent()';
}


}

/// @nodoc
class $OnboardingEventCopyWith<$Res>  {
$OnboardingEventCopyWith(OnboardingEvent _, $Res Function(OnboardingEvent) __);
}


/// Adds pattern-matching-related methods to [OnboardingEvent].
extension OnboardingEventPatterns on OnboardingEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( OnboardingNextStep value)?  nextStep,TResult Function( OnboardingSkip value)?  skip,TResult Function( OnboardingComplete value)?  complete,required TResult orElse(),}){
final _that = this;
switch (_that) {
case OnboardingNextStep() when nextStep != null:
return nextStep(_that);case OnboardingSkip() when skip != null:
return skip(_that);case OnboardingComplete() when complete != null:
return complete(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( OnboardingNextStep value)  nextStep,required TResult Function( OnboardingSkip value)  skip,required TResult Function( OnboardingComplete value)  complete,}){
final _that = this;
switch (_that) {
case OnboardingNextStep():
return nextStep(_that);case OnboardingSkip():
return skip(_that);case OnboardingComplete():
return complete(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( OnboardingNextStep value)?  nextStep,TResult? Function( OnboardingSkip value)?  skip,TResult? Function( OnboardingComplete value)?  complete,}){
final _that = this;
switch (_that) {
case OnboardingNextStep() when nextStep != null:
return nextStep(_that);case OnboardingSkip() when skip != null:
return skip(_that);case OnboardingComplete() when complete != null:
return complete(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  nextStep,TResult Function()?  skip,TResult Function( String userId)?  complete,required TResult orElse(),}) {final _that = this;
switch (_that) {
case OnboardingNextStep() when nextStep != null:
return nextStep();case OnboardingSkip() when skip != null:
return skip();case OnboardingComplete() when complete != null:
return complete(_that.userId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  nextStep,required TResult Function()  skip,required TResult Function( String userId)  complete,}) {final _that = this;
switch (_that) {
case OnboardingNextStep():
return nextStep();case OnboardingSkip():
return skip();case OnboardingComplete():
return complete(_that.userId);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  nextStep,TResult? Function()?  skip,TResult? Function( String userId)?  complete,}) {final _that = this;
switch (_that) {
case OnboardingNextStep() when nextStep != null:
return nextStep();case OnboardingSkip() when skip != null:
return skip();case OnboardingComplete() when complete != null:
return complete(_that.userId);case _:
  return null;

}
}

}

/// @nodoc


class OnboardingNextStep implements OnboardingEvent {
  const OnboardingNextStep();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OnboardingNextStep);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OnboardingEvent.nextStep()';
}


}




/// @nodoc


class OnboardingSkip implements OnboardingEvent {
  const OnboardingSkip();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OnboardingSkip);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OnboardingEvent.skip()';
}


}




/// @nodoc


class OnboardingComplete implements OnboardingEvent {
  const OnboardingComplete({required this.userId});
  

 final  String userId;

/// Create a copy of OnboardingEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OnboardingCompleteCopyWith<OnboardingComplete> get copyWith => _$OnboardingCompleteCopyWithImpl<OnboardingComplete>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OnboardingComplete&&(identical(other.userId, userId) || other.userId == userId));
}


@override
int get hashCode => Object.hash(runtimeType,userId);

@override
String toString() {
  return 'OnboardingEvent.complete(userId: $userId)';
}


}

/// @nodoc
abstract mixin class $OnboardingCompleteCopyWith<$Res> implements $OnboardingEventCopyWith<$Res> {
  factory $OnboardingCompleteCopyWith(OnboardingComplete value, $Res Function(OnboardingComplete) _then) = _$OnboardingCompleteCopyWithImpl;
@useResult
$Res call({
 String userId
});




}
/// @nodoc
class _$OnboardingCompleteCopyWithImpl<$Res>
    implements $OnboardingCompleteCopyWith<$Res> {
  _$OnboardingCompleteCopyWithImpl(this._self, this._then);

  final OnboardingComplete _self;
  final $Res Function(OnboardingComplete) _then;

/// Create a copy of OnboardingEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? userId = null,}) {
  return _then(OnboardingComplete(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
