import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spend_analytics/features/auth/auth_controller.dart';
import 'package:spend_analytics/features/categories/category_controller.dart';
import 'package:spend_analytics/features/transactions/transaction_controller.dart';
import 'package:spend_analytics/shared/models/transaction_model.dart';
import 'package:spend_analytics/shared/utils/category_visuals.dart';
import 'package:spend_analytics/shared/widgets/icon_box.dart';
import 'package:spend_analytics/shared/widgets/liquid_glass_surface.dart';
import 'package:spend_analytics/shared/widgets/liquid_page_scaffold.dart';
import 'package:spend_analytics/shared/widgets/sa_shimmer.dart';
import 'package:uuid/uuid.dart';

class AddTransactionScreen extends StatefulWidget {
  const AddTransactionScreen({super.key});

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  final AuthController _auth = Get.find<AuthController>();
  final TransactionController _ctrl = Get.find<TransactionController>();
  final TextEditingController _amountCtrl = TextEditingController(text: '0');
  final TextEditingController _counterpartyCtrl = TextEditingController();
  final TextEditingController _fromAccountCtrl = TextEditingController();
  final TextEditingController _toAccountCtrl = TextEditingController();
  final TextEditingController _noteCtrl = TextEditingController();

  TransactionModel? _editingTxn;

  String _type = 'expense';
  String _category = 'Food';
  String _paymentMode = 'upi';
  DateTime _transactionDate = DateTime.now();

  static const _expenseCategories = <_CatMeta>[
    _CatMeta('Food', Icons.coffee_rounded, Color(0xFFFF9F40)),
    _CatMeta('Groceries', Icons.local_grocery_store_rounded, Color(0xFF3FDDA0)),
    _CatMeta('Transport', Icons.directions_car_rounded, Color(0xFF5B9FFF)),
    _CatMeta('Shopping', Icons.shopping_bag_rounded, Color(0xFFB0A0FF)),
    _CatMeta('Bills', Icons.bolt_rounded, Color(0xFFFFB860)),
    _CatMeta('Rent', Icons.home_rounded, Color(0xFF7AC7FF)),
    _CatMeta('Health', Icons.favorite_rounded, Color(0xFFFF6B6B)),
    _CatMeta('Education', Icons.school_rounded, Color(0xFF8B8EFF)),
    _CatMeta('Entertainment', Icons.movie_rounded, Color(0xFFFF9F40)),
    _CatMeta('Travel', Icons.flight_takeoff_rounded, Color(0xFF5B9FFF)),
    _CatMeta('Insurance', Icons.shield_rounded, Color(0xFF3FDDA0)),
    _CatMeta('Others', Icons.sell_rounded, Color(0xFF9DA8B8)),
  ];

  static const _incomeCategories = <_CatMeta>[
    _CatMeta('Salary', Icons.account_balance_wallet_rounded, Color(0xFF3FDDA0)),
    _CatMeta('Freelance', Icons.laptop_mac_rounded, Color(0xFF5B9FFF)),
    _CatMeta('Business', Icons.storefront_rounded, Color(0xFFB0A0FF)),
    _CatMeta('Interest', Icons.savings_rounded, Color(0xFFFFB860)),
    _CatMeta('Dividends', Icons.trending_up_rounded, Color(0xFF3FDDA0)),
    _CatMeta('Bonus', Icons.workspace_premium_rounded, Color(0xFFFF9F40)),
    _CatMeta('Rental Income', Icons.apartment_rounded, Color(0xFF7AC7FF)),
    _CatMeta('Refund', Icons.replay_rounded, Color(0xFF5B9FFF)),
    _CatMeta('Gift Received', Icons.card_giftcard_rounded, Color(0xFFB0A0FF)),
    _CatMeta('Others', Icons.attach_money_rounded, Color(0xFF9DA8B8)),
  ];

  static const _transferCategories = <_CatMeta>[
    _CatMeta('Bank Transfer', Icons.account_balance_rounded, Color(0xFF5B9FFF)),
    _CatMeta('UPI Transfer', Icons.qr_code_rounded, Color(0xFF3FDDA0)),
    _CatMeta('Wallet Transfer', Icons.wallet_rounded, Color(0xFFB0A0FF)),
    _CatMeta(
      'Cash Withdrawal',
      Icons.money_off_csred_rounded,
      Color(0xFFFF9F40),
    ),
    _CatMeta('Cash Deposit', Icons.payments_rounded, Color(0xFF3FDDA0)),
    _CatMeta('Card Payment', Icons.credit_card_rounded, Color(0xFF7AC7FF)),
    _CatMeta('Credit Card Bill', Icons.receipt_long_rounded, Color(0xFFFF6B6B)),
    _CatMeta('Internal Transfer', Icons.sync_alt_rounded, Color(0xFF9DA8B8)),
  ];

  static const _quickAmounts = <int>[50, 100, 200, 500, 1000];

  static const _paymentModesByType = <String, List<String>>{
    'expense': <String>['upi', 'card', 'cash', 'netbanking', 'wallet', 'other'],
    'income': <String>[
      'bank_transfer',
      'upi',
      'cash',
      'cheque',
      'wallet',
      'other',
    ],
    'transfer': <String>[
      'bank_transfer',
      'upi',
      'wallet',
      'card',
      'cash',
      'other',
    ],
  };

  bool get _isEditing => _editingTxn != null;

  @override
  void initState() {
    super.initState();
    final arg = Get.arguments;
    if (arg is TransactionModel) {
      _editingTxn = arg;
      _type = arg.type;
      _transactionDate = arg.transactionDate;
      _amountCtrl.text =
          arg.amount == arg.amount.roundToDouble()
              ? arg.amount.toStringAsFixed(0)
              : arg.amount.toString();

      final categories = _categoriesForType(_type);
      _category =
          categories.any((c) => c.name == arg.category)
              ? arg.category
              : categories.first.name;

      _paymentMode = _normalizedPaymentMode(arg.paymentMode, _type);
      _hydrateNoteFields(arg.note);
    } else {
      _setType(_type, keepExisting: true);
    }
  }

  @override
  void dispose() {
    _amountCtrl.dispose();
    _counterpartyCtrl.dispose();
    _fromAccountCtrl.dispose();
    _toAccountCtrl.dispose();
    _noteCtrl.dispose();
    super.dispose();
  }

  void _setType(String type, {bool keepExisting = false}) {
    _type = type;
    final categories = _categoriesForType(type);
    final modes = _paymentModesForType(type);

    if (!keepExisting || !categories.any((c) => c.name == _category)) {
      _category = categories.first.name;
    }
    if (!keepExisting || !modes.contains(_paymentMode)) {
      _paymentMode = modes.first;
    }
  }

  List<_CatMeta> _categoriesForType(String type) {
    final categoryController = Get.find<CategoryController>();
    final names = categoryController.categoriesForType(type);
    final defaultsByKey = _defaultsByType(type);
    final combined = <_CatMeta>[];
    final seen = <String>{};

    for (final rawName in names) {
      final trimmed = rawName.trim();
      if (trimmed.isEmpty) {
        continue;
      }
      final key = trimmed.toLowerCase();
      if (seen.contains(key)) {
        continue;
      }
      combined.add(
        defaultsByKey[key] ??
            (() {
              final visual = CategoryVisuals.resolve(trimmed, type: type);
              return _CatMeta(trimmed, visual.icon, visual.color);
            })(),
      );
      seen.add(key);
    }

    for (final fallback in defaultsByKey.values) {
      final key = fallback.name.toLowerCase();
      if (seen.contains(key)) {
        continue;
      }
      combined.add(fallback);
      seen.add(key);
    }
    return combined;
  }

  Map<String, _CatMeta> _defaultsByType(String type) {
    switch (type) {
      case 'income':
        return <String, _CatMeta>{
          for (final meta in _incomeCategories) meta.name.toLowerCase(): meta,
        };
      case 'transfer':
        return <String, _CatMeta>{
          for (final meta in _transferCategories) meta.name.toLowerCase(): meta,
        };
      case 'expense':
      default:
        return <String, _CatMeta>{
          for (final meta in _expenseCategories) meta.name.toLowerCase(): meta,
        };
    }
  }

  List<String> _paymentModesForType(String type) {
    return _paymentModesByType[type] ?? _paymentModesByType['expense']!;
  }

  String _paymentModeLabel(String mode) {
    switch (mode) {
      case 'upi':
        return 'UPI';
      case 'card':
        return 'Card';
      case 'cash':
        return 'Cash';
      case 'netbanking':
        return 'Net Banking';
      case 'wallet':
        return 'Wallet';
      case 'bank_transfer':
        return 'Bank Transfer';
      case 'cheque':
        return 'Cheque';
      case 'other':
      default:
        return 'Other';
    }
  }

  String _transferPaymentModeForCategory(String category) {
    final key = category.toLowerCase();
    if (key.contains('upi')) {
      return 'upi';
    }
    if (key.contains('wallet')) {
      return 'wallet';
    }
    if (key.contains('card')) {
      return 'card';
    }
    if (key.contains('cash')) {
      return 'cash';
    }
    return 'bank_transfer';
  }

  void _addQuick(int n) {
    final current = double.tryParse(_amountCtrl.text) ?? 0;
    _amountCtrl.text = (current + n).toStringAsFixed(0);
  }

  Future<void> _save() async {
    final amount = double.tryParse(_amountCtrl.text.trim());
    if (amount == null || amount <= 0) {
      Get.snackbar('Invalid amount', 'Please enter a valid amount.');
      return;
    }

    if (_type == 'transfer') {
      if (_fromAccountCtrl.text.trim().isEmpty ||
          _toAccountCtrl.text.trim().isEmpty) {
        Get.snackbar(
          'Incomplete transfer',
          'Please provide both from and to accounts.',
        );
        return;
      }
    }

    final txn = TransactionModel(
      id: _editingTxn?.id ?? const Uuid().v4(),
      userId: _editingTxn?.userId ?? _auth.resolveActiveUserId(),
      amount: amount,
      type: _type,
      category: _category,
      paymentMode: _normalizedPaymentMode(_paymentMode, _type),
      transactionDate: _transactionDate,
      updatedAt: DateTime.now().toUtc(),
      note: _composeNote(),
    );
    await _ctrl.saveTransaction(txn, isUpdate: _isEditing);
    if (mounted) Get.back<void>();
  }

  void _hydrateNoteFields(String? rawNote) {
    final value = (rawNote ?? '').trim();
    if (value.isEmpty) {
      return;
    }

    if (_type == 'transfer') {
      final lines = value.split('\n');
      final noteLines = <String>[];
      for (final line in lines) {
        if (line.startsWith('From: ')) {
          _fromAccountCtrl.text = line.substring('From: '.length).trim();
          continue;
        }
        if (line.startsWith('To: ')) {
          _toAccountCtrl.text = line.substring('To: '.length).trim();
          continue;
        }
        if (line.startsWith('Note: ')) {
          noteLines.add(line.substring('Note: '.length).trim());
          continue;
        }
        noteLines.add(line.trim());
      }
      _noteCtrl.text = noteLines.where((l) => l.isNotEmpty).join('\n').trim();
      return;
    }

    const counterpartyPrefix = 'Counterparty: ';
    const merchantPrefix = 'Merchant: ';
    final lines = value.split('\n');
    final first = lines.first.trim();

    if (first.startsWith(counterpartyPrefix)) {
      _counterpartyCtrl.text =
          first.substring(counterpartyPrefix.length).trim();
      _noteCtrl.text = lines.skip(1).join('\n').trim();
      return;
    }

    if (first.startsWith(merchantPrefix)) {
      _counterpartyCtrl.text = first.substring(merchantPrefix.length).trim();
      _noteCtrl.text = lines.skip(1).join('\n').trim();
      return;
    }

    _noteCtrl.text = value;
  }

  String _normalizedPaymentMode(String value, String type) {
    final normalized = value.trim().toLowerCase();
    final allowed = _paymentModesForType(type);
    if (allowed.contains(normalized)) {
      return normalized;
    }
    return allowed.first;
  }

  String? _composeNote() {
    final note = _noteCtrl.text.trim();

    if (_type == 'transfer') {
      final from = _fromAccountCtrl.text.trim();
      final to = _toAccountCtrl.text.trim();
      if (from.isEmpty && to.isEmpty && note.isEmpty) {
        return null;
      }
      final lines = <String>[];
      if (from.isNotEmpty) lines.add('From: $from');
      if (to.isNotEmpty) lines.add('To: $to');
      if (note.isNotEmpty) lines.add('Note: $note');
      return lines.join('\n');
    }

    final counterparty = _counterpartyCtrl.text.trim();
    if (counterparty.isEmpty && note.isEmpty) {
      return null;
    }
    if (counterparty.isEmpty) {
      return note;
    }
    if (note.isEmpty) {
      return 'Counterparty: $counterparty';
    }
    return 'Counterparty: $counterparty\n$note';
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _transactionDate,
      firstDate: DateTime(now.year - 5, 1, 1),
      lastDate: DateTime(now.year + 2, 12, 31),
    );
    if (picked == null) return;
    setState(() => _transactionDate = picked);
  }

  String _formatDate(DateTime date) {
    const months = <String>[
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }

  String _counterpartyLabelForType() {
    switch (_type) {
      case 'income':
        return 'Received From';
      case 'expense':
      default:
        return 'Merchant / Payee';
    }
  }

  String _counterpartyHintForType() {
    switch (_type) {
      case 'income':
        return 'Who paid you?';
      case 'expense':
      default:
        return 'Where did you spend?';
    }
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return LiquidPageScaffold(
      title: _isEditing ? 'Edit transaction' : 'New transaction',
      showBottomNav: false,
      onBack: () => Get.back<void>(),
      actions: <Widget>[
        BarActionButton(
          icon: Icons.close_rounded,
          onTap: () => Get.back<void>(),
        ),
      ],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          LiquidGlassSurface(
            padding: const EdgeInsets.all(4),
            borderRadius: const BorderRadius.all(Radius.circular(999)),
            child: Row(
              children:
                  <String>['Expense', 'Income', 'Transfer'].map((tp) {
                    final targetType = tp.toLowerCase();
                    final active = targetType == _type;
                    return Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => _setType(targetType)),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 160),
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(999),
                            color:
                                active
                                    ? scheme.primary.withValues(alpha: 0.18)
                                    : Colors.transparent,
                            border:
                                active
                                    ? Border.all(
                                      color: scheme.primary.withValues(
                                        alpha: 0.3,
                                      ),
                                      width: 0.5,
                                    )
                                    : null,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            tp,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color:
                                  active
                                      ? scheme.primary
                                      : scheme.onSurfaceVariant,
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
            ),
          ),
          const SizedBox(height: 16),
          LiquidGlassSurface(
            padding: const EdgeInsets.all(28),
            borderRadius: const BorderRadius.all(Radius.circular(24)),
            child: Column(
              children: <Widget>[
                Text(
                  'AMOUNT',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.1,
                    color: scheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: <Widget>[
                    Text(
                      '₹',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.w600,
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(width: 4),
                    IntrinsicWidth(
                      child: TextField(
                        controller: _amountCtrl,
                        autofocus: !_isEditing,
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 52,
                          fontWeight: FontWeight.w800,
                          color: scheme.onSurface,
                          letterSpacing: -2,
                          fontFeatures: const <FontFeature>[
                            FontFeature.tabularFigures(),
                          ],
                        ),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children:
                        _quickAmounts.map((n) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: GestureDetector(
                              onTap: () => _addQuick(n),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 14,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: scheme.primary.withValues(alpha: 0.10),
                                  borderRadius: BorderRadius.circular(999),
                                  border: Border.all(
                                    color: scheme.primary.withValues(
                                      alpha: 0.2,
                                    ),
                                    width: 0.5,
                                  ),
                                ),
                                child: Text(
                                  '+ ₹$n',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                    color: scheme.primary,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Text(
            _type == 'transfer' ? 'TRANSFER TYPE' : 'CATEGORY',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.8,
              color: scheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 10),
          LayoutBuilder(
            builder: (context, constraints) {
              final width = constraints.maxWidth;
              final crossAxisCount =
                  width >= 700
                      ? 4
                      : width >= 480
                      ? 3
                      : 2;
              Widget buildGrid(List<_CatMeta> categories) {
                return LiquidGlassSurface(
                  padding: const EdgeInsets.all(14),
                  child: GridView.count(
                    crossAxisCount: crossAxisCount,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 1.05,
                    children:
                        categories.map((c) {
                          final active = _category == c.name;
                          return GestureDetector(
                            onTap:
                                () => setState(() {
                                  _category = c.name;
                                  if (_type == 'transfer') {
                                    _paymentMode =
                                        _transferPaymentModeForCategory(c.name);
                                  }
                                }),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 160),
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                color:
                                    active
                                        ? scheme.primary.withValues(alpha: 0.08)
                                        : Colors.transparent,
                                border: Border.all(
                                  color:
                                      active
                                          ? scheme.primary.withValues(
                                            alpha: 0.4,
                                          )
                                          : scheme.outline.withValues(
                                            alpha: 0.3,
                                          ),
                                  width: 0.8,
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  IconBox(
                                    icon: c.icon,
                                    color: c.color,
                                    size: 36,
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    c.name,
                                    textAlign: TextAlign.center,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                      color:
                                          active
                                              ? scheme.primary
                                              : scheme.onSurface,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                  ),
                );
              }

              return Obx(() => buildGrid(_categoriesForType(_type)));
            },
          ),
          const SizedBox(height: 16),
          LiquidGlassSurface(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                if (_type == 'transfer') ...<Widget>[
                  TextField(
                    controller: _fromAccountCtrl,
                    textCapitalization: TextCapitalization.words,
                    decoration: const InputDecoration(
                      labelText: 'From Account',
                      hintText: 'e.g., HDFC Savings / Cash Wallet',
                      prefixIcon: Icon(Icons.call_made_rounded),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _toAccountCtrl,
                    textCapitalization: TextCapitalization.words,
                    decoration: const InputDecoration(
                      labelText: 'To Account',
                      hintText: 'e.g., ICICI Current / Credit Card',
                      prefixIcon: Icon(Icons.call_received_rounded),
                    ),
                  ),
                ] else ...<Widget>[
                  TextField(
                    controller: _counterpartyCtrl,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                      labelText: _counterpartyLabelForType(),
                      hintText: _counterpartyHintForType(),
                      prefixIcon: const Icon(Icons.storefront_outlined),
                    ),
                  ),
                ],
                const SizedBox(height: 12),
                OutlinedButton.icon(
                  onPressed: _pickDate,
                  icon: const Icon(Icons.calendar_today_outlined),
                  label: Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Date: ${_formatDate(_transactionDate)}'),
                  ),
                ),
                const SizedBox(height: 12),
                if (_type != 'transfer') ...<Widget>[
                  Text(
                    'Payment Mode',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children:
                        _paymentModesForType(_type).map((mode) {
                          final active = _paymentMode == mode;
                          return ChoiceChip(
                            label: Text(_paymentModeLabel(mode)),
                            selected: active,
                            onSelected:
                                (_) => setState(() => _paymentMode = mode),
                          );
                        }).toList(),
                  ),
                  const SizedBox(height: 12),
                ],
                _NoteRow(controller: _noteCtrl),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Obx(() {
            final loading = _ctrl.isLoading.value;
            return FilledButton(
              onPressed: loading ? null : _save,
              style: FilledButton.styleFrom(
                minimumSize: const Size.fromHeight(54),
                shape: const StadiumBorder(),
              ),
              child:
                  loading
                      ? const SAShimmer(
                        child: SAShimmerBox(width: 128, height: 14, radius: 8),
                      )
                      : Text(
                        _isEditing ? 'Update transaction' : 'Save transaction',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
            );
          }),
        ],
      ),
    );
  }
}

class _CatMeta {
  const _CatMeta(this.name, this.icon, this.color);
  final String name;
  final IconData icon;
  final Color color;
}

class _NoteRow extends StatelessWidget {
  const _NoteRow({required this.controller});
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: <Widget>[
          Icon(Icons.edit_outlined, size: 18, color: scheme.onSurfaceVariant),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              controller: controller,
              maxLines: 1,
              style: Theme.of(context).textTheme.bodyLarge,
              decoration: InputDecoration(
                hintText: 'Add a note…',
                hintStyle: TextStyle(color: scheme.onSurfaceVariant),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
