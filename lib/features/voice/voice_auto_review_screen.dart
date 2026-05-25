import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spend_analytics/features/voice/voice_controller.dart';
import 'package:spend_analytics/shared/widgets/liquid_glass_background.dart';
import 'package:spend_analytics/shared/widgets/liquid_glass_surface.dart';

class VoiceAutoReviewScreen extends GetView<VoiceController> {
  const VoiceAutoReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

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
                    const SizedBox(width: 4),
                    Text(
                      'Voice Auto-Review',
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(fontWeight: FontWeight.w800),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Obx(
                  () => LiquidGlassSurface(
                    child: Column(
                      children: <Widget>[
                        Icon(
                          controller.isListening.value
                              ? Icons.graphic_eq_rounded
                              : Icons.mic_rounded,
                          size: 42,
                          color: controller.isListening.value
                              ? scheme.tertiary
                              : const Color(0xFFADC6FF),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          controller.isListening.value
                              ? 'Listening...'
                              : controller.isSpeechAvailable.value
                                  ? 'Tap to start listening'
                                  : 'Speech unavailable on this device',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(color: scheme.primary),
                        ),
                        const SizedBox(height: 10),
                        FilledButton.icon(
                          onPressed: !controller.isSpeechAvailable.value
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
                                : 'Start Voice Capture',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Obx(
                  () => LiquidGlassSurface(
                    child: Text(
                      controller.transcript.value.isEmpty
                          ? 'Say something like: "Spent 450 rupees on dinner at Leon Grill"'
                          : '"${controller.transcript.value}"',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                _EditableField(
                  icon: Icons.currency_rupee_rounded,
                  title: 'Amount',
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  value: controller.amountText,
                ),
                const SizedBox(height: 8),
                LiquidGlassSurface(
                  child: Row(
                    children: <Widget>[
                      const CircleAvatar(child: Icon(Icons.category_rounded)),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Category',
                              style: Theme.of(context).textTheme.labelLarge
                                  ?.copyWith(color: scheme.onSurfaceVariant),
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
      child: Row(
        children: <Widget>[
          CircleAvatar(
            backgroundColor: Colors.white.withValues(alpha: 0.08),
            child: Icon(icon),
          ),
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
