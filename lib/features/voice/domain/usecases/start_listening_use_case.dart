import 'package:injectable/injectable.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:spend_analytics/core/constants/app_constants.dart';

@injectable
class StartListeningUseCase {
  const StartListeningUseCase(this._speechToText);
  final SpeechToText _speechToText;

  /// Initialises speech recognition and starts listening.
  /// Returns false if the platform does not support speech recognition.
  Future<bool> call({
    required void Function(String transcript) onResult,
    Duration listenFor = const Duration(
      seconds: AppConstants.voiceListenMaxSeconds,
    ),
    Duration pauseFor = const Duration(
      seconds: AppConstants.voicePauseThresholdSeconds,
    ),
  }) async {
    final available = await _speechToText.initialize();
    if (!available) return false;
    await _speechToText.listen(
      onResult: (result) => onResult(result.recognizedWords),
      listenOptions: SpeechListenOptions(
        listenFor: listenFor,
        pauseFor: pauseFor,
      ),
    );
    return true;
  }
}
