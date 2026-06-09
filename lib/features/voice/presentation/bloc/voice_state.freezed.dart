// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'voice_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$VoiceState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VoiceState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'VoiceState()';
}


}

/// @nodoc
class $VoiceStateCopyWith<$Res>  {
$VoiceStateCopyWith(VoiceState _, $Res Function(VoiceState) __);
}


/// Adds pattern-matching-related methods to [VoiceState].
extension VoiceStatePatterns on VoiceState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( VoiceIdle value)?  idle,TResult Function( VoiceInitialising value)?  initialising,TResult Function( VoiceListening value)?  listening,TResult Function( VoicePartial value)?  partial,TResult Function( VoiceProcessing value)?  processing,TResult Function( VoiceParsed value)?  parsed,TResult Function( VoiceError value)?  error,TResult Function( VoicePermissionDenied value)?  permissionDenied,required TResult orElse(),}){
final _that = this;
switch (_that) {
case VoiceIdle() when idle != null:
return idle(_that);case VoiceInitialising() when initialising != null:
return initialising(_that);case VoiceListening() when listening != null:
return listening(_that);case VoicePartial() when partial != null:
return partial(_that);case VoiceProcessing() when processing != null:
return processing(_that);case VoiceParsed() when parsed != null:
return parsed(_that);case VoiceError() when error != null:
return error(_that);case VoicePermissionDenied() when permissionDenied != null:
return permissionDenied(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( VoiceIdle value)  idle,required TResult Function( VoiceInitialising value)  initialising,required TResult Function( VoiceListening value)  listening,required TResult Function( VoicePartial value)  partial,required TResult Function( VoiceProcessing value)  processing,required TResult Function( VoiceParsed value)  parsed,required TResult Function( VoiceError value)  error,required TResult Function( VoicePermissionDenied value)  permissionDenied,}){
final _that = this;
switch (_that) {
case VoiceIdle():
return idle(_that);case VoiceInitialising():
return initialising(_that);case VoiceListening():
return listening(_that);case VoicePartial():
return partial(_that);case VoiceProcessing():
return processing(_that);case VoiceParsed():
return parsed(_that);case VoiceError():
return error(_that);case VoicePermissionDenied():
return permissionDenied(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( VoiceIdle value)?  idle,TResult? Function( VoiceInitialising value)?  initialising,TResult? Function( VoiceListening value)?  listening,TResult? Function( VoicePartial value)?  partial,TResult? Function( VoiceProcessing value)?  processing,TResult? Function( VoiceParsed value)?  parsed,TResult? Function( VoiceError value)?  error,TResult? Function( VoicePermissionDenied value)?  permissionDenied,}){
final _that = this;
switch (_that) {
case VoiceIdle() when idle != null:
return idle(_that);case VoiceInitialising() when initialising != null:
return initialising(_that);case VoiceListening() when listening != null:
return listening(_that);case VoicePartial() when partial != null:
return partial(_that);case VoiceProcessing() when processing != null:
return processing(_that);case VoiceParsed() when parsed != null:
return parsed(_that);case VoiceError() when error != null:
return error(_that);case VoicePermissionDenied() when permissionDenied != null:
return permissionDenied(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  idle,TResult Function()?  initialising,TResult Function( String transcript)?  listening,TResult Function( String transcript)?  partial,TResult Function()?  processing,TResult Function( VoiceParseResult result,  String rawTranscript)?  parsed,TResult Function( Failure failure)?  error,TResult Function()?  permissionDenied,required TResult orElse(),}) {final _that = this;
switch (_that) {
case VoiceIdle() when idle != null:
return idle();case VoiceInitialising() when initialising != null:
return initialising();case VoiceListening() when listening != null:
return listening(_that.transcript);case VoicePartial() when partial != null:
return partial(_that.transcript);case VoiceProcessing() when processing != null:
return processing();case VoiceParsed() when parsed != null:
return parsed(_that.result,_that.rawTranscript);case VoiceError() when error != null:
return error(_that.failure);case VoicePermissionDenied() when permissionDenied != null:
return permissionDenied();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  idle,required TResult Function()  initialising,required TResult Function( String transcript)  listening,required TResult Function( String transcript)  partial,required TResult Function()  processing,required TResult Function( VoiceParseResult result,  String rawTranscript)  parsed,required TResult Function( Failure failure)  error,required TResult Function()  permissionDenied,}) {final _that = this;
switch (_that) {
case VoiceIdle():
return idle();case VoiceInitialising():
return initialising();case VoiceListening():
return listening(_that.transcript);case VoicePartial():
return partial(_that.transcript);case VoiceProcessing():
return processing();case VoiceParsed():
return parsed(_that.result,_that.rawTranscript);case VoiceError():
return error(_that.failure);case VoicePermissionDenied():
return permissionDenied();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  idle,TResult? Function()?  initialising,TResult? Function( String transcript)?  listening,TResult? Function( String transcript)?  partial,TResult? Function()?  processing,TResult? Function( VoiceParseResult result,  String rawTranscript)?  parsed,TResult? Function( Failure failure)?  error,TResult? Function()?  permissionDenied,}) {final _that = this;
switch (_that) {
case VoiceIdle() when idle != null:
return idle();case VoiceInitialising() when initialising != null:
return initialising();case VoiceListening() when listening != null:
return listening(_that.transcript);case VoicePartial() when partial != null:
return partial(_that.transcript);case VoiceProcessing() when processing != null:
return processing();case VoiceParsed() when parsed != null:
return parsed(_that.result,_that.rawTranscript);case VoiceError() when error != null:
return error(_that.failure);case VoicePermissionDenied() when permissionDenied != null:
return permissionDenied();case _:
  return null;

}
}

}

/// @nodoc


class VoiceIdle implements VoiceState {
  const VoiceIdle();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VoiceIdle);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'VoiceState.idle()';
}


}




/// @nodoc


class VoiceInitialising implements VoiceState {
  const VoiceInitialising();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VoiceInitialising);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'VoiceState.initialising()';
}


}




/// @nodoc


class VoiceListening implements VoiceState {
  const VoiceListening({this.transcript = ''});
  

@JsonKey() final  String transcript;

/// Create a copy of VoiceState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VoiceListeningCopyWith<VoiceListening> get copyWith => _$VoiceListeningCopyWithImpl<VoiceListening>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VoiceListening&&(identical(other.transcript, transcript) || other.transcript == transcript));
}


@override
int get hashCode => Object.hash(runtimeType,transcript);

@override
String toString() {
  return 'VoiceState.listening(transcript: $transcript)';
}


}

/// @nodoc
abstract mixin class $VoiceListeningCopyWith<$Res> implements $VoiceStateCopyWith<$Res> {
  factory $VoiceListeningCopyWith(VoiceListening value, $Res Function(VoiceListening) _then) = _$VoiceListeningCopyWithImpl;
@useResult
$Res call({
 String transcript
});




}
/// @nodoc
class _$VoiceListeningCopyWithImpl<$Res>
    implements $VoiceListeningCopyWith<$Res> {
  _$VoiceListeningCopyWithImpl(this._self, this._then);

  final VoiceListening _self;
  final $Res Function(VoiceListening) _then;

/// Create a copy of VoiceState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? transcript = null,}) {
  return _then(VoiceListening(
transcript: null == transcript ? _self.transcript : transcript // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class VoicePartial implements VoiceState {
  const VoicePartial({required this.transcript});
  

 final  String transcript;

/// Create a copy of VoiceState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VoicePartialCopyWith<VoicePartial> get copyWith => _$VoicePartialCopyWithImpl<VoicePartial>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VoicePartial&&(identical(other.transcript, transcript) || other.transcript == transcript));
}


@override
int get hashCode => Object.hash(runtimeType,transcript);

@override
String toString() {
  return 'VoiceState.partial(transcript: $transcript)';
}


}

/// @nodoc
abstract mixin class $VoicePartialCopyWith<$Res> implements $VoiceStateCopyWith<$Res> {
  factory $VoicePartialCopyWith(VoicePartial value, $Res Function(VoicePartial) _then) = _$VoicePartialCopyWithImpl;
@useResult
$Res call({
 String transcript
});




}
/// @nodoc
class _$VoicePartialCopyWithImpl<$Res>
    implements $VoicePartialCopyWith<$Res> {
  _$VoicePartialCopyWithImpl(this._self, this._then);

  final VoicePartial _self;
  final $Res Function(VoicePartial) _then;

/// Create a copy of VoiceState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? transcript = null,}) {
  return _then(VoicePartial(
transcript: null == transcript ? _self.transcript : transcript // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class VoiceProcessing implements VoiceState {
  const VoiceProcessing();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VoiceProcessing);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'VoiceState.processing()';
}


}




/// @nodoc


class VoiceParsed implements VoiceState {
  const VoiceParsed({required this.result, required this.rawTranscript});
  

 final  VoiceParseResult result;
 final  String rawTranscript;

/// Create a copy of VoiceState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VoiceParsedCopyWith<VoiceParsed> get copyWith => _$VoiceParsedCopyWithImpl<VoiceParsed>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VoiceParsed&&(identical(other.result, result) || other.result == result)&&(identical(other.rawTranscript, rawTranscript) || other.rawTranscript == rawTranscript));
}


@override
int get hashCode => Object.hash(runtimeType,result,rawTranscript);

@override
String toString() {
  return 'VoiceState.parsed(result: $result, rawTranscript: $rawTranscript)';
}


}

/// @nodoc
abstract mixin class $VoiceParsedCopyWith<$Res> implements $VoiceStateCopyWith<$Res> {
  factory $VoiceParsedCopyWith(VoiceParsed value, $Res Function(VoiceParsed) _then) = _$VoiceParsedCopyWithImpl;
@useResult
$Res call({
 VoiceParseResult result, String rawTranscript
});




}
/// @nodoc
class _$VoiceParsedCopyWithImpl<$Res>
    implements $VoiceParsedCopyWith<$Res> {
  _$VoiceParsedCopyWithImpl(this._self, this._then);

  final VoiceParsed _self;
  final $Res Function(VoiceParsed) _then;

/// Create a copy of VoiceState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? result = null,Object? rawTranscript = null,}) {
  return _then(VoiceParsed(
result: null == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as VoiceParseResult,rawTranscript: null == rawTranscript ? _self.rawTranscript : rawTranscript // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class VoiceError implements VoiceState {
  const VoiceError({required this.failure});
  

 final  Failure failure;

/// Create a copy of VoiceState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VoiceErrorCopyWith<VoiceError> get copyWith => _$VoiceErrorCopyWithImpl<VoiceError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VoiceError&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,failure);

@override
String toString() {
  return 'VoiceState.error(failure: $failure)';
}


}

/// @nodoc
abstract mixin class $VoiceErrorCopyWith<$Res> implements $VoiceStateCopyWith<$Res> {
  factory $VoiceErrorCopyWith(VoiceError value, $Res Function(VoiceError) _then) = _$VoiceErrorCopyWithImpl;
@useResult
$Res call({
 Failure failure
});


$FailureCopyWith<$Res> get failure;

}
/// @nodoc
class _$VoiceErrorCopyWithImpl<$Res>
    implements $VoiceErrorCopyWith<$Res> {
  _$VoiceErrorCopyWithImpl(this._self, this._then);

  final VoiceError _self;
  final $Res Function(VoiceError) _then;

/// Create a copy of VoiceState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? failure = null,}) {
  return _then(VoiceError(
failure: null == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure,
  ));
}

/// Create a copy of VoiceState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FailureCopyWith<$Res> get failure {
  
  return $FailureCopyWith<$Res>(_self.failure, (value) {
    return _then(_self.copyWith(failure: value));
  });
}
}

/// @nodoc


class VoicePermissionDenied implements VoiceState {
  const VoicePermissionDenied();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VoicePermissionDenied);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'VoiceState.permissionDenied()';
}


}




// dart format on
