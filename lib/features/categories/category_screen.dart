import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spend_analytics/features/categories/category_controller.dart';
import 'package:spend_analytics/shared/widgets/liquid_glass_background.dart';
import 'package:spend_analytics/shared/widgets/liquid_glass_surface.dart';

class CategoryScreen extends GetView<CategoryController> {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: <Widget>[
          const LiquidGlassBackground(),
          SafeArea(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
              children: <Widget>[
                Row(
                  children: <Widget>[
                    IconButton(
                      onPressed: () => Get.back<void>(),
                      icon: const Icon(Icons.arrow_back_rounded),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'Categories',
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(fontWeight: FontWeight.w800),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Obx(
                  () => Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: controller.categories
                        .map(
                          (name) => LiquidGlassSurface(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 10,
                            ),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(999),
                            ),
                            child: Text(name),
                          ),
                        )
                        .toList(growable: false),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
