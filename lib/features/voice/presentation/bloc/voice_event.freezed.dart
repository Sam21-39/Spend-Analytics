// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'voice_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$VoiceEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VoiceEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'VoiceEvent()';
}


}

/// @nodoc
class $VoiceEventCopyWith<$Res>  {
$VoiceEventCopyWith(VoiceEvent _, $Res Function(VoiceEvent) __);
}


/// Adds pattern-matching-related methods to [VoiceEvent].
extension VoiceEventPatterns on VoiceEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( VoiceStart value)?  start,TResult Function( VoiceStop value)?  stop,TResult Function( VoiceUpdateTranscript value)?  updateTranscript,TResult Function( VoiceReset value)?  reset,required TResult orElse(),}){
final _that = this;
switch (_that) {
case VoiceStart() when start != null:
return start(_that);case VoiceStop() when stop != null:
return stop(_that);case VoiceUpdateTranscript() when updateTranscript != null:
return updateTranscript(_that);case VoiceReset() when reset != null:
return reset(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( VoiceStart value)  start,required TResult Function( VoiceStop value)  stop,required TResult Function( VoiceUpdateTranscript value)  updateTranscript,required TResult Function( VoiceReset value)  reset,}){
final _that = this;
switch (_that) {
case VoiceStart():
return start(_that);case VoiceStop():
return stop(_that);case VoiceUpdateTranscript():
return updateTranscript(_that);case VoiceReset():
return reset(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( VoiceStart value)?  start,TResult? Function( VoiceStop value)?  stop,TResult? Function( VoiceUpdateTranscript value)?  updateTranscript,TResult? Function( VoiceReset value)?  reset,}){
final _that = this;
switch (_that) {
case VoiceStart() when start != null:
return start(_that);case VoiceStop() when stop != null:
return stop(_that);case VoiceUpdateTranscript() when updateTranscript != null:
return updateTranscript(_that);case VoiceReset() when reset != null:
return reset(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( List<String> categories,  String transactionType)?  start,TResult Function()?  stop,TResult Function( String transcript,  bool isFinal)?  updateTranscript,TResult Function()?  reset,required TResult orElse(),}) {final _that = this;
switch (_that) {
case VoiceStart() when start != null:
return start(_that.categories,_that.transactionType);case VoiceStop() when stop != null:
return stop();case VoiceUpdateTranscript() when updateTranscript != null:
return updateTranscript(_that.transcript,_that.isFinal);case VoiceReset() when reset != null:
return reset();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( List<String> categories,  String transactionType)  start,required TResult Function()  stop,required TResult Function( String transcript,  bool isFinal)  updateTranscript,required TResult Function()  reset,}) {final _that = this;
switch (_that) {
case VoiceStart():
return start(_that.categories,_that.transactionType);case VoiceStop():
return stop();case VoiceUpdateTranscript():
return updateTranscript(_that.transcript,_that.isFinal);case VoiceReset():
return reset();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( List<String> categories,  String transactionType)?  start,TResult? Function()?  stop,TResult? Function( String transcript,  bool isFinal)?  updateTranscript,TResult? Function()?  reset,}) {final _that = this;
switch (_that) {
case VoiceStart() when start != null:
return start(_that.categories,_that.transactionType);case VoiceStop() when stop != null:
return stop();case VoiceUpdateTranscript() when updateTranscript != null:
return updateTranscript(_that.transcript,_that.isFinal);case VoiceReset() when reset != null:
return reset();case _:
  return null;

}
}

}

/// @nodoc


class VoiceStart implements VoiceEvent {
  const VoiceStart({required final  List<String> categories, this.transactionType = 'expense'}): _categories = categories;
  

 final  List<String> _categories;
 List<String> get categories {
  if (_categories is EqualUnmodifiableListView) return _categories;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_categories);
}

@JsonKey() final  String transactionType;

/// Create a copy of VoiceEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VoiceStartCopyWith<VoiceStart> get copyWith => _$VoiceStartCopyWithImpl<VoiceStart>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VoiceStart&&const DeepCollectionEquality().equals(other._categories, _categories)&&(identical(other.transactionType, transactionType) || other.transactionType == transactionType));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_categories),transactionType);

@override
String toString() {
  return 'VoiceEvent.start(categories: $categories, transactionType: $transactionType)';
}


}

/// @nodoc
abstract mixin class $VoiceStartCopyWith<$Res> implements $VoiceEventCopyWith<$Res> {
  factory $VoiceStartCopyWith(VoiceStart value, $Res Function(VoiceStart) _then) = _$VoiceStartCopyWithImpl;
@useResult
$Res call({
 List<String> categories, String transactionType
});




}
/// @nodoc
class _$VoiceStartCopyWithImpl<$Res>
    implements $VoiceStartCopyWith<$Res> {
  _$VoiceStartCopyWithImpl(this._self, this._then);

  final VoiceStart _self;
  final $Res Function(VoiceStart) _then;

/// Create a copy of VoiceEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? categories = null,Object? transactionType = null,}) {
  return _then(VoiceStart(
categories: null == categories ? _self._categories : categories // ignore: cast_nullable_to_non_nullable
as List<String>,transactionType: null == transactionType ? _self.transactionType : transactionType // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class VoiceStop implements VoiceEvent {
  const VoiceStop();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VoiceStop);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'VoiceEvent.stop()';
}


}




/// @nodoc


class VoiceUpdateTranscript implements VoiceEvent {
  const VoiceUpdateTranscript({required this.transcript, required this.isFinal});
  

 final  String transcript;
 final  bool isFinal;

/// Create a copy of VoiceEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VoiceUpdateTranscriptCopyWith<VoiceUpdateTranscript> get copyWith => _$VoiceUpdateTranscriptCopyWithImpl<VoiceUpdateTranscript>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VoiceUpdateTranscript&&(identical(other.transcript, transcript) || other.transcript == transcript)&&(identical(other.isFinal, isFinal) || other.isFinal == isFinal));
}


@override
int get hashCode => Object.hash(runtimeType,transcript,isFinal);

@override
String toString() {
  return 'VoiceEvent.updateTranscript(transcript: $transcript, isFinal: $isFinal)';
}


}

/// @nodoc
abstract mixin class $VoiceUpdateTranscriptCopyWith<$Res> implements $VoiceEventCopyWith<$Res> {
  factory $VoiceUpdateTranscriptCopyWith(VoiceUpdateTranscript value, $Res Function(VoiceUpdateTranscript) _then) = _$VoiceUpdateTranscriptCopyWithImpl;
@useResult
$Res call({
 String transcript, bool isFinal
});




}
/// @nodoc
class _$VoiceUpdateTranscriptCopyWithImpl<$Res>
    implements $VoiceUpdateTranscriptCopyWith<$Res> {
  _$VoiceUpdateTranscriptCopyWithImpl(this._self, this._then);

  final VoiceUpdateTranscript _self;
  final $Res Function(VoiceUpdateTranscript) _then;

/// Create a copy of VoiceEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? transcript = null,Object? isFinal = null,}) {
  return _then(VoiceUpdateTranscript(
transcript: null == transcript ? _self.transcript : transcript // ignore: cast_nullable_to_non_nullable
as String,isFinal: null == isFinal ? _self.isFinal : isFinal // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class VoiceReset implements VoiceEvent {
  const VoiceReset();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VoiceReset);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'VoiceEvent.reset()';
}


}




// dart format on
