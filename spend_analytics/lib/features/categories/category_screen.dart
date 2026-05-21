import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spend_analytics/features/categories/category_controller.dart';

class CategoryScreen extends GetView<CategoryController> {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Categories')),
      body: Obx(
        () => ListView(
          padding: const EdgeInsets.all(16),
          children: controller.categories
              .map((name) => Card(child: ListTile(title: Text(name))))
              .toList(),
        ),
      ),
    );
  }
}
