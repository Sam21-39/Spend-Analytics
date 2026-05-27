import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spend_analytics/features/categories/category_controller.dart';
import 'package:spend_analytics/shared/utils/category_visuals.dart';
import 'package:spend_analytics/shared/widgets/icon_box.dart';
import 'package:spend_analytics/shared/widgets/liquid_glass_surface.dart';
import 'package:spend_analytics/shared/widgets/liquid_page_scaffold.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  late final CategoryController controller;
  String _selectedType = CategoryController.expenseType;

  @override
  void initState() {
    super.initState();
    controller = Get.find<CategoryController>();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return LiquidPageScaffold(
      title: 'Categories',
      showBottomNav: false,
      onBack: () => Get.back<void>(),
      actions: <Widget>[
        BarActionButton(
          icon: Icons.add_rounded,
          onTap: () => _showAddSheet(context),
        ),
      ],
      child: Obx(() {
        final cats = controller.categoriesForType(_selectedType);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            LiquidGlassSurface(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.drag_indicator_rounded,
                    size: 18,
                    color: scheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Main category -> sub-categories · Drag to reorder',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 13,
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            LiquidGlassSurface(
              padding: const EdgeInsets.all(4),
              borderRadius: const BorderRadius.all(Radius.circular(999)),
              child: Row(
                children: const <String>[
                      CategoryController.expenseType,
                      CategoryController.incomeType,
                      CategoryController.transferType,
                    ]
                    .map((type) {
                      final label =
                          '${type[0].toUpperCase()}${type.substring(1)}';
                      final active = type == _selectedType;
                      return Expanded(
                        child: GestureDetector(
                          onTap: () => setState(() => _selectedType = type),
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
                              label,
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
                    })
                    .toList(growable: false),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              '${_selectedType.toUpperCase()} SUB-CATEGORIES',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.8,
                color: scheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 10),
            ReorderableListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: cats.length,
              onReorder:
                  (oldIdx, newIdx) => controller.reorderCategories(
                    oldIdx,
                    newIdx,
                    type: _selectedType,
                  ),
              itemBuilder: (ctx, i) {
                final name = cats[i];
                final isLast = i == cats.length - 1;

                return Container(
                  key: ValueKey('$_selectedType-$name'),
                  decoration:
                      isLast
                          ? BoxDecoration(
                            color:
                                isDark
                                    ? Colors.white.withValues(alpha: 0.06)
                                    : Colors.black.withValues(alpha: 0.03),
                            borderRadius: const BorderRadius.vertical(
                              bottom: Radius.circular(18),
                            ),
                          )
                          : BoxDecoration(
                            color:
                                isDark
                                    ? Colors.white.withValues(alpha: 0.06)
                                    : Colors.black.withValues(alpha: 0.03),
                            border: Border(
                              bottom: BorderSide(
                                color:
                                    isDark
                                        ? Colors.white.withValues(alpha: 0.08)
                                        : Colors.black.withValues(alpha: 0.06),
                                width: 0.5,
                              ),
                            ),
                          ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  child: Row(
                    children: <Widget>[
                      IconBox(
                        icon: CategoryVisuals.iconFor(
                          name,
                          type: _selectedType,
                        ),
                        color: CategoryVisuals.colorFor(
                          name,
                          type: _selectedType,
                        ),
                        size: 38,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          name,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: scheme.onSurface,
                          ),
                        ),
                      ),
                      Icon(
                        Icons.drag_handle_rounded,
                        size: 18,
                        color: scheme.onSurfaceVariant.withValues(alpha: 0.5),
                      ),
                    ],
                  ),
                );
              },
              proxyDecorator:
                  (child, index, animation) => Material(
                    color: Colors.transparent,
                    elevation: 0,
                    borderRadius: BorderRadius.circular(18),
                    child: child,
                  ),
            ),
            const SizedBox(height: 20),
          ],
        );
      }),
    );
  }

  void _showAddSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder:
          (ctx) => _AddCategorySheet(
            controller: controller,
            selectedType: _selectedType,
          ),
    );
  }
}

class _AddCategorySheet extends StatefulWidget {
  const _AddCategorySheet({
    required this.controller,
    required this.selectedType,
  });

  final CategoryController controller;
  final String selectedType;

  @override
  State<_AddCategorySheet> createState() => _AddCategorySheetState();
}

class _AddCategorySheetState extends State<_AddCategorySheet> {
  String _nameInput = '';

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final typeLabel =
        '${widget.selectedType[0].toUpperCase()}${widget.selectedType.substring(1)}';
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: LiquidGlassSurface(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Center(
                child: Container(
                  width: 36,
                  height: 4,
                  decoration: BoxDecoration(
                    color: scheme.onSurfaceVariant.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
              ),
              const SizedBox(height: 18),
              Text(
                'New $typeLabel Sub-Category',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: scheme.onSurface,
                ),
              ),
              const SizedBox(height: 14),
              TextField(
                autofocus: true,
                textCapitalization: TextCapitalization.words,
                onChanged: (value) => _nameInput = value,
                decoration: InputDecoration(
                  hintText: 'e.g. Entertainment',
                  hintStyle: TextStyle(color: scheme.onSurfaceVariant),
                  filled: true,
                  fillColor: scheme.surfaceContainerHighest.withValues(
                    alpha: 0.4,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              FilledButton(
                onPressed: () async {
                  final name = _nameInput.trim();
                  if (name.isEmpty) {
                    return;
                  }
                  final added = await widget.controller.addCategory(
                    name,
                    type: widget.selectedType,
                  );
                  if (!added) {
                    if (!context.mounted) {
                      return;
                    }
                    Get.snackbar(
                      'Category exists',
                      'That category is already in this list.',
                    );
                    return;
                  }
                  if (!context.mounted) {
                    return;
                  }
                  Navigator.of(context).pop();
                },
                style: FilledButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                  shape: const StadiumBorder(),
                ),
                child: const Text(
                  'Add category',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
