import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spend_analytics/features/auth/auth_controller.dart';
import 'package:spend_analytics/features/transactions/transaction_controller.dart';
import 'package:spend_analytics/shared/models/transaction_model.dart';
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
  final TextEditingController _category = TextEditingController(text: 'Food');
  final TextEditingController _note = TextEditingController();

  @override
  void dispose() {
    _amount.dispose();
    _category.dispose();
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
      type: 'expense',
      category: _category.text.trim().isEmpty ? 'Other' : _category.text.trim(),
      paymentMode: 'upi',
      transactionDate: DateTime.now(),
      updatedAt: DateTime.now().toUtc(),
      note: _note.text.trim().isEmpty ? null : _note.text.trim(),
    );

    await _controller.addTransaction(txn);
    if (!mounted) return;
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Transaction')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _amount,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: const InputDecoration(labelText: 'Amount'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _category,
              decoration: const InputDecoration(labelText: 'Category'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _note,
              decoration: const InputDecoration(labelText: 'Note (optional)'),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: Obx(
                () => FilledButton(
                  onPressed: _controller.isLoading.value ? null : _save,
                  child: const Text('Save'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
