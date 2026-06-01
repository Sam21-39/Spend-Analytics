import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spend_analytics/core/routes/app_routes.dart';
import 'package:spend_analytics/features/analytics/analytics_controller.dart';
import 'package:spend_analytics/shared/utils/currency_formatter.dart';
import 'package:spend_analytics/shared/widgets/icon_box.dart';
import 'package:spend_analytics/shared/widgets/liquid_glass_surface.dart';
import 'package:spend_analytics/shared/widgets/liquid_page_scaffold.dart';
import 'package:spend_analytics/shared/widgets/sa_chip.dart';
import 'package:spend_analytics/shared/widgets/sa_pill.dart';
import 'package:spend_analytics/shared/widgets/sa_shimmer.dart';

class AnalyticsScreen extends GetView<AnalyticsController> {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return LiquidPageScaffold(
      title: 'Analytics',
      activeRoute: AppRoutes.analytics,
      actions: <Widget>[
        BarActionButton(
          icon: Icons.calendar_today_outlined,
          onTap:
              () => Get.snackbar(
                'Date range',
                'Use the range chips below to change analytics period.',
              ),
        ),
        const SizedBox(width: 4),
        BarActionButton(
          icon: Icons.more_horiz_rounded,
          onTap:
              () => Get.snackbar(
                'More options',
                'Advanced analytics actions are coming soon.',
              ),
        ),
      ],
      child: Obx(() {
        if (controller.isLoading.value) {
          return const _AnalyticsLoadingSkeleton();
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // ── Range chips ───────────────────────────────────────
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: Obx(
                () => Row(
                  children:
                      AnalyticsController.ranges.map((r) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: SAChip(
                            label: r,
                            active: controller.selectedRange.value == r,
                            onTap: () => controller.setRange(r),
                          ),
                        );
                      }).toList(),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // ── Headline metric + sparkline ────────────────────────
            LiquidGlassSurface(
              padding: const EdgeInsets.all(20),
              borderRadius: const BorderRadius.all(Radius.circular(24)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'NET FLOW · ${controller.selectedRange.value.toUpperCase()}',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 1.1,
                                color: scheme.onSurfaceVariant,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Obx(() {
                              final net = controller.netFlow.value;
                              return FittedBox(
                                fit: BoxFit.scaleDown,
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  '${net >= 0 ? '+' : '-'}${formatInr(net.abs())}',
                                  style: TextStyle(
                                    fontSize: 38,
                                    fontWeight: FontWeight.w800,
                                    color: scheme.onSurface,
                                    letterSpacing: -1.2,
                                    fontFeatures: const <FontFeature>[
                                      FontFeature.tabularFigures(),
                                    ],
                                  ),
                                ),
                              );
                            }),
                            const SizedBox(height: 8),
                            Row(
                              children: <Widget>[
                                SAPill(
                                  label:
                                      '${controller.deltaPct.value.toStringAsFixed(0)}%',
                                  color:
                                      controller.deltaIsUp.value
                                          ? scheme.tertiary
                                          : scheme.error,
                                  icon:
                                      controller.deltaIsUp.value
                                          ? Icons.arrow_upward_rounded
                                          : Icons.arrow_downward_rounded,
                                ),
                                const SizedBox(width: 8),
                                Flexible(
                                  child: Text(
                                    'vs previous period',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodyMedium?.copyWith(
                                      color: scheme.onSurfaceVariant,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Icon(
                        Icons.trending_up_rounded,
                        size: 32,
                        color: scheme.tertiary.withValues(alpha: 0.5),
                      ),
                    ],
                  ),

                  const SizedBox(height: 18),

                  // Sparkline area chart
                  Obx(() {
                    final data = controller.trendValues;
                    if (data.isEmpty) return const SizedBox(height: 120);
                    return SizedBox(
                      height: 120,
                      child: CustomPaint(
                        painter: _SparkAreaPainter(
                          data: data,
                          color: scheme.primary,
                        ),
                        size: const Size(double.infinity, 120),
                      ),
                    );
                  }),

                  const SizedBox(height: 6),
                  Obx(
                    () => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children:
                          controller.trendLabels.map((d) {
                            return Text(
                              d,
                              style: TextStyle(
                                fontSize: 10,
                                color: scheme.onSurfaceVariant.withValues(
                                  alpha: 0.6,
                                ),
                              ),
                            );
                          }).toList(),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // ── Category donut ────────────────────────────────────
            _SectionTitle('Spending breakdown'),
            const SizedBox(height: 10),
            Obx(() {
              final slices = controller.categorySlices;
              if (slices.isEmpty) {
                return LiquidGlassSurface(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    'No spending data for this range yet.',
                    style: TextStyle(
                      color: scheme.onSurfaceVariant,
                      fontSize: 13,
                    ),
                  ),
                );
              }
              return LiquidGlassSurface(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: <Widget>[
                    _DonutChart(
                      slices: slices,
                      centerLabel: formatInr(controller.totalSpent.value),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        children:
                            slices.map((c) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 6,
                                ),
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      width: 8,
                                      height: 8,
                                      decoration: BoxDecoration(
                                        color: c.color,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        c.name,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(color: scheme.onSurface),
                                      ),
                                    ),
                                    Text(
                                      '${(c.pct * 100).toStringAsFixed(1)}%',
                                      style: Theme.of(
                                        context,
                                      ).textTheme.titleSmall?.copyWith(
                                        color: scheme.onSurfaceVariant,
                                        fontFeatures: const <FontFeature>[
                                          FontFeature.tabularFigures(),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                      ),
                    ),
                  ],
                ),
              );
            }),

            const SizedBox(height: 20),

            // ── Top merchants ─────────────────────────────────────
            _SectionTitle(
              'Top merchants',
              action: 'All',
              onAction: () => Get.toNamed(AppRoutes.txns),
            ),
            const SizedBox(height: 10),
            Obx(() {
              final merchants = controller.topMerchants;
              if (merchants.isEmpty) {
                return LiquidGlassSurface(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    'No merchant insights yet.',
                    style: TextStyle(
                      color: scheme.onSurfaceVariant,
                      fontSize: 13,
                    ),
                  ),
                );
              }
              return LiquidGlassSurface(
                padding: EdgeInsets.zero,
                child: Column(
                  children: List<Widget>.generate(merchants.length, (i) {
                    final m = merchants[i];
                    final isLast = i == merchants.length - 1;
                    final isDark =
                        Theme.of(context).brightness == Brightness.dark;
                    return Container(
                      decoration:
                          isLast
                              ? null
                              : BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color:
                                        isDark
                                            ? Colors.white.withValues(
                                              alpha: 0.08,
                                            )
                                            : Colors.black.withValues(
                                              alpha: 0.06,
                                            ),
                                    width: 0.5,
                                  ),
                                ),
                              ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 12,
                      ),
                      child: Row(
                        children: <Widget>[
                          IconBox(icon: m.icon, color: m.color, size: 36),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  m.name,
                                  style: Theme.of(
                                    context,
                                  ).textTheme.titleSmall?.copyWith(
                                    color: scheme.onSurface,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Text(
                                  '${m.txns} txns · ${m.category}',
                                  style: Theme.of(
                                    context,
                                  ).textTheme.bodySmall?.copyWith(
                                    color: scheme.onSurfaceVariant,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            formatInr(m.amount),
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w800,
                              color: scheme.onSurface,
                              fontFeatures: const <FontFeature>[
                                FontFeature.tabularFigures(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              );
            }),

            const SizedBox(height: 20),

            // ── AI Insight ────────────────────────────────────────
            LiquidGlassSurface(
              padding: const EdgeInsets.all(18),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: <Color>[scheme.secondary, scheme.primary],
                      ),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: scheme.secondary.withValues(alpha: 0.4),
                          blurRadius: 18,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.auto_awesome_rounded,
                      size: 20,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Insight',
                          style: Theme.of(
                            context,
                          ).textTheme.titleSmall?.copyWith(
                            color: scheme.onSurface,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Obx(
                          () => Text(
                            controller.insightText.value,
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(color: scheme.onSurfaceVariant),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: <Widget>[
                            GestureDetector(
                              onTap: () => Get.toNamed(AppRoutes.budgets),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 14,
                                  vertical: 7,
                                ),
                                decoration: BoxDecoration(
                                  color: scheme.primary.withValues(alpha: 0.18),
                                  borderRadius: BorderRadius.circular(999),
                                  border: Border.all(
                                    color: scheme.primary.withValues(
                                      alpha: 0.3,
                                    ),
                                    width: 0.5,
                                  ),
                                ),
                                child: Text(
                                  'Set budget',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    color: scheme.primary,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Text(
                              'Dismiss',
                              style: TextStyle(
                                fontSize: 12,
                                color: scheme.onSurfaceVariant,
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
          ],
        );
      }),
    );
  }
}

// ── Sub-widgets & helpers ─────────────────────────────────────────────────────

class _AnalyticsLoadingSkeleton extends StatelessWidget {
  const _AnalyticsLoadingSkeleton();

  @override
  Widget build(BuildContext context) {
    return SAShimmer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: const <Widget>[
          SAShimmerBox(height: 36, radius: 16),
          SizedBox(height: 16),
          SAShimmerBox(height: 250, radius: 24),
          SizedBox(height: 20),
          SAShimmerBox(height: 16, width: 160, radius: 8),
          SizedBox(height: 10),
          SAShimmerBox(height: 180, radius: 22),
          SizedBox(height: 20),
          SAShimmerBox(height: 16, width: 150, radius: 8),
          SizedBox(height: 10),
          SAShimmerBox(height: 220, radius: 22),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.title, {this.action, this.onAction});
  final String title;
  final String? action;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Row(
      children: <Widget>[
        Text(
          title.toUpperCase(),
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.8,
            color: scheme.onSurfaceVariant,
          ),
        ),
        const Spacer(),
        if (action != null)
          GestureDetector(
            onTap: onAction,
            child: Row(
              children: <Widget>[
                Text(
                  action!,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: scheme.primary,
                  ),
                ),
                Icon(
                  Icons.chevron_right_rounded,
                  size: 14,
                  color: scheme.primary,
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class _DonutChart extends StatelessWidget {
  const _DonutChart({required this.slices, required this.centerLabel});
  final List<AnalyticsCategorySlice> slices;
  final String centerLabel;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return SizedBox(
      width: 112,
      height: 112,
      child: CustomPaint(
        painter: _DonutPainter(slices: slices, scheme: scheme),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'SPENT',
                style: TextStyle(
                  fontSize: 8,
                  fontWeight: FontWeight.w700,
                  color: scheme.onSurfaceVariant,
                ),
              ),
              Text(
                centerLabel,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  color: scheme.onSurface,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DonutPainter extends CustomPainter {
  const _DonutPainter({required this.slices, required this.scheme});
  final List<AnalyticsCategorySlice> slices;
  final ColorScheme scheme;

  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2;
    final r = size.width * 0.42;
    const stroke = 14.0;

    // Track
    canvas.drawCircle(
      Offset(cx, cy),
      r,
      Paint()
        ..color = Colors.white.withValues(alpha: 0.1)
        ..strokeWidth = stroke
        ..style = PaintingStyle.stroke,
    );

    double offset = -math.pi / 2;
    for (final s in slices) {
      final sweep = 2 * math.pi * s.pct;
      // Glow
      canvas.drawArc(
        Rect.fromCircle(center: Offset(cx, cy), radius: r),
        offset,
        sweep,
        false,
        Paint()
          ..color = s.color.withValues(alpha: 0.4)
          ..strokeWidth = stroke + 4
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.butt
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4),
      );
      // Solid
      canvas.drawArc(
        Rect.fromCircle(center: Offset(cx, cy), radius: r),
        offset,
        sweep,
        false,
        Paint()
          ..color = s.color
          ..strokeWidth = stroke
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.butt,
      );
      offset += sweep;
    }
  }

  @override
  bool shouldRepaint(_DonutPainter old) => false;
}

class _SparkAreaPainter extends CustomPainter {
  const _SparkAreaPainter({required this.data, required this.color});
  final List<double> data;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    if (data.isEmpty) return;
    final maxV = data.reduce(math.max);
    if (maxV == 0) return;

    final pts = List<Offset>.generate(data.length, (i) {
      final x = i * size.width / (data.length - 1);
      final y = size.height - (data[i] / maxV) * size.height * 0.85 - 6;
      return Offset(x, y);
    });

    final linePath = Path()..moveTo(pts[0].dx, pts[0].dy);
    for (int i = 1; i < pts.length; i++) {
      linePath.lineTo(pts[i].dx, pts[i].dy);
    }

    final areaPath =
        Path()
          ..addPath(linePath, Offset.zero)
          ..lineTo(size.width, size.height)
          ..lineTo(0, size.height)
          ..close();

    canvas.drawPath(
      areaPath,
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[
            color.withValues(alpha: 0.4),
            color.withValues(alpha: 0),
          ],
        ).createShader(Rect.fromLTWH(0, 0, size.width, size.height)),
    );

    // Grid lines
    for (final frac in <double>[0.25, 0.5, 0.75]) {
      final y = size.height * frac;
      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y),
        Paint()
          ..color = Colors.white.withValues(alpha: 0.12)
          ..strokeWidth = 0.5
          ..style = PaintingStyle.stroke,
      );
    }

    // Line + glow
    canvas.drawPath(
      linePath,
      Paint()
        ..color = color.withValues(alpha: 0.5)
        ..strokeWidth = 6
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4),
    );
    canvas.drawPath(
      linePath,
      Paint()
        ..color = color
        ..strokeWidth = 2
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round,
    );

    // Highlight dot
    if (pts.length > 19) {
      final dot = pts[19];
      canvas.drawCircle(dot, 9, Paint()..color = color.withValues(alpha: 0.2));
      canvas.drawCircle(dot, 4, Paint()..color = color);
    }
  }

  @override
  bool shouldRepaint(_SparkAreaPainter old) =>
      old.data != data || old.color != color;
}
