import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spend_analytics/features/categories/category_controller.dart';
import 'package:spend_analytics/shared/widgets/icon_box.dart';
import 'package:spend_analytics/shared/widgets/liquid_glass_surface.dart';
import 'package:spend_analytics/shared/widgets/liquid_page_scaffold.dart';

class CategoryScreen extends GetView<CategoryController> {
  const CategoryScreen({super.key});

  static IconData _iconFor(String name) {
    switch (name.toLowerCase()) {
      case 'food':      return Icons.coffee_rounded;
      case 'rent':      return Icons.home_rounded;
      case 'transport': return Icons.directions_car_rounded;
      case 'shopping':  return Icons.shopping_bag_rounded;
      case 'health':    return Icons.favorite_rounded;
      case 'bills':     return Icons.bolt_rounded;
      case 'income':    return Icons.arrow_downward_rounded;
      default:          return Icons.sell_rounded;
    }
  }

  static Color _colorFor(String name) {
    switch (name.toLowerCase()) {
      case 'food':      return const Color(0xFFFF9F40);
      case 'rent':      return const Color(0xFF5B9FFF);
      case 'transport': return const Color(0xFF5B9FFF);
      case 'shopping':  return const Color(0xFFB0A0FF);
      case 'health':    return const Color(0xFFFF6B6B);
      case 'bills':     return const Color(0xFFFFB860);
      case 'income':    return const Color(0xFF3FDDA0);
      default:          return const Color(0xFF3FDDA0);
    }
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isDark  = Theme.of(context).brightness == Brightness.dark;

    return LiquidPageScaffold(
      title:         'Categories',
      showBottomNav: false,
      onBack:        () => Get.back<void>(),
      actions: <Widget>[
        BarActionButton(
          icon:  Icons.add_rounded,
          onTap: () => _showAddSheet(context),
        ),
      ],
      child: Obx(() {
        final cats = controller.categories;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Header note
            LiquidGlassSurface(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.drag_indicator_rounded,
                    size:  18,
                    color: scheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'Drag to reorder · Tap to rename',
                    style: TextStyle(
                      fontSize: 13,
                      color:    scheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            Text(
              'CATEGORIES',
              style: TextStyle(
                fontSize:      11,
                fontWeight:    FontWeight.w700,
                letterSpacing: 0.8,
                color:         scheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 10),

            // Reorderable list
            ReorderableListView.builder(
              shrinkWrap: true,
              physics:    const NeverScrollableScrollPhysics(),
              itemCount:  cats.length,
              onReorder:  (oldIdx, newIdx) {
                if (newIdx > oldIdx) newIdx -= 1;
                final updated = List<String>.from(cats);
                final item    = updated.removeAt(oldIdx);
                updated.insert(newIdx, item);
                cats.assignAll(updated);
              },
              itemBuilder: (ctx, i) {
                final name   = cats[i];
                final isLast = i == cats.length - 1;

                return Container(
                  key: ValueKey(name),
                  decoration: isLast
                      ? BoxDecoration(
                          color: isDark
                              ? Colors.white.withValues(alpha: 0.06)
                              : Colors.black.withValues(alpha: 0.03),
                          borderRadius: const BorderRadius.vertical(
                            bottom: Radius.circular(18),
                          ),
                        )
                      : BoxDecoration(
                          color: isDark
                              ? Colors.white.withValues(alpha: 0.06)
                              : Colors.black.withValues(alpha: 0.03),
                          border: Border(
                            bottom: BorderSide(
                              color: isDark
                                  ? Colors.white.withValues(alpha: 0.08)
                                  : Colors.black.withValues(alpha: 0.06),
                              width: 0.5,
                            ),
                          ),
                        ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical:   12,
                  ),
                  child: Row(
                    children: <Widget>[
                      IconBox(
                        icon:  _iconFor(name),
                        color: _colorFor(name),
                        size:  38,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          name,
                          style: TextStyle(
                            fontSize:   15,
                            fontWeight: FontWeight.w700,
                            color:      scheme.onSurface,
                          ),
                        ),
                      ),
                      Icon(
                        Icons.drag_handle_rounded,
                        size:  18,
                        color: scheme.onSurfaceVariant.withValues(alpha: 0.5),
                      ),
                    ],
                  ),
                );
              },
              proxyDecorator: (child, index, animation) => Material(
                color:       Colors.transparent,
                elevation:   0,
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
    final ctrl   = TextEditingController();
    final scheme = Theme.of(context).colorScheme;

    showModalBottomSheet<void>(
      context:           context,
      isScrollControlled: true,
      backgroundColor:   Colors.transparent,
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(
          left:   16,
          right:  16,
          top:    16,
          bottom: MediaQuery.of(ctx).viewInsets.bottom + 32,
        ),
        child: LiquidGlassSurface(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize:       MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Center(
                child: Container(
                  width:  36,
                  height: 4,
                  decoration: BoxDecoration(
                    color:        scheme.onSurfaceVariant.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
              ),
              const SizedBox(height: 18),
              Text(
                'New Category',
                style: TextStyle(
                  fontSize:   18,
                  fontWeight: FontWeight.w800,
                  color:      scheme.onSurface,
                ),
              ),
              const SizedBox(height: 14),
              TextField(
                controller:  ctrl,
                autofocus:   true,
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(
                  hintText:      'e.g. Entertainment',
                  hintStyle:     TextStyle(color: scheme.onSurfaceVariant),
                  filled:        true,
                  fillColor:     scheme.surfaceContainerHighest.withValues(alpha: 0.4),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide:   BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical:   14,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              FilledButton(
                onPressed: () {
                  final name = ctrl.text.trim();
                  if (name.isEmpty) return;
                  controller.categories.add(name);
                  Navigator.of(ctx).pop();
                  ctrl.dispose();
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
