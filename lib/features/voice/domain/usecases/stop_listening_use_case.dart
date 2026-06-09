import 'package:injectable/injectable.dart';
import 'package:speech_to_text/speech_to_text.dart';

@injectable
class StopListeningUseCase {
  const StopListeningUseCase(this._speechToText);
  final SpeechToText _speechToText;

  Future<void> call() => _speechToText.stop();
}
