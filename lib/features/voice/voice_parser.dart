class VoiceParseResult {
  const VoiceParseResult({
    required this.rawText,
    required this.amount,
    required this.category,
    required this.paymentMode,
    this.merchant,
    this.note,
  });

  final String rawText;
  final double? amount;
  final String category;
  final String paymentMode;
  final String? merchant;
  final String? note;
}

class VoiceParser {
  static const Map<String, List<String>> _categoryKeywords =
      <String, List<String>>{
        'Food': <String>[
          'dinner',
          'lunch',
          'breakfast',
          'food',
          'restaurant',
          'zomato',
          'swiggy',
          'cafe',
        ],
        'Transport': <String>[
          'petrol',
          'fuel',
          'uber',
          'ola',
          'metro',
          'bus',
          'taxi',
        ],
        'Shopping': <String>[
          'amazon',
          'flipkart',
          'shopping',
          'bought',
          'purchase',
          'mall',
        ],
        'Health': <String>[
          'doctor',
          'medicine',
          'pharmacy',
          'hospital',
          'clinic',
        ],
        'Bills': <String>[
          'bill',
          'electricity',
          'internet',
          'rent',
          'emi',
          'subscription',
        ],
      };

  static VoiceParseResult parse(String transcript) {
    final normalized = transcript.trim();
    final lowered = normalized.toLowerCase();

    final amountMatch = RegExp(
      r'(\d{1,3}(?:[,\s]\d{3})*(?:\.\d+)?|\d+(?:\.\d+)?)\s*(rupees?|rs\.?|inr|₹)?',
      caseSensitive: false,
    ).firstMatch(lowered);

    double? amount;
    if (amountMatch != null) {
      final raw = (amountMatch.group(1) ?? '')
          .replaceAll(',', '')
          .replaceAll(' ', '');
      amount = double.tryParse(raw);
    }

    String category = 'Others';
    for (final entry in _categoryKeywords.entries) {
      if (entry.value.any(lowered.contains)) {
        category = entry.key;
        break;
      }
    }

    String paymentMode = 'other';
    if (lowered.contains('upi')) {
      paymentMode = 'upi';
    } else if (lowered.contains('card') ||
        lowered.contains('credit') ||
        lowered.contains('debit')) {
      paymentMode = 'card';
    } else if (lowered.contains('cash')) {
      paymentMode = 'cash';
    } else if (lowered.contains('netbanking') ||
        lowered.contains('net banking')) {
      paymentMode = 'netbanking';
    }

    final merchantMatch = RegExp(
      r'\bat\s+([a-zA-Z][a-zA-Z0-9\s&\-\.]{1,40})',
      caseSensitive: false,
    ).firstMatch(normalized);
    final merchant = merchantMatch?.group(1)?.trim();

    return VoiceParseResult(
      rawText: normalized,
      amount: amount,
      category: category,
      paymentMode: paymentMode,
      merchant: merchant,
      note: normalized.isEmpty ? null : normalized,
    );
  }
}
