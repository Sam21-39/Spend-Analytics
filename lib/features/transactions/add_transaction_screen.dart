import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spend_analytics/features/auth/auth_controller.dart';
import 'package:spend_analytics/features/transactions/transaction_controller.dart';
import 'package:spend_analytics/shared/models/transaction_model.dart';
import 'package:spend_analytics/shared/widgets/icon_box.dart';
import 'package:spend_analytics/shared/widgets/liquid_glass_surface.dart';
import 'package:spend_analytics/shared/widgets/liquid_page_scaffold.dart';
import 'package:uuid/uuid.dart';

class AddTransactionScreen extends StatefulWidget {
  const AddTransactionScreen({super.key});

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  final AuthController       _auth = Get.find<AuthController>();
  final TransactionController _ctrl = Get.find<TransactionController>();
  final TextEditingController _amountCtrl = TextEditingController(text: '0');
  final TextEditingController _noteCtrl   = TextEditingController();

  String _type     = 'expense';
  String _category = 'Food';

  static const _categories = <_CatMeta>[
    _CatMeta('Food',      Icons.coffee_rounded,         Color(0xFFFF9F40)),
    _CatMeta('Transport', Icons.directions_car_rounded,  Color(0xFF5B9FFF)),
    _CatMeta('Shopping',  Icons.shopping_bag_rounded,    Color(0xFFB0A0FF)),
    _CatMeta('Health',    Icons.favorite_rounded,        Color(0xFFFF6B6B)),
    _CatMeta('Bills',     Icons.bolt_rounded,            Color(0xFFFFB860)),
    _CatMeta('Others',    Icons.sell_rounded,            Color(0xFF3FDDA0)),
  ];

  static const _quickAmounts = <int>[50, 100, 200, 500, 1000];

  @override
  void dispose() {
    _amountCtrl.dispose();
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
      id:              const Uuid().v4(),
      userId:          _auth.resolveActiveUserId(),
      amount:          amount,
      type:            _type,
      category:        _category,
      paymentMode:     'UPI',
      transactionDate: DateTime.now(),
      updatedAt:       DateTime.now().toUtc(),
      note:            _noteCtrl.text.trim().isEmpty ? null : _noteCtrl.text.trim(),
    );
    await _ctrl.addTransaction(txn);
    if (mounted) Get.back<void>();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return LiquidPageScaffold(
      title:         'New transaction',
      showBottomNav: false,
      onBack:        () => Get.back<void>(),
      actions: <Widget>[
        BarActionButton(icon: Icons.close_rounded, onTap: () => Get.back<void>()),
      ],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // ── Type selector pill ────────────────────────────────
          LiquidGlassSurface(
            padding:      const EdgeInsets.all(4),
            borderRadius: const BorderRadius.all(Radius.circular(999)),
            child: Row(
              children: <String>['Expense', 'Income', 'Transfer'].map((tp) {
                final active = tp.toLowerCase() == _type ||
                    (tp == 'Transfer' && _type == 'transfer');
                return Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _type = tp.toLowerCase()),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 160),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(999),
                        color:   active ? scheme.primary.withValues(alpha: 0.18) : Colors.transparent,
                        border:  active ? Border.all(color: scheme.primary.withValues(alpha: 0.3), width: 0.5) : null,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        tp,
                        style: TextStyle(
                          fontSize:   14,
                          fontWeight: FontWeight.w700,
                          color:      active ? scheme.primary : scheme.onSurfaceVariant,
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
            padding:      const EdgeInsets.all(28),
            borderRadius: const BorderRadius.all(Radius.circular(24)),
            child: Column(
              children: <Widget>[
                Text(
                  'AMOUNT',
                  style: TextStyle(
                    fontSize:      10,
                    fontWeight:    FontWeight.w700,
                    letterSpacing: 1.1,
                    color:         scheme.onSurfaceVariant,
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
                        fontSize:   36,
                        fontWeight: FontWeight.w600,
                        color:      scheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(width: 4),
                    IntrinsicWidth(
                      child: TextField(
                        controller:  _amountCtrl,
                        autofocus:   true,
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        textAlign:   TextAlign.center,
                        style: TextStyle(
                          fontSize:   52,
                          fontWeight: FontWeight.w800,
                          color:      scheme.onSurface,
                          letterSpacing: -2,
                          fontFeatures: const <FontFeature>[FontFeature.tabularFigures()],
                        ),
                        decoration: const InputDecoration(
                          border:        InputBorder.none,
                          isDense:       true,
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
                    children: _quickAmounts.map((n) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: GestureDetector(
                          onTap: () => _addQuick(n),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                            decoration: BoxDecoration(
                              color:        scheme.primary.withValues(alpha: 0.10),
                              borderRadius: BorderRadius.circular(999),
                              border: Border.all(color: scheme.primary.withValues(alpha: 0.2), width: 0.5),
                            ),
                            child: Text(
                              '+ ₹$n',
                              style: TextStyle(
                                fontSize:   13,
                                fontWeight: FontWeight.w700,
                                color:      scheme.primary,
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
              fontSize:      11,
              fontWeight:    FontWeight.w700,
              letterSpacing: 0.8,
              color:         scheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 10),
          LiquidGlassSurface(
            padding: const EdgeInsets.all(14),
            child: GridView.count(
              crossAxisCount: 3,
              shrinkWrap:     true,
              physics:        const NeverScrollableScrollPhysics(),
              mainAxisSpacing:  10,
              crossAxisSpacing: 10,
              childAspectRatio: 1.05,
              children: _categories.map((c) {
                final active = _category == c.name;
                return GestureDetector(
                  onTap: () => setState(() => _category = c.name),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 160),
                    padding:     const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color:  active ? scheme.primary.withValues(alpha: 0.08) : Colors.transparent,
                      border: Border.all(
                        color:  active
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
                            fontSize:   12,
                            fontWeight: FontWeight.w700,
                            color:      active ? scheme.primary : scheme.onSurface,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),

          const SizedBox(height: 16),

          // ── Form rows ─────────────────────────────────────────
          LiquidGlassSurface(
            padding: EdgeInsets.zero,
            child: Column(
              children: <Widget>[
                _FormRow(
                  icon:        Icons.receipt_long_rounded,
                  label:       'Merchant',
                  hintText:    'Where did you spend?',
                  isDivider:   true,
                ),
                _FormRow(
                  icon:        Icons.calendar_today_outlined,
                  label:       'Date',
                  hintText:    'Today',
                  isDivider:   true,
                ),
                _FormRow(
                  icon:        Icons.account_balance_wallet_outlined,
                  label:       'Payment',
                  hintText:    'UPI',
                  isDivider:   true,
                ),
                _NoteRow(controller: _noteCtrl),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // ── Save ──────────────────────────────────────────────
          Obx(
            () => FilledButton(
              onPressed: _ctrl.isLoading.value ? null : _save,
              style: FilledButton.styleFrom(
                minimumSize: const Size.fromHeight(54),
                shape: const StadiumBorder(),
              ),
              child: const Text(
                'Save transaction',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CatMeta {
  const _CatMeta(this.name, this.icon, this.color);
  final String   name;
  final IconData icon;
  final Color    color;
}

class _FormRow extends StatelessWidget {
  const _FormRow({
    required this.icon,
    required this.label,
    required this.hintText,
    required this.isDivider,
  });
  final IconData icon;
  final String   label;
  final String   hintText;
  final bool     isDivider;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isDark  = Theme.of(context).brightness == Brightness.dark;
    return Container(
      decoration: isDivider
          ? BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: isDark
                      ? Colors.white.withValues(alpha: 0.08)
                      : Colors.black.withValues(alpha: 0.06),
                  width: 0.5,
                ),
              ),
            )
          : null,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: <Widget>[
          Icon(icon, size: 18, color: scheme.onSurfaceVariant),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  label,
                  style: TextStyle(fontSize: 11, color: scheme.onSurfaceVariant),
                ),
                Text(
                  hintText,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: scheme.onSurface,
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.chevron_right_rounded, size: 14, color: scheme.onSurfaceVariant),
        ],
      ),
    );
  }
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
              controller:  controller,
              maxLines:    1,
              style: Theme.of(context).textTheme.bodyLarge,
              decoration: InputDecoration(
                hintText:      'Add a note…',
                hintStyle:     TextStyle(color: scheme.onSurfaceVariant),
                border:        InputBorder.none,
                isDense:       true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
