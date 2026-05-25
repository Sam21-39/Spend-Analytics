import 'package:get/get.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:spend_analytics/core/firebase/crashlytics_service.dart';
import 'package:spend_analytics/features/auth/auth_controller.dart';
import 'package:spend_analytics/features/transactions/transaction_controller.dart';
import 'package:spend_analytics/features/voice/voice_parser.dart';
import 'package:spend_analytics/shared/models/transaction_model.dart';
import 'package:uuid/uuid.dart';

class VoiceController extends GetxController {
  final SpeechToText _speechToText = SpeechToText();
  final CrashlyticsService _crashlytics = Get.find<CrashlyticsService>();

  final isSpeechAvailable = false.obs;
  final isListening = false.obs;
  final transcript = ''.obs;
  final amountText = ''.obs;
  final category = 'Others'.obs;
  final paymentMode = 'other'.obs;
  final note = ''.obs;

  final categories = const <String>[
    'Food',
    'Transport',
    'Shopping',
    'Bills',
    'Health',
    'Others',
  ];

  TransactionController get _txnController {
    if (Get.isRegistered<TransactionController>()) {
      return Get.find<TransactionController>();
    }
    return Get.put(TransactionController());
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    try {
      isSpeechAvailable.value = await _speechToText.initialize(
        onError: (error) => isListening.value = false,
        onStatus: (status) {
          if (status == 'notListening' || status == 'done') {
            isListening.value = false;
            _parseTranscript();
          }
        },
      );
    } catch (error, stack) {
      await _crashlytics.recordError(
        error,
        stack,
        customKeys: const <String, Object?>{'action': 'voice_init'},
      );
      isSpeechAvailable.value = false;
    }
  }

  Future<void> startListening() async {
    if (!isSpeechAvailable.value || isListening.value) {
      return;
    }

    transcript.value = '';
    // ignore: deprecated_member_use
    await _speechToText.listen(
      onResult: _onSpeechResult,
      // ignore: deprecated_member_use
      listenFor: const Duration(seconds: 35),
      // ignore: deprecated_member_use
      pauseFor: const Duration(seconds: 3),
      // ignore: deprecated_member_use
      partialResults: true,
      // ignore: deprecated_member_use
      listenMode: ListenMode.confirmation,
    );
    isListening.value = true;
  }

  Future<void> stopListening() async {
    if (!isListening.value) {
      return;
    }

    await _speechToText.stop();
    isListening.value = false;
    _parseTranscript();
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    transcript.value = result.recognizedWords;
    if (result.finalResult) {
      _parseTranscript();
    }
  }

  void _parseTranscript() {
    final parsed = VoiceParser.parse(transcript.value);
    if (parsed.amount != null) {
      amountText.value = parsed.amount!.toStringAsFixed(2);
    }
    category.value = parsed.category;
    paymentMode.value = parsed.paymentMode;
    note.value = parsed.note ?? '';
  }

  Future<void> saveParsedTransaction() async {
    final amount = double.tryParse(amountText.value.trim());
    if (amount == null || amount <= 0) {
      Get.snackbar('Invalid Amount', 'Please capture or edit a valid amount.');
      return;
    }

    final auth = Get.find<AuthController>();
    final txn = TransactionModel(
      id: const Uuid().v4(),
      userId: auth.resolveActiveUserId(),
      amount: amount,
      type: 'expense',
      category: category.value,
      paymentMode: paymentMode.value,
      transactionDate: DateTime.now(),
      updatedAt: DateTime.now().toUtc(),
      note: note.value.trim().isEmpty ? null : note.value.trim(),
    );

    await _txnController.addTransaction(txn);
    Get.back<void>();
    Get.snackbar('Saved', 'Voice transaction saved successfully.');
  }
}
