import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spend_analytics/core/routes/app_routes.dart';
import 'package:spend_analytics/features/voice/voice_controller.dart';
import 'package:spend_analytics/shared/widgets/liquid_glass_surface.dart';
import 'package:spend_analytics/shared/widgets/liquid_page_scaffold.dart';

/// Full-screen voice listening UI — pulsing rings, waveform bars, stop button.
///
/// Reads from [VoiceController] to show live transcript and navigate to
/// [AppRoutes.voiceReview] once speech is captured.
class VoiceInputScreen extends GetView<VoiceController> {
  const VoiceInputScreen({super.key});

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
          LiquidGlassSurface(
            padding: const EdgeInsets.all(14),
            child: Text(
              'Beta: voice capture is under active testing and stabilization.',
              textAlign: TextAlign.center,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: scheme.onSurfaceVariant),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Column(
              children: <Widget>[
                const Spacer(),
                _PulsingMic(scheme: scheme),
                const SizedBox(height: 24),
                const _WaveformBars(),
                const SizedBox(height: 24),
                Obx(
                  () => Text(
                    controller.isListening.value ? 'Listening...' : 'Ready',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: scheme.onSurface,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Try: "320 rupees for coffee at Blue Tokai"',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: scheme.onSurfaceVariant,
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
          Obx(
            () => FilledButton.icon(
              onPressed:
                  controller.isListening.value
                      ? controller.stopListening
                      : controller.startListening,
              icon: Icon(
                controller.isListening.value
                    ? Icons.stop_rounded
                    : Icons.mic_rounded,
              ),
              label: Text(controller.isListening.value ? 'Stop' : 'Start'),
              style: FilledButton.styleFrom(
                minimumSize: const Size.fromHeight(52),
                shape: const StadiumBorder(),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: <Widget>[
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => Get.toNamed(AppRoutes.voiceReview),
                  icon: const Icon(Icons.rate_review_rounded),
                  label: const Text('Review'),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => Get.toNamed(AppRoutes.addTxn),
                  icon: const Icon(Icons.edit_outlined),
                  label: const Text('Manual Entry'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
        ],
      ),
    );
  }
}

class _PulsingMic extends StatefulWidget {
  const _PulsingMic({required this.scheme});
  final ColorScheme scheme;

  @override
  State<_PulsingMic> createState() => _PulsingMicState();
}

class _PulsingMicState extends State<_PulsingMic>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _pulse;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: false);
    _pulse = CurvedAnimation(parent: _ctrl, curve: Curves.easeOut);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = widget.scheme;
    return SizedBox(
      width: 220,
      height: 220,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          // 4 pulsing rings
          for (int i = 0; i < 4; i++)
            AnimatedBuilder(
              animation: _pulse,
              builder: (_, __) {
                final phase = (_ctrl.value - i * 0.25).clamp(0.0, 1.0);
                return Opacity(
                  opacity: (1 - phase).clamp(0.0, 0.5 - i * 0.08),
                  child: Container(
                    width: 132.0 + i * 24,
                    height: 132.0 + i * 24,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: scheme.primary.withValues(alpha: 0.4 - i * 0.08),
                        width: 1.5,
                      ),
                    ),
                  ),
                );
              },
            ),
          // Mic button
          Container(
            width: 132,
            height: 132,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: const Alignment(-0.7, -0.7),
                end: Alignment.bottomRight,
                colors: <Color>[scheme.primary, scheme.secondary],
              ),
              shape: BoxShape.circle,
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: scheme.primary.withValues(alpha: 0.5),
                  blurRadius: 40,
                  offset: const Offset(0, 12),
                ),
                const BoxShadow(
                  color: Color(0x33FFFFFF),
                  blurRadius: 0,
                  spreadRadius: -2,
                ),
              ],
            ),
            alignment: Alignment.center,
            child: const Icon(Icons.mic_rounded, size: 56, color: Colors.white),
          ),
        ],
      ),
    );
  }
}

class _WaveformBars extends StatefulWidget {
  const _WaveformBars();

  @override
  State<_WaveformBars> createState() => _WaveformBarsState();
}

class _WaveformBarsState extends State<_WaveformBars>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  final _heights = <double>[18, 28, 22, 34, 24, 30, 16, 28, 22, 18, 26, 12];

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (_, __) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: List<Widget>.generate(_heights.length, (i) {
            final phase = (_ctrl.value + i * 0.08) % 1.0;
            final h = 8 + (_heights[i] - 8) * (0.4 + 0.6 * phase);
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 2),
              width: 4,
              height: h,
              decoration: BoxDecoration(
                color: scheme.primary.withValues(alpha: 0.6 + (i % 3) * 0.13),
                borderRadius: BorderRadius.circular(99),
              ),
            );
          }),
        );
      },
    );
  }
}
