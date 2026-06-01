import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spend_analytics/features/auth/auth_controller.dart';

class CategoryController extends GetxController {
  static const expenseType = 'expense';
  static const incomeType = 'income';
  static const transferType = 'transfer';

  static const _defaultExpenseCategories = <String>[
    'Food',
    'Groceries',
    'Rent',
    'Transport',
    'Shopping',
    'Bills',
    'Health',
    'Education',
    'Entertainment',
    'Travel',
    'Insurance',
    'Others',
  ];

  static const _defaultIncomeCategories = <String>[
    'Salary',
    'Freelance',
    'Business',
    'Interest',
    'Dividends',
    'Bonus',
    'Rental Income',
    'Refund',
    'Gift Received',
    'Others',
  ];

  static const _defaultTransferCategories = <String>[
    'Bank Transfer',
    'UPI Transfer',
    'Wallet Transfer',
    'Cash Withdrawal',
    'Cash Deposit',
    'Card Payment',
    'Credit Card Bill',
    'Internal Transfer',
  ];

  static const _storageKeyPrefix = 'category_order_v2_';

  final expenseCategories = <String>[..._defaultExpenseCategories].obs;
  final incomeCategories = <String>[..._defaultIncomeCategories].obs;
  final transferCategories = <String>[..._defaultTransferCategories].obs;

  // Backward-compatible alias used by expense-only screens.
  RxList<String> get categories => expenseCategories;

  @override
  void onInit() {
    super.onInit();
    refreshForActiveUser();
  }

  Future<void> refreshForActiveUser() async {
    await _loadCategories();
  }

  List<String> categoriesForType(String type) {
    switch (type) {
      case incomeType:
        return incomeCategories.toList(growable: false);
      case transferType:
        return transferCategories.toList(growable: false);
      case expenseType:
      default:
        return expenseCategories.toList(growable: false);
    }
  }

  RxList<String> _listForType(String type) {
    switch (type) {
      case incomeType:
        return incomeCategories;
      case transferType:
        return transferCategories;
      case expenseType:
      default:
        return expenseCategories;
    }
  }

  List<String> _defaultsForType(String type) {
    switch (type) {
      case incomeType:
        return _defaultIncomeCategories;
      case transferType:
        return _defaultTransferCategories;
      case expenseType:
      default:
        return _defaultExpenseCategories;
    }
  }

  Future<void> reorderCategories(
    int oldIndex,
    int newIndex, {
    String type = expenseType,
  }) async {
    final list = _listForType(type);
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }
    final updated = List<String>.from(list);
    final item = updated.removeAt(oldIndex);
    updated.insert(newIndex, item);
    list.assignAll(updated);
    await _saveCategories(type: type);
  }

  Future<bool> addCategory(String name, {String type = expenseType}) async {
    final list = _listForType(type);
    final trimmed = name.trim();
    if (trimmed.isEmpty) {
      return false;
    }
    final exists = list.any(
      (item) => item.toLowerCase() == trimmed.toLowerCase(),
    );
    if (exists) {
      return false;
    }
    list.add(trimmed);
    await _saveCategories(type: type);
    return true;
  }

  Future<void> _loadCategories() async {
    final prefs = await SharedPreferences.getInstance();
    for (final type in <String>[expenseType, incomeType, transferType]) {
      final storageKey = _storageKeyForCurrentUser(type);
      final saved = prefs.getStringList(storageKey);
      final list = _listForType(type);
      if (saved == null || saved.isEmpty) {
        list.assignAll(_defaultsForType(type));
      } else {
        list.assignAll(saved);
      }
    }
  }

  Future<void> _saveCategories({required String type}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
      _storageKeyForCurrentUser(type),
      _listForType(type).toList(growable: false),
    );
  }

  String _storageKeyForCurrentUser(String type) {
    try {
      if (Get.isRegistered<AuthController>()) {
        final userId = Get.find<AuthController>().resolveActiveUserId();
        return '$_storageKeyPrefix${type}_$userId';
      }
    } catch (_) {}
    return '${_storageKeyPrefix}${type}_guest';
  }
}
