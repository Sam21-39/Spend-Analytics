import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spend_analytics/features/rules/rules_controller.dart';

class RulesScreen extends GetView<RulesController> {
  const RulesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Smart Rules')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: const Icon(Icons.add),
        label: const Text('Add Rule'),
      ),
      body: Obx(
        () => ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: controller.rules.length,
          itemBuilder: (_, index) => Card(
            child: SwitchListTile(
              value: true,
              onChanged: (_) {},
              title: Text(controller.rules[index]),
            ),
          ),
        ),
      ),
    );
  }
}
