import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart'
    as permission_handler;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:spend_analytics/core/firebase/crashlytics_service.dart';
import 'package:spend_analytics/features/auth/auth_controller.dart';
import 'package:spend_analytics/features/categories/category_controller.dart';
import 'package:spend_analytics/features/settings/settings_controller.dart';
import 'package:spend_analytics/features/transactions/transaction_controller.dart';
import 'package:spend_analytics/features/voice/voice_parser.dart';
import 'package:spend_analytics/shared/models/transaction_model.dart';
import 'package:uuid/uuid.dart';

class VoiceController extends GetxController {
  final SpeechToText _speechToText = SpeechToText();
  final CrashlyticsService _crashlytics = Get.find<CrashlyticsService>();

  final isSpeechAvailable = false.obs;
  final isListening = false.obs;
  final voiceEntryEnabled = true.obs;
  final transcript = ''.obs;
  final amountText = ''.obs;
  final category = 'Others'.obs;
  final paymentMode = 'other'.obs;
  final type = 'expense'.obs;
  final note = ''.obs;

  /// Uses CategoryController's expense categories so voice always matches
  /// the same list used across all other screens.
  List<String> get categories {
    if (Get.isRegistered<CategoryController>()) {
      return Get.find<CategoryController>().categoriesForType('expense');
    }
    return const <String>[
      'Food',
      'Groceries',
      'Transport',
      'Shopping',
      'Bills',
      'Health',
      'Others',
    ];
  }

  TransactionController get _txnController {
    if (Get.isRegistered<TransactionController>()) {
      return Get.find<TransactionController>();
    }
    return Get.put(TransactionController());
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    await _hydrateVoiceEntryPreference();
  }

  Future<void> _hydrateVoiceEntryPreference() async {
    final prefs = await SharedPreferences.getInstance();
    voiceEntryEnabled.value =
        prefs.getBool(SettingsController.voiceEntryPreferenceKey) ?? true;
  }

  Future<void> refreshVoiceEntryAvailability() async {
    await _hydrateVoiceEntryPreference();
  }

  Future<bool> _ensureMicrophoneReady() async {
    try {
      final available = await _speechToText.initialize(
        onError: (error) => isListening.value = false,
        onStatus: (status) {
          if (status == 'notListening' || status == 'done') {
            isListening.value = false;
            _parseTranscript();
          }
        },
      );
      isSpeechAvailable.value = available;
      if (!available) {
        Get.snackbar(
          'Microphone permission needed',
          'Enable microphone access in app settings to use voice entry.',
        );
        await permission_handler.openAppSettings();
      }
      return available;
    } catch (error, stack) {
      await _crashlytics.recordError(
        error,
        stack,
        customKeys: const <String, Object?>{'action': 'voice_init'},
      );
      isSpeechAvailable.value = false;
      return false;
    }
  }

  Future<void> startListening() async {
    await refreshVoiceEntryAvailability();
    if (!voiceEntryEnabled.value) {
      Get.snackbar(
        'Voice entry is off',
        'Enable Voice Entry (Beta) from Settings to continue.',
      );
      return;
    }
    if (isListening.value) {
      return;
    }

    final isReady = await _ensureMicrophoneReady();
    if (!isReady) {
      return;
    }

    transcript.value = '';
    // ignore: deprecated_member_use
    await _speechToText.listen(
      onResult: _onSpeechResult,
      // ignore: deprecated_member_use
      listenFor: const Duration(seconds: 35),
      // ignore: deprecated_member_use
      pauseFor: const Duration(seconds: 2), // Reduced from 3s → snappier UX
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
    final parsed = VoiceParser.parse(
      transcript.value,
      availableCategories: categories,
    );
    if (parsed.amount != null) {
      amountText.value = parsed.amount!.toStringAsFixed(2);
    }
    category.value = parsed.category;
    paymentMode.value = parsed.paymentMode;
    type.value = parsed.type;
    note.value = parsed.note ?? '';
  }

  Future<void> saveParsedTransaction() async {
    final amount = double.tryParse(amountText.value.trim());
    if (amount == null || amount <= 0) {
      Get.snackbar('Invalid Amount', 'Please capture or edit a valid amount.');
      return;
    }
    if (amount > 9999999) {
      Get.snackbar(
        'Amount Too Large',
        'Amount cannot exceed ₹99,99,999.',
      );
      return;
    }

    final auth = Get.find<AuthController>();
    final txn = TransactionModel(
      id: const Uuid().v4(),
      userId: auth.resolveActiveUserId(),
      amount: amount,
      type: type.value,
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
