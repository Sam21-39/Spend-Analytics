import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spend_analytics/features/recurring/recurring_controller.dart';

class RecurringScreen extends GetView<RecurringController> {
  const RecurringScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Recurring Expenses')),
      body: Obx(
        () => ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: controller.recurringItems.length,
          itemBuilder: (_, index) => Card(
            child: ListTile(
              leading: const Icon(Icons.repeat),
              title: Text(controller.recurringItems[index]),
            ),
          ),
        ),
      ),
    );
  }
}
