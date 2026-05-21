import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spend_analytics/core/routes/app_routes.dart';
import 'package:spend_analytics/features/dashboard/dashboard_controller.dart';

class DashboardScreen extends GetView<DashboardController> {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SpendSense Dashboard'),
        actions: <Widget>[
          IconButton(
            onPressed: () => Get.toNamed(AppRoutes.settings),
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Get.toNamed(AppRoutes.addTxn),
        icon: const Icon(Icons.add),
        label: const Text('Add Transaction'),
      ),
      body: Obx(
        () => ListView(
          padding: const EdgeInsets.all(16),
          children: <Widget>[
            Card(
              child: ListTile(
                title: const Text('Monthly Spend'),
                subtitle: Text('₹${controller.monthlySpend.value.toStringAsFixed(2)}'),
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: <Widget>[
                FilledButton.tonal(
                  onPressed: () => Get.toNamed(AppRoutes.analytics),
                  child: const Text('Analytics'),
                ),
                FilledButton.tonal(
                  onPressed: () => Get.toNamed(AppRoutes.budgets),
                  child: const Text('Budgets'),
                ),
                FilledButton.tonal(
                  onPressed: () => Get.toNamed(AppRoutes.rules),
                  child: const Text('Rules'),
                ),
                FilledButton.tonal(
                  onPressed: () => Get.toNamed(AppRoutes.recurring),
                  child: const Text('Recurring'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text('Recent Transactions', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            if (controller.transactions.isEmpty)
              const Card(child: ListTile(title: Text('No transactions yet'))),
            ...controller.transactions.take(8).map(
              (txn) => Card(
                child: ListTile(
                  title: Text('${txn.category} • ₹${txn.amount.toStringAsFixed(2)}'),
                  subtitle: Text(txn.transactionDate.toIso8601String().split('T').first),
                  trailing: Text(txn.type),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
