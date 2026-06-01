class VoiceParseResult {
  const VoiceParseResult({
    required this.rawText,
    required this.amount,
    required this.category,
    required this.paymentMode,
    required this.type,
    this.merchant,
    this.note,
  });

  final String rawText;
  final double? amount;
  final String category;
  final String paymentMode;
  final String type; // 'expense' | 'income'
  final String? merchant;
  final String? note;
}

class VoiceParser {
  /// Extended keyword map — covers all default CategoryController categories.
  static const Map<String, List<String>> _categoryKeywords =
      <String, List<String>>{
        'Food': <String>[
          'food',
          'dinner',
          'lunch',
          'breakfast',
          'snack',
          'coffee',
          'tea',
          'restaurant',
          'cafe',
          'zomato',
          'swiggy',
          'blinkit',
          'dineout',
          'eating',
          'meal',
          'pizza',
          'burger',
          'biryani',
        ],
        'Groceries': <String>[
          'grocery',
          'groceries',
          'supermarket',
          'bigbasket',
          'grofers',
          'zepto',
          'vegetables',
          'fruits',
          'milk',
          'bread',
          'flour',
        ],
        'Transport': <String>[
          'petrol',
          'fuel',
          'diesel',
          'uber',
          'ola',
          'rapido',
          'metro',
          'bus',
          'auto',
          'cab',
          'taxi',
          'train',
          'ticket',
          'toll',
          'parking',
          'commute',
          'travel',
        ],
        'Shopping': <String>[
          'amazon',
          'flipkart',
          'myntra',
          'meesho',
          'ajio',
          'shopping',
          'bought',
          'purchase',
          'mall',
          'clothes',
          'shoes',
          'fashion',
          'gadget',
          'electronics',
        ],
        'Bills': <String>[
          'bill',
          'electricity',
          'internet',
          'wifi',
          'broadband',
          'emi',
          'loan',
          'subscription',
          'netflix',
          'spotify',
          'amazon prime',
          'hotstar',
          'recharge',
          'mobile',
          'postpaid',
        ],
        'Rent': <String>['rent', 'maintenance', 'society', 'landlord'],
        'Health': <String>[
          'doctor',
          'medicine',
          'pharmacy',
          'medplus',
          'hospital',
          'clinic',
          'dental',
          'health',
          'gym',
          'fitness',
          'yoga',
        ],
        'Education': <String>[
          'school',
          'college',
          'tuition',
          'course',
          'books',
          'udemy',
          'coursera',
          'fees',
          'exam',
          'education',
        ],
        'Entertainment': <String>[
          'movie',
          'cinema',
          'pvr',
          'inox',
          'concert',
          'game',
          'gaming',
          'play',
          'outing',
          'entertainment',
        ],
        'Travel': <String>[
          'flight',
          'hotel',
          'irctc',
          'makemytrip',
          'goibibo',
          'airbnb',
          'trip',
          'vacation',
          'holiday',
          'tour',
        ],
        'Insurance': <String>['insurance', 'premium', 'lic', 'policy'],
        // Income categories
        'Salary': <String>['salary', 'wages', 'paycheck', 'payroll', 'stipend'],
        'Freelance': <String>['freelance', 'project payment', 'client'],
        'Business': <String>['business', 'profit', 'revenue', 'sales'],
        'Interest': <String>['interest', 'fd interest', 'savings interest'],
        'Dividends': <String>['dividend', 'stock dividend'],
        'Bonus': <String>['bonus', 'incentive', 'commission', 'reward'],
        'Rental Income': <String>['rental', 'rent received', 'tenant'],
        'Refund': <String>['refund', 'cashback', 'return', 'reimbursement'],
        'Gift Received': <String>['gift', 'gifted', 'received gift'],
      };

  /// Income signal words — if detected, override type to 'income'.
  static const List<String> _incomeSignals = <String>[
    'received',
    'got paid',
    'income',
    'earned',
    'salary credited',
    'credited',
    'deposited',
    'payment received',
    'refund received',
    'cashback',
  ];

  static VoiceParseResult parse(
    String transcript, {
    List<String>? availableCategories,
  }) {
    final normalized = transcript.trim();
    final lowered = normalized.toLowerCase();

    // ── Amount extraction ─────────────────────────────────────────────────
    // Priority 1: explicit currency marker  (₹500, rs 500, 500 rupees, 5k, 2 lakh)
    // Priority 2: any standalone number (exclude standalone 4-digit years like 2024)
    double? amount;

    // k / lakh shorthand
    final shorthandMatch = RegExp(
      r'(\d+(?:\.\d+)?)\s*(k|lakh|lac|lakhs)',
      caseSensitive: false,
    ).firstMatch(lowered);
    if (shorthandMatch != null) {
      final base = double.tryParse(shorthandMatch.group(1) ?? '');
      final suffix = shorthandMatch.group(2)?.toLowerCase() ?? '';
      if (base != null) {
        if (suffix == 'k') {
          amount = base * 1000;
        } else {
          amount = base * 100000;
        }
      }
    }

    if (amount == null) {
      // Currency-marked number (highest confidence)
      final currencyMatch = RegExp(
        r'(?:₹|rs\.?\s*|inr\s*|rupees?\s*)(\d{1,3}(?:[,\s]\d{3})*(?:\.\d+)?|\d+(?:\.\d+)?)',
        caseSensitive: false,
      ).firstMatch(lowered);
      if (currencyMatch != null) {
        final raw = (currencyMatch.group(1) ?? '')
            .replaceAll(',', '')
            .replaceAll(' ', '');
        amount = double.tryParse(raw);
      }
    }

    if (amount == null) {
      // Number followed by currency word
      final postMatch = RegExp(
        r'(\d{1,3}(?:[,\s]\d{3})*(?:\.\d+)?|\d+(?:\.\d+)?)\s*(?:rupees?|rs\.?|inr|₹)',
        caseSensitive: false,
      ).firstMatch(lowered);
      if (postMatch != null) {
        final raw = (postMatch.group(1) ?? '')
            .replaceAll(',', '')
            .replaceAll(' ', '');
        amount = double.tryParse(raw);
      }
    }

    if (amount == null) {
      // Standalone number — exclude 4-digit years (1900–2099)
      final allNums = RegExp(r'\b(\d+(?:\.\d+)?)\b').allMatches(lowered);
      for (final m in allNums) {
        final raw = m.group(1) ?? '';
        final val = double.tryParse(raw);
        if (val == null) continue;
        // Skip year-like standalone 4-digit numbers
        if (raw.length == 4 && val >= 1900 && val <= 2099) continue;
        amount = val;
        break;
      }
    }

    // ── Transaction type ──────────────────────────────────────────────────
    String type = 'expense';
    for (final signal in _incomeSignals) {
      if (lowered.contains(signal)) {
        type = 'income';
        break;
      }
    }

    // ── Category matching ────────────────────────────────────────────────
    String category = 'Others';
    for (final entry in _categoryKeywords.entries) {
      if (entry.value.any(lowered.contains)) {
        category = entry.key;
        break;
      }
    }

    // Validate against available categories list (from CategoryController)
    if (availableCategories != null && availableCategories.isNotEmpty) {
      final lowerAvailable =
          availableCategories.map((c) => c.toLowerCase()).toList();
      if (!lowerAvailable.contains(category.toLowerCase())) {
        // Nearest fallback: look for 'Others' or last item
        category = availableCategories.firstWhere(
          (c) => c.toLowerCase() == 'others',
          orElse: () => availableCategories.last,
        );
      }
    }

    // ── Payment mode ─────────────────────────────────────────────────────
    String paymentMode = 'other';
    if (lowered.contains('upi') ||
        lowered.contains('gpay') ||
        lowered.contains('phonepe') ||
        lowered.contains('paytm')) {
      paymentMode = 'upi';
    } else if (lowered.contains('card') ||
        lowered.contains('credit') ||
        lowered.contains('debit')) {
      paymentMode = 'card';
    } else if (lowered.contains('cash')) {
      paymentMode = 'cash';
    } else if (lowered.contains('netbanking') ||
        lowered.contains('net banking') ||
        lowered.contains('neft') ||
        lowered.contains('imps')) {
      paymentMode = 'netbanking';
    } else if (lowered.contains('wallet')) {
      paymentMode = 'wallet';
    }

    // ── Merchant extraction ──────────────────────────────────────────────
    // Match "at/from/to <Name>", max 40 chars, stops at keywords
    String? merchant;
    final merchantPatterns = <RegExp>[
      RegExp(r'\bat\s+([a-zA-Z][a-zA-Z0-9\s&\-\.]{1,40})', caseSensitive: false),
      RegExp(r'\bfrom\s+([a-zA-Z][a-zA-Z0-9\s&\-\.]{1,40})', caseSensitive: false),
      RegExp(r'\bto\s+([a-zA-Z][a-zA-Z0-9\s&\-\.]{1,40})', caseSensitive: false),
    ];
    for (final pattern in merchantPatterns) {
      final m = pattern.firstMatch(normalized);
      if (m != null) {
        final candidate = m.group(1)?.trim() ?? '';
        // Exclude common stop words that aren't merchants
        final stopWords = <String>{'me', 'my', 'the', 'a', 'an', 'him', 'her'};
        if (!stopWords.contains(candidate.toLowerCase()) &&
            candidate.isNotEmpty) {
          merchant = candidate;
          break;
        }
      }
    }

    return VoiceParseResult(
      rawText: normalized,
      amount: amount,
      category: category,
      paymentMode: paymentMode,
      type: type,
      merchant: merchant,
      note: normalized.isEmpty ? null : normalized,
    );
  }
}
