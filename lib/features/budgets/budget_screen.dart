import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spend_analytics/core/routes/app_routes.dart';
import 'package:spend_analytics/features/budgets/budget_controller.dart';
import 'package:spend_analytics/features/categories/category_controller.dart';
import 'package:spend_analytics/shared/utils/category_visuals.dart';
import 'package:spend_analytics/shared/utils/currency_formatter.dart';
import 'package:spend_analytics/shared/widgets/icon_box.dart';
import 'package:spend_analytics/shared/widgets/liquid_glass_surface.dart';
import 'package:spend_analytics/shared/widgets/liquid_page_scaffold.dart';
import 'package:spend_analytics/shared/widgets/ring_progress.dart';
import 'package:spend_analytics/shared/widgets/sa_progress_bar.dart';
import 'package:spend_analytics/shared/widgets/sa_shimmer.dart';

class BudgetScreen extends GetView<BudgetController> {
  const BudgetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return LiquidPageScaffold(
      title: 'Budgets',
      activeRoute: AppRoutes.budgets,
      actions: <Widget>[
        BarActionButton(
          icon: Icons.add_rounded,
          onTap: () => _showAddBudgetSheet(context),
        ),
      ],
      child: Obx(() {
        if (controller.isLoading.value) {
          return const _BudgetLoadingSkeleton();
        }
        final budgets = controller.categoryBudgets;
        final spend = controller.categorySpend;

        final totalLimit = budgets.values.fold<double>(0, (s, v) => s + v);
        final totalSpent = budgets.keys.fold<double>(
          0,
          (s, k) => s + (spend[k] ?? 0),
        );
        final overallPct =
            totalLimit == 0 ? 0.0 : (totalSpent / totalLimit).clamp(0.0, 1.0);

        Color ringColor;
        if (overallPct >= 1.0)
          ringColor = const Color(0xFFFF6B6B);
        else if (overallPct >= 0.8)
          ringColor = const Color(0xFFFFB860);
        else
          ringColor = const Color(0xFF3FDDA0);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // ── Overall summary ring ──────────────────────────────
            LiquidGlassSurface(
              padding: const EdgeInsets.all(24),
              child: Row(
                children: <Widget>[
                  RingProgress(
                    size: 84,
                    value: overallPct,
                    stroke: 9,
                    color: ringColor,
                  ),
                  const SizedBox(width: 24),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Monthly Overview',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: scheme.onSurfaceVariant,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          formatInr(totalSpent),
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w800,
                            color: scheme.onSurface,
                            letterSpacing: -0.5,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'of ${formatInr(totalLimit)} total budget',
                          style: TextStyle(
                            fontSize: 13,
                            color: scheme.onSurfaceVariant,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: <Widget>[
                            _StatusDot(color: ringColor),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                '${(overallPct * 100).toStringAsFixed(0)}% used · '
                                '${formatInr(totalLimit - totalSpent)} remaining',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: scheme.onSurfaceVariant,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // ── Section heading ───────────────────────────────────
            Text(
              'CATEGORIES',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.8,
                color: scheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 10),

            // ── Per-category cards ────────────────────────────────
            ...budgets.entries.map((entry) {
              final cat = entry.key;
              final limit = entry.value;
              final spent = spend[cat] ?? 0;
              final usage = limit == 0 ? 0.0 : spent / limit;
              final pct = usage.clamp(0.0, 1.0);

              Color barColor;
              Color statusColor;
              IconData statusIcon;
              String statusText;

              if (usage >= 1.0) {
                barColor = const Color(0xFFFF6B6B);
                statusColor = const Color(0xFFFF6B6B);
                statusIcon = Icons.error_rounded;
                statusText = '${formatInr(spent - limit)} over';
              } else if (usage >= 0.8) {
                barColor = const Color(0xFFFFB860);
                statusColor = const Color(0xFFFFB860);
                statusIcon = Icons.warning_amber_rounded;
                statusText = '${formatInr(limit - spent)} left';
              } else {
                barColor = const Color(0xFF3FDDA0);
                statusColor = const Color(0xFF3FDDA0);
                statusIcon = Icons.check_circle_rounded;
                statusText = '${formatInr(limit - spent)} left';
              }

              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: LiquidGlassSurface(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          IconBox(
                            icon: CategoryVisuals.iconFor(cat),
                            color: CategoryVisuals.colorFor(cat),
                            size: 40,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  cat,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                    color: scheme.onSurface,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  '${formatInr(spent)} of ${formatInr(limit)}',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: scheme.onSurfaceVariant,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Icon(statusIcon, size: 14, color: statusColor),
                              const SizedBox(width: 4),
                              Text(
                                statusText,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: statusColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),
                      SAProgressBar(value: pct, color: barColor, height: 7),
                      const SizedBox(height: 6),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            '${(pct * 100).toStringAsFixed(0)}% used',
                            style: TextStyle(
                              fontSize: 11,
                              color: scheme.onSurfaceVariant,
                            ),
                          ),
                          GestureDetector(
                            onTap:
                                () => Get.toNamed(
                                  AppRoutes.budgetDetail,
                                  arguments: <String, dynamic>{
                                    'category': cat,
                                    'limit': limit,
                                    'spent': spent,
                                    'color': CategoryVisuals.colorFor(cat),
                                    'icon': CategoryVisuals.iconFor(cat),
                                  },
                                ),
                            child: Text(
                              'Details →',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: scheme.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }),

            const SizedBox(height: 4),

            // ── Add budget dashed button ───────────────────────────
            GestureDetector(
              onTap: () => _showAddBudgetSheet(context),
              child: DashedBorderContainer(
                isDark: isDark,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.add_rounded,
                      size: 18,
                      color: scheme.onSurfaceVariant,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'Add a budget',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),
          ],
        );
      }),
    );
  }

  Future<void> _showAddBudgetSheet(BuildContext context) async {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _AddBudgetSheet(controller: controller),
    );
  }
}

// ── Helpers ────────────────────────────────────────────────────────────────

class _AddBudgetSheet extends StatefulWidget {
  const _AddBudgetSheet({required this.controller});

  final BudgetController controller;

  @override
  State<_AddBudgetSheet> createState() => _AddBudgetSheetState();
}

class _AddBudgetSheetState extends State<_AddBudgetSheet> {
  String _amountInput = '';
  String? _selectedCategory;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
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
                'Add / Update Budget',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: scheme.onSurface,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'CATEGORY',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1,
                  color: scheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 8),
              Obx(() {
                final categoryController = Get.find<CategoryController>();
                final groups = <String, List<String>>{
                  CategoryController.expenseType: categoryController
                      .categoriesForType(CategoryController.expenseType),
                  CategoryController.incomeType: categoryController
                      .categoriesForType(CategoryController.incomeType),
                  CategoryController.transferType: categoryController
                      .categoriesForType(CategoryController.transferType),
                };
                Widget buildChip(String type, String name) {
                  final active = _selectedCategory == name;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedCategory = name),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 150),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(999),
                        color:
                            active
                                ? scheme.primary.withValues(alpha: 0.14)
                                : scheme.surfaceContainerHighest.withValues(
                                  alpha: 0.4,
                                ),
                        border: Border.all(
                          color:
                              active
                                  ? scheme.primary.withValues(alpha: 0.4)
                                  : scheme.outline.withValues(alpha: 0.2),
                          width: 0.8,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Icon(
                            CategoryVisuals.iconFor(name, type: type),
                            size: 14,
                            color:
                                active
                                    ? scheme.primary
                                    : CategoryVisuals.colorFor(
                                      name,
                                      type: type,
                                    ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            name,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: active ? scheme.primary : scheme.onSurface,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                Widget buildGroup(String type, List<String> names) {
                  final label = '${type[0].toUpperCase()}${type.substring(1)}';
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        label,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: scheme.onSurfaceVariant,
                          letterSpacing: 0.6,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: names
                            .map((name) => buildChip(type, name))
                            .toList(growable: false),
                      ),
                    ],
                  );
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    buildGroup(
                      CategoryController.expenseType,
                      groups[CategoryController.expenseType]!,
                    ),
                    const SizedBox(height: 10),
                    buildGroup(
                      CategoryController.incomeType,
                      groups[CategoryController.incomeType]!,
                    ),
                    const SizedBox(height: 10),
                    buildGroup(
                      CategoryController.transferType,
                      groups[CategoryController.transferType]!,
                    ),
                  ],
                );
              }),
              const SizedBox(height: 18),
              Text(
                'MONTHLY LIMIT',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1,
                  color: scheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                onChanged: (value) => _amountInput = value,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: scheme.onSurface,
                ),
                decoration: InputDecoration(
                  prefixText: '₹ ',
                  prefixStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: scheme.onSurfaceVariant,
                  ),
                  hintText: '0',
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
              const SizedBox(height: 20),
              FilledButton(
                onPressed: () async {
                  final cat = _selectedCategory;
                  final amount = double.tryParse(_amountInput.trim());
                  if (cat == null) {
                    Get.snackbar(
                      'Select a category',
                      'Please choose a category.',
                    );
                    return;
                  }
                  if (amount == null || amount <= 0) {
                    Get.snackbar(
                      'Invalid amount',
                      'Please enter a valid amount.',
                    );
                    return;
                  }
                  await widget.controller.upsertBudget(cat, amount);
                  if (mounted) {
                    Navigator.of(context).pop();
                  }
                },
                style: FilledButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                  shape: const StadiumBorder(),
                ),
                child: const Text(
                  'Save budget',
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

class _BudgetLoadingSkeleton extends StatelessWidget {
  const _BudgetLoadingSkeleton();

  @override
  Widget build(BuildContext context) {
    return SAShimmer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: const <Widget>[
          SAShimmerBox(height: 132, radius: 24),
          SizedBox(height: 18),
          SAShimmerBox(height: 16, width: 140, radius: 8),
          SizedBox(height: 10),
          SAShimmerBox(height: 124, radius: 20),
          SizedBox(height: 12),
          SAShimmerBox(height: 124, radius: 20),
          SizedBox(height: 12),
          SAShimmerBox(height: 124, radius: 20),
          SizedBox(height: 14),
          SAShimmerBox(height: 52, radius: 14),
        ],
      ),
    );
  }
}

class _StatusDot extends StatelessWidget {
  const _StatusDot({required this.color});
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: color.withValues(alpha: 0.5),
            blurRadius: 4,
            spreadRadius: 1,
          ),
        ],
      ),
    );
  }
}

class DashedBorderContainer extends StatelessWidget {
  const DashedBorderContainer({
    super.key,
    required this.child,
    required this.isDark,
  });
  final Widget child;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final borderColor =
        isDark
            ? Colors.white.withValues(alpha: 0.18)
            : Colors.black.withValues(alpha: 0.14);

    return CustomPaint(
      painter: _DashedBorderPainter(color: borderColor),
      child: SizedBox(height: 52, child: Center(child: child)),
    );
  }
}

class _DashedBorderPainter extends CustomPainter {
  const _DashedBorderPainter({required this.color});
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    const radius = 14.0;
    const dash = 6.0;
    const gap = 4.0;
    final paint =
        Paint()
          ..color = color
          ..strokeWidth = 1
          ..style = PaintingStyle.stroke;

    final rect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      const Radius.circular(radius),
    );
    final path = Path()..addRRect(rect);
    final metrics = path.computeMetrics();
    for (final m in metrics) {
      double dist = 0;
      while (dist < m.length) {
        canvas.drawPath(m.extractPath(dist, dist + dash), paint);
        dist += dash + gap;
      }
    }
  }

  @override
  bool shouldRepaint(_DashedBorderPainter old) => old.color != color;
}
