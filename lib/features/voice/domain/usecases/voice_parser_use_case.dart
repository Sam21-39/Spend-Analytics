import 'package:injectable/injectable.dart';
import 'package:spend_analytics/features/voice/voice_parser.dart';

@injectable
class VoiceParserUseCase {
  const VoiceParserUseCase();

  /// Parses [transcript] into a [VoiceParseResult].
  ///
  /// Pass [transactionType] to override the parser's heuristic type detection —
  /// this fixes the income category fallthrough bug when the caller explicitly
  /// knows which transaction type is being entered.
  VoiceParseResult call(
    String transcript, {
    List<String>? availableCategories,
    String? transactionType,
  }) {
    final result = VoiceParser.parse(
      transcript,
      availableCategories: availableCategories,
    );
    if (transactionType != null && result.type != transactionType) {
      return VoiceParseResult(
        rawText: result.rawText,
        amount: result.amount,
        category: result.category,
        paymentMode: result.paymentMode,
        type: transactionType,
        merchant: result.merchant,
        note: result.note,
      );
    }
    return result;
  }
}
