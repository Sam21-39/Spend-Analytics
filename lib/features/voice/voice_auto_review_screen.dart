import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
          Obx(
            () => LiquidGlassSurface(
              padding: const EdgeInsets.all(18),
              child: Column(
                children: <Widget>[
                  IconBox(
                    icon:
                        controller.isListening.value
                            ? Icons.graphic_eq_rounded
                            : Icons.mic_rounded,
                    color:
                        controller.isListening.value
                            ? scheme.tertiary
                            : scheme.primary,
                    size: 52,
                  ),
                  const SizedBox(height: 10),
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
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'This feature is in beta while we improve stability and recognition.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 12),
                  FilledButton.icon(
                    onPressed:
                        !controller.voiceEntryEnabled.value
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
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Obx(
            () => LiquidGlassSurface(
              padding: const EdgeInsets.all(16),
              child: Text(
                controller.transcript.value.isEmpty
                    ? 'Say something like: "Spent 450 rupees on dinner at Leon Grill"'
                    : '"${controller.transcript.value}"',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color:
                      controller.transcript.value.isEmpty
                          ? scheme.onSurfaceVariant
                          : scheme.onSurface,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          _EditableField(
            icon: Icons.currency_rupee_rounded,
            title: 'Amount',
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            value: controller.amountText,
          ),
          const SizedBox(height: 8),
          LiquidGlassSurface(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: <Widget>[
                IconBox(
                  icon: Icons.category_rounded,
                  color: const Color(0xFF5B9FFF),
                  size: 40,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Category',
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: scheme.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Obx(
                        () => DropdownButton<String>(
                          value: controller.category.value,
                          isExpanded: true,
                          underline: const SizedBox.shrink(),
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
          const SizedBox(height: 8),
          _EditableField(
            icon: Icons.notes_rounded,
            title: 'Note',
            value: controller.note,
          ),
          const SizedBox(height: 14),
          FilledButton.icon(
            onPressed: controller.saveParsedTransaction,
            icon: const Icon(Icons.check_rounded),
            label: const Text('Confirm & Save'),
            style: FilledButton.styleFrom(
              minimumSize: const Size.fromHeight(52),
              shape: const StadiumBorder(),
            ),
          ),
        ],
      ),
    );
  }
}

class _EditableField extends StatelessWidget {
  const _EditableField({
    required this.icon,
    required this.title,
    required this.value,
    this.keyboardType,
  });

  final IconData icon;
  final String title;
  final RxString value;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return LiquidGlassSurface(
      padding: const EdgeInsets.all(14),
      child: Row(
        children: <Widget>[
          IconBox(icon: icon, color: const Color(0xFFB0A0FF), size: 40),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: scheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 2),
                Obx(
                  () => TextFormField(
                    key: ValueKey<String>('${title}_${value.value}'),
                    initialValue: value.value,
                    keyboardType: keyboardType,
                    onChanged: (next) => value.value = next,
                    decoration: const InputDecoration(
                      isDense: true,
                      border: InputBorder.none,
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
