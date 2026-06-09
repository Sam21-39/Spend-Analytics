import 'package:freezed_annotation/freezed_annotation.dart';

part 'voice_event.freezed.dart';

@freezed
sealed class VoiceEvent with _$VoiceEvent {
  const factory VoiceEvent.start({
    required List<String> categories,
    @Default('expense') String transactionType,
  }) = VoiceStart;
  const factory VoiceEvent.stop() = VoiceStop;
  const factory VoiceEvent.updateTranscript({
    required String transcript,
    required bool isFinal,
  }) = VoiceUpdateTranscript;
  const factory VoiceEvent.reset() = VoiceReset;
}
