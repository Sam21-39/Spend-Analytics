import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spend_analytics/core/routes/app_routes.dart';
import 'package:spend_analytics/features/auth/auth_controller.dart';
import 'package:spend_analytics/features/transactions/transaction_controller.dart';
import 'package:spend_analytics/shared/models/transaction_model.dart';
import 'package:spend_analytics/shared/widgets/liquid_glass_background.dart';
import 'package:spend_analytics/shared/widgets/liquid_glass_surface.dart';
import 'package:uuid/uuid.dart';

class AddTransactionScreen extends StatefulWidget {
  const AddTransactionScreen({super.key});

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  final AuthController _authController = Get.find<AuthController>();
  final TransactionController _controller = Get.find<TransactionController>();

  final TextEditingController _amount = TextEditingController();
  final TextEditingController _note = TextEditingController();

  String _selectedCategory = 'Food';
  String _type = 'expense';

  static const _categories = <String>[
    'Food',
    'Transport',
    'Shopping',
    'Bills',
    'Others',
  ];

  @override
  void dispose() {
    _amount.dispose();
    _note.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final amount = double.tryParse(_amount.text.trim());
    if (amount == null || amount <= 0) {
      Get.snackbar('Invalid Amount', 'Please enter a valid amount.');
      return;
    }

    final txn = TransactionModel(
      id: const Uuid().v4(),
      userId: _authController.resolveActiveUserId(),
      amount: amount,
      type: _type,
      category: _selectedCategory,
      paymentMode: 'upi',
      transactionDate: DateTime.now(),
      updatedAt: DateTime.now().toUtc(),
      note: _note.text.trim().isEmpty ? null : _note.text.trim(),
    );

    await _controller.addTransaction(txn);
    if (!mounted) {
      return;
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.transparent,
      body: Stack(
        children: <Widget>[
          const LiquidGlassBackground(),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 120),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: const Icon(Icons.close_rounded),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'Add Transaction',
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(fontWeight: FontWeight.w800),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  LiquidGlassSurface(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Amount',
                          style: Theme.of(
                            context,
                          ).textTheme.labelLarge?.copyWith(
                            color: scheme.onSurfaceVariant,
                            letterSpacing: 0.9,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: <Widget>[
                            Text(
                              '₹',
                              style: Theme.of(
                                context,
                              ).textTheme.displayMedium?.copyWith(
                                color: scheme.primary,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: TextField(
                                controller: _amount,
                                autofocus: true,
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                      decimal: true,
                                    ),
                                style: Theme.of(
                                  context,
                                ).textTheme.displaySmall?.copyWith(
                                  color: scheme.primary,
                                  fontWeight: FontWeight.w800,
                                ),
                                decoration: const InputDecoration(
                                  hintText: '0.00',
                                  border: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  filled: false,
                                ),
                              ),
                            ),
                            const Spacer(),
                            IconButton(
                              onPressed:
                                  () => Get.toNamed(AppRoutes.voiceReview),
                              icon: const Icon(Icons.mic_rounded),
                              tooltip: 'Voice Auto-Review',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  LiquidGlassSurface(
                    padding: const EdgeInsets.all(6),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: _TypeButton(
                            title: 'Expense',
                            isActive: _type == 'expense',
                            onTap: () => setState(() => _type = 'expense'),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: _TypeButton(
                            title: 'Income',
                            isActive: _type == 'income',
                            onTap: () => setState(() => _type = 'income'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  LiquidGlassSurface(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Category',
                          style: Theme.of(
                            context,
                          ).textTheme.labelLarge?.copyWith(
                            color: scheme.onSurfaceVariant,
                            letterSpacing: 0.9,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: _categories
                              .map((category) {
                                final selected = _selectedCategory == category;
                                return ChoiceChip(
                                  selected: selected,
                                  label: Text(category),
                                  onSelected: (_) {
                                    setState(() {
                                      _selectedCategory = category;
                                    });
                                  },
                                );
                              })
                              .toList(growable: false),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  LiquidGlassSurface(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Notes',
                          style: Theme.of(
                            context,
                          ).textTheme.labelLarge?.copyWith(
                            color: scheme.onSurfaceVariant,
                            letterSpacing: 0.9,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          controller: _note,
                          maxLines: 3,
                          decoration: const InputDecoration(
                            hintText: 'What was this for?',
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),
                  SizedBox(
                    width: double.infinity,
                    child: Obx(
                      () => FilledButton.icon(
                        onPressed: _controller.isLoading.value ? null : _save,
                        icon: const Icon(Icons.check_rounded),
                        label: const Text('Save Transaction'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TypeButton extends StatelessWidget {
  const _TypeButton({
    required this.title,
    required this.isActive,
    required this.onTap,
  });

  final String title;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color:
              isActive
                  ? Colors.white.withValues(alpha: 0.12)
                  : Colors.transparent,
          border: Border.all(
            color:
                isActive
                    ? scheme.primary.withValues(alpha: 0.8)
                    : Colors.white.withValues(alpha: 0.12),
          ),
        ),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: isActive ? scheme.primary : scheme.onSurfaceVariant,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
