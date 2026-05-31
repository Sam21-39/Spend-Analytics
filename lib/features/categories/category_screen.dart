import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:screenx/screenx.dart';
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
            // ── Info banner ──────────────────────────────────────
            LiquidGlassSurface(
              padding: EdgeInsets.all(ScreenX.dp(16)),
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.drag_indicator_rounded,
                    size: ScreenX.dp(18),
                    color: scheme.onSurfaceVariant,
                  ),
                  SizedBox(width: ScreenX.dp(10)),
                  Expanded(
                    child: Text(
                      'Main category → sub-categories · Drag to reorder',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: ScreenX.sp(13),
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: ScreenX.dp(14)),

            // ── Type toggle ──────────────────────────────────────
            LiquidGlassSurface(
              padding: EdgeInsets.all(ScreenX.dp(4)),
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
                            padding: EdgeInsets.symmetric(
                              vertical: ScreenX.dp(10),
                            ),
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
                                fontSize: ScreenX.sp(14),
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
            SizedBox(height: ScreenX.dp(16)),

            // ── Section label ────────────────────────────────────
            Text(
              '${_selectedType.toUpperCase()} SUB-CATEGORIES',
              style: TextStyle(
                fontSize: ScreenX.sp(11),
                fontWeight: FontWeight.w700,
                letterSpacing: 0.8,
                color: scheme.onSurfaceVariant,
              ),
            ),
            SizedBox(height: ScreenX.dp(10)),

            // ── Reorderable list ─────────────────────────────────
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
                  padding: EdgeInsets.symmetric(
                    horizontal: ScreenX.dp(16),
                    vertical: ScreenX.dp(12),
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
                        size: ScreenX.dp(38),
                      ),
                      SizedBox(width: ScreenX.dp(12)),
                      Expanded(
                        child: Text(
                          name,
                          style: TextStyle(
                            fontSize: ScreenX.sp(15),
                            fontWeight: FontWeight.w700,
                            color: scheme.onSurface,
                          ),
                        ),
                      ),
                      Icon(
                        Icons.drag_handle_rounded,
                        size: ScreenX.dp(18),
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
            SizedBox(height: ScreenX.dp(20)),
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

// ── Add Category Sheet ────────────────────────────────────────────────────────

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
  final TextEditingController _nameCtrl = TextEditingController();
  String? _nameError;

  @override
  void dispose() {
    _nameCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final typeLabel =
        '${widget.selectedType[0].toUpperCase()}${widget.selectedType.substring(1)}';

    return Padding(
      padding: EdgeInsets.only(
        left: ScreenX.dp(16),
        right: ScreenX.dp(16),
        top: ScreenX.dp(16),
        bottom: MediaQuery.of(context).viewInsets.bottom + ScreenX.dp(24),
      ),
      child: LiquidGlassSurface(
        padding: EdgeInsets.all(ScreenX.dp(20)),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // Drag handle
              Center(
                child: Container(
                  width: ScreenX.dp(36),
                  height: ScreenX.dp(4),
                  decoration: BoxDecoration(
                    color: scheme.onSurfaceVariant.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
              ),
              SizedBox(height: ScreenX.dp(18)),

              Text(
                'New $typeLabel Sub-Category',
                style: TextStyle(
                  fontSize: ScreenX.sp(18),
                  fontWeight: FontWeight.w800,
                  color: scheme.onSurface,
                ),
              ),
              SizedBox(height: ScreenX.dp(14)),

              // ── Name input ──────────────────────────────────────
              TextField(
                controller: _nameCtrl,
                autofocus: true,
                textCapitalization: TextCapitalization.words,
                maxLength: 40,
                onChanged: (_) {
                  if (_nameError != null) {
                    setState(() => _nameError = null);
                  }
                },
                decoration: InputDecoration(
                  hintText: 'e.g. Entertainment',
                  prefixIcon: const Icon(Icons.category_outlined),
                  errorText: _nameError,
                  counterText: '',
                ),
              ),
              SizedBox(height: ScreenX.dp(16)),

              FilledButton(
                onPressed: () async {
                  final name = _nameCtrl.text.trim();
                  if (name.isEmpty) {
                    setState(() => _nameError = 'Category name cannot be empty');
                    return;
                  }
                  final added = await widget.controller.addCategory(
                    name,
                    type: widget.selectedType,
                  );
                  if (!added) {
                    if (!context.mounted) return;
                    setState(
                      () => _nameError = 'That category already exists',
                    );
                    return;
                  }
                  if (!context.mounted) return;
                  Navigator.of(context).pop();
                },
                style: FilledButton.styleFrom(
                  minimumSize: Size.fromHeight(ScreenX.dp(50)),
                  shape: const StadiumBorder(),
                ),
                child: Text(
                  'Add category',
                  style: TextStyle(
                    fontSize: ScreenX.sp(15),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
