import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spend_analytics/features/budgets/budget_controller.dart';

class BudgetScreen extends GetView<BudgetController> {
  const BudgetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Budgets')),
      body: Obx(
        () => ListView(
          padding: const EdgeInsets.all(16),
          children: controller.categoryBudgets.entries
              .map(
                (entry) => Card(
                  child: ListTile(
                    leading: const Icon(Icons.pie_chart),
                    title: Text(entry.key),
                    subtitle: Text('Limit ₹${entry.value.toStringAsFixed(0)}'),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
