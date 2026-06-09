import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:spend_analytics/features/voice/domain/usecases/start_listening_use_case.dart';
import 'package:spend_analytics/features/voice/domain/usecases/stop_listening_use_case.dart';
import 'package:spend_analytics/features/voice/domain/usecases/voice_parser_use_case.dart';
import 'package:spend_analytics/features/voice/voice_parser.dart';

import 'voice_event.dart';
import 'voice_state.dart';

@injectable
class VoiceBloc extends Bloc<VoiceEvent, VoiceState> {
  VoiceBloc(
    this._startListening,
    this._stopListening,
    this._voiceParser,
  ) : super(const VoiceState.idle()) {
    on<VoiceStart>(_onStart);
    on<VoiceStop>(_onStop);
    on<VoiceUpdateTranscript>(_onUpdateTranscript);
    on<VoiceReset>(_onReset);
  }

  final StartListeningUseCase _startListening;
  final StopListeningUseCase _stopListening;
  final VoiceParserUseCase _voiceParser;

  // Stored from VoiceStart so they're available when the final transcript arrives
  List<String> _categories = const [];
  String _transactionType = 'expense';

  Future<void> _onStart(VoiceStart event, Emitter<VoiceState> emit) async {
    _categories = event.categories;
    _transactionType = event.transactionType;
    emit(const VoiceState.initialising());
    final available = await _startListening(
      onResult: (transcript) => add(VoiceEvent.updateTranscript(
        transcript: transcript,
        isFinal: false,
      )),
    );
    if (!available) {
      emit(const VoiceState.permissionDenied());
      return;
    }
    emit(const VoiceState.listening(transcript: ''));
  }

  Future<void> _onStop(VoiceStop event, Emitter<VoiceState> emit) async {
    await _stopListening();
    emit(const VoiceState.idle());
  }

  Future<void> _onUpdateTranscript(
      VoiceUpdateTranscript event, Emitter<VoiceState> emit) async {
    if (!event.isFinal) {
      emit(VoiceState.partial(transcript: event.transcript));
      return;
    }
    emit(const VoiceState.processing());
    // VoiceParserUseCase is synchronous — no Either wrapper
    final VoiceParseResult parsed = _voiceParser(
      event.transcript,
      availableCategories: _categories.isNotEmpty ? _categories : null,
      transactionType: _transactionType,
    );
    emit(VoiceState.parsed(result: parsed, rawTranscript: event.transcript));
  }

  void _onReset(VoiceReset event, Emitter<VoiceState> emit) {
    emit(const VoiceState.idle());
  }
}
