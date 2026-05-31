import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:screenx/screenx.dart';
import 'package:spend_analytics/features/voice/voice_controller.dart';
import 'package:spend_analytics/shared/widgets/icon_box.dart';
import 'package:spend_analytics/shared/widgets/liquid_glass_surface.dart';
import 'package:spend_analytics/shared/widgets/liquid_page_scaffold.dart';

class VoiceAutoReviewScreen extends GetView<VoiceController> {
  const VoiceAutoReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return LiquidPageScaffold(
      title: 'Voice Entry (Beta)',
      showBottomNav: false,
      onBack: () => Get.back<void>(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // ── Status card ──────────────────────────────────────────────
          Obx(
            () => LiquidGlassSurface(
              padding: EdgeInsets.all(ScreenX.dp(18)),
              child: Column(
                children: <Widget>[
                  IconBox(
                    icon: controller.isListening.value
                        ? Icons.graphic_eq_rounded
                        : Icons.mic_rounded,
                    color: controller.isListening.value
                        ? scheme.tertiary
                        : scheme.primary,
                    size: ScreenX.dp(52),
                  ),
                  SizedBox(height: ScreenX.dp(10)),
                  Text(
                    !controller.voiceEntryEnabled.value
                        ? 'Voice Entry is disabled in Settings'
                        : controller.isListening.value
                        ? 'Listening...'
                        : 'Tap below to capture your voice entry',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: scheme.onSurface,
                      fontWeight: FontWeight.w700,
                      fontSize: ScreenX.sp(16),
                    ),
                  ),
                  SizedBox(height: ScreenX.dp(6)),
                  Text(
                    'This feature is in beta while we improve stability and recognition.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: scheme.onSurfaceVariant,
                      fontSize: ScreenX.sp(13),
                    ),
                  ),
                  SizedBox(height: ScreenX.dp(12)),
                  FilledButton.icon(
                    onPressed: !controller.voiceEntryEnabled.value
                        ? null
                        : controller.isListening.value
                        ? controller.stopListening
                        : controller.startListening,
                    icon: Icon(
                      controller.isListening.value
                          ? Icons.stop_rounded
                          : Icons.mic_rounded,
                    ),
                    label: Text(
                      controller.isListening.value
                          ? 'Stop'
                          : 'Start Voice Capture (Beta)',
                      style: TextStyle(fontSize: ScreenX.sp(14)),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: ScreenX.dp(12)),

          // ── Transcript preview ───────────────────────────────────────
          Obx(
            () => LiquidGlassSurface(
              padding: EdgeInsets.all(ScreenX.dp(16)),
              child: Text(
                controller.transcript.value.isEmpty
                    ? 'Say something like: "Spent 450 rupees on dinner at Leon Grill"'
                    : '"${controller.transcript.value}"',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: controller.transcript.value.isEmpty
                      ? scheme.onSurfaceVariant
                      : scheme.onSurface,
                  fontSize: ScreenX.sp(14),
                ),
              ),
            ),
          ),
          SizedBox(height: ScreenX.dp(12)),

          // ── Amount ──────────────────────────────────────────────────
          _EditableField(
            icon: Icons.currency_rupee_rounded,
            title: 'Amount',
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp(r'^\d{0,7}(\.\d{0,2})?')),
            ],
            value: controller.amountText,
          ),
          SizedBox(height: ScreenX.dp(8)),

          // ── Transaction type ─────────────────────────────────────────
          Obx(
            () => LiquidGlassSurface(
              padding: EdgeInsets.all(ScreenX.dp(14)),
              child: Row(
                children: <Widget>[
                  IconBox(
                    icon: Icons.swap_horiz_rounded,
                    color: const Color(0xFFFFB860),
                    size: ScreenX.dp(40),
                  ),
                  SizedBox(width: ScreenX.dp(12)),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Type',
                          style:
                              Theme.of(context).textTheme.labelLarge?.copyWith(
                                color: scheme.onSurfaceVariant,
                                fontSize: ScreenX.sp(12),
                              ),
                        ),
                        SizedBox(height: ScreenX.dp(6)),
                        DropdownButton<String>(
                          value: controller.type.value,
                          isExpanded: true,
                          underline: const SizedBox.shrink(),
                          style: TextStyle(
                            fontSize: ScreenX.sp(14),
                            fontWeight: FontWeight.w600,
                            color: scheme.onSurface,
                          ),
                          items: const <DropdownMenuItem<String>>[
                            DropdownMenuItem<String>(
                              value: 'expense',
                              child: Text('Expense'),
                            ),
                            DropdownMenuItem<String>(
                              value: 'income',
                              child: Text('Income'),
                            ),
                          ],
                          onChanged: (value) {
                            if (value != null) controller.type.value = value;
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: ScreenX.dp(8)),

          // ── Category ────────────────────────────────────────────────
          LiquidGlassSurface(
            padding: EdgeInsets.all(ScreenX.dp(14)),
            child: Row(
              children: <Widget>[
                IconBox(
                  icon: Icons.category_rounded,
                  color: const Color(0xFF5B9FFF),
                  size: ScreenX.dp(40),
                ),
                SizedBox(width: ScreenX.dp(12)),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Category',
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: scheme.onSurfaceVariant,
                          fontSize: ScreenX.sp(12),
                        ),
                      ),
                      SizedBox(height: ScreenX.dp(6)),
                      Obx(
                        () => DropdownButton<String>(
                          value: controller.category.value,
                          isExpanded: true,
                          underline: const SizedBox.shrink(),
                          style: TextStyle(
                            fontSize: ScreenX.sp(14),
                            fontWeight: FontWeight.w600,
                            color: scheme.onSurface,
                          ),
                          items: controller.categories
                              .map(
                                (item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(item),
                                ),
                              )
                              .toList(growable: false),
                          onChanged: (value) {
                            if (value != null) {
                              controller.category.value = value;
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: ScreenX.dp(8)),

          // ── Note ────────────────────────────────────────────────────
          _EditableField(
            icon: Icons.notes_rounded,
            title: 'Note',
            value: controller.note,
          ),
          SizedBox(height: ScreenX.dp(14)),

          FilledButton.icon(
            onPressed: controller.saveParsedTransaction,
            icon: const Icon(Icons.check_rounded),
            label: Text(
              'Confirm & Save',
              style: TextStyle(fontSize: ScreenX.sp(15)),
            ),
            style: FilledButton.styleFrom(
              minimumSize: Size.fromHeight(ScreenX.dp(52)),
              shape: const StadiumBorder(),
            ),
          ),
        ],
      ),
    );
  }
}

/// Editable field with proper theme-aware styling.
/// Uses the global InputDecorationTheme so dark/light mode font colors are
/// handled automatically — no more InputBorder.none override.
class _EditableField extends StatelessWidget {
  const _EditableField({
    required this.icon,
    required this.title,
    required this.value,
    this.keyboardType,
    this.inputFormatters,
  });

  final IconData icon;
  final String title;
  final RxString value;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return LiquidGlassSurface(
      padding: EdgeInsets.all(ScreenX.dp(14)),
      child: Row(
        children: <Widget>[
          IconBox(icon: icon, color: const Color(0xFFB0A0FF), size: ScreenX.dp(40)),
          SizedBox(width: ScreenX.dp(12)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: scheme.onSurfaceVariant,
                    fontSize: ScreenX.sp(12),
                  ),
                ),
                SizedBox(height: ScreenX.dp(2)),
                Obx(
                  () => TextFormField(
                    key: ValueKey<String>('${title}_${value.value}'),
                    initialValue: value.value,
                    keyboardType: keyboardType,
                    inputFormatters: inputFormatters,
                    onChanged: (next) => value.value = next,
                    // Use global theme styling — no border override
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: scheme.onSurface,
                      fontSize: ScreenX.sp(15),
                    ),
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 6,
                        horizontal: 0,
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: scheme.outline.withValues(alpha: 0.3),
                          width: 0.8,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: scheme.primary,
                          width: 1.5,
                        ),
                      ),
                    ),
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
