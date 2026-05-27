import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spend_analytics/features/auth/auth_controller.dart';
import 'package:spend_analytics/features/transactions/transaction_controller.dart';
import 'package:spend_analytics/shared/models/transaction_model.dart';
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
  final TextEditingController _merchantCtrl = TextEditingController();
  final TextEditingController _noteCtrl = TextEditingController();
  TransactionModel? _editingTxn;

  String _type = 'expense';
  String _category = 'Food';
  String _paymentMode = 'upi';
  DateTime _transactionDate = DateTime.now();

  static const _categories = <_CatMeta>[
    _CatMeta('Food', Icons.coffee_rounded, Color(0xFFFF9F40)),
    _CatMeta('Transport', Icons.directions_car_rounded, Color(0xFF5B9FFF)),
    _CatMeta('Shopping', Icons.shopping_bag_rounded, Color(0xFFB0A0FF)),
    _CatMeta('Health', Icons.favorite_rounded, Color(0xFFFF6B6B)),
    _CatMeta('Bills', Icons.bolt_rounded, Color(0xFFFFB860)),
    _CatMeta('Others', Icons.sell_rounded, Color(0xFF3FDDA0)),
  ];

  static const _quickAmounts = <int>[50, 100, 200, 500, 1000];

  bool get _isEditing => _editingTxn != null;

  @override
  void initState() {
    super.initState();
    final arg = Get.arguments;
    if (arg is TransactionModel) {
      _editingTxn = arg;
      _type = arg.type;
      _category = arg.category;
      _paymentMode = _normalizedPaymentMode(arg.paymentMode);
      _transactionDate = arg.transactionDate;
      _amountCtrl.text =
          arg.amount == arg.amount.roundToDouble()
              ? arg.amount.toStringAsFixed(0)
              : arg.amount.toString();
      _hydrateNoteFields(arg.note);
    }
  }

  @override
  void dispose() {
    _amountCtrl.dispose();
    _merchantCtrl.dispose();
    _noteCtrl.dispose();
    super.dispose();
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
    final txn = TransactionModel(
      id: _editingTxn?.id ?? const Uuid().v4(),
      userId: _editingTxn?.userId ?? _auth.resolveActiveUserId(),
      amount: amount,
      type: _type,
      category: _category,
      paymentMode: _normalizedPaymentMode(_paymentMode),
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
    const merchantPrefix = 'Merchant: ';
    if (!value.startsWith(merchantPrefix)) {
      _noteCtrl.text = value;
      return;
    }

    final lines = value.split('\n');
    final first = lines.first;
    _merchantCtrl.text = first.substring(merchantPrefix.length).trim();
    if (lines.length > 1) {
      _noteCtrl.text = lines.skip(1).join('\n').trim();
    }
  }

  String _normalizedPaymentMode(String value) {
    final normalized = value.trim().toLowerCase();
    switch (normalized) {
      case 'cash':
      case 'upi':
      case 'card':
      case 'netbanking':
      case 'other':
        return normalized;
      default:
        return 'other';
    }
  }

  String? _composeNote() {
    final merchant = _merchantCtrl.text.trim();
    final note = _noteCtrl.text.trim();
    if (merchant.isEmpty && note.isEmpty) {
      return null;
    }
    if (merchant.isEmpty) {
      return note;
    }
    if (note.isEmpty) {
      return 'Merchant: $merchant';
    }
    return 'Merchant: $merchant\n$note';
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
          // ── Type selector pill ────────────────────────────────
          LiquidGlassSurface(
            padding: const EdgeInsets.all(4),
            borderRadius: const BorderRadius.all(Radius.circular(999)),
            child: Row(
              children:
                  <String>['Expense', 'Income', 'Transfer'].map((tp) {
                    final active =
                        tp.toLowerCase() == _type ||
                        (tp == 'Transfer' && _type == 'transfer');
                    return Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => _type = tp.toLowerCase()),
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

          // ── Amount input ──────────────────────────────────────
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
                // Quick-add chips
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

          // ── Category picker ───────────────────────────────────
          Text(
            'CATEGORY',
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
                      _categories.map((c) {
                        final active = _category == c.name;
                        return GestureDetector(
                          onTap: () => setState(() => _category = c.name),
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
                                        ? scheme.primary.withValues(alpha: 0.4)
                                        : scheme.outline.withValues(alpha: 0.3),
                                width: 0.8,
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                IconBox(icon: c.icon, color: c.color, size: 36),
                                const SizedBox(height: 6),
                                Text(
                                  c.name,
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
            },
          ),

          const SizedBox(height: 16),

          // ── Form rows ─────────────────────────────────────────
          LiquidGlassSurface(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextField(
                  controller: _merchantCtrl,
                  textCapitalization: TextCapitalization.words,
                  decoration: const InputDecoration(
                    labelText: 'Merchant',
                    hintText: 'Where did you spend?',
                    prefixIcon: Icon(Icons.storefront_outlined),
                  ),
                ),
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
                      const <String>[
                        'upi',
                        'card',
                        'cash',
                        'netbanking',
                        'other',
                      ].map((mode) {
                        final active = _paymentMode == mode;
                        return ChoiceChip(
                          label: Text(mode.toUpperCase()),
                          selected: active,
                          onSelected:
                              (_) => setState(() => _paymentMode = mode),
                        );
                      }).toList(),
                ),
                const SizedBox(height: 12),
                _NoteRow(controller: _noteCtrl),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // ── Save ──────────────────────────────────────────────
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
                        style: TextStyle(
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
