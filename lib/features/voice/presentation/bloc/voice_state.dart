import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:spend_analytics/core/error/failures.dart';
import 'package:spend_analytics/features/voice/voice_parser.dart';

part 'voice_state.freezed.dart';

@freezed
sealed class VoiceState with _$VoiceState {
  const factory VoiceState.idle() = VoiceIdle;
  const factory VoiceState.initialising() = VoiceInitialising;
  const factory VoiceState.listening({@Default('') String transcript}) =
      VoiceListening;
  const factory VoiceState.partial({required String transcript}) = VoicePartial;
  const factory VoiceState.processing() = VoiceProcessing;
  const factory VoiceState.parsed({
    required VoiceParseResult result,
    required String rawTranscript,
  }) = VoiceParsed;
  const factory VoiceState.error({required Failure failure}) = VoiceError;
  const factory VoiceState.permissionDenied() = VoicePermissionDenied;
}
