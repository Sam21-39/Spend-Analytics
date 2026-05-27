import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spend_analytics/core/routes/app_routes.dart';
import 'package:spend_analytics/features/voice/voice_controller.dart';
import 'package:spend_analytics/shared/widgets/liquid_glass_background.dart';

/// Full-screen voice listening UI — pulsing rings, waveform bars, stop button.
///
/// Reads from [VoiceController] to show live transcript and navigate to
/// [AppRoutes.voiceReview] once speech is captured.
class VoiceInputScreen extends GetView<VoiceController> {
  const VoiceInputScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: <Widget>[
          const LiquidGlassBackground(),
          SafeArea(
            child: Column(
              children: <Widget>[
                // Top bar
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical:   16,
                  ),
                  child: Row(
                    children: <Widget>[
                      _CircleBtn(
                        icon:  Icons.close_rounded,
                        color: scheme.onSurfaceVariant,
                        onTap: () => Get.back<void>(),
                      ),
                      const Spacer(),
                      Text(
                        'Voice input',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: scheme.onSurfaceVariant,
                        ),
                      ),
                      const Spacer(),
                      const SizedBox(width: 36), // balance
                    ],
                  ),
                ),

                const Spacer(),

                // Pulsing mic circle
                _PulsingMic(scheme: scheme),

                const SizedBox(height: 32),

                // Waveform bars
                const _WaveformBars(),

                const SizedBox(height: 32),

                Text(
                  'Listening…',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color:      scheme.onSurface,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 8),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: scheme.onSurfaceVariant,
                    ),
                    children: <TextSpan>[
                      const TextSpan(text: 'Try: '),
                      TextSpan(
                        text: '"320 rupees for coffee at Blue Tokai"',
                        style: TextStyle(
                          color:      scheme.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),

                const Spacer(),

                // Bottom controls
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 36),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      _CircleBtn(
                        icon:  Icons.close_rounded,
                        color: scheme.onSurfaceVariant,
                        onTap: () => Get.back<void>(),
                      ),
                      const SizedBox(width: 16),
                      // Stop button
                      GestureDetector(
                        onTap: () => Get.toNamed(AppRoutes.voiceReview),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 28,
                            vertical:   14,
                          ),
                          decoration: BoxDecoration(
                            color:        scheme.error,
                            borderRadius: BorderRadius.circular(999),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                color:      scheme.error.withValues(alpha: 0.4),
                                blurRadius: 24,
                                offset:     const Offset(0, 8),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Container(
                                width:  10,
                                height: 10,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(2),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              const Text(
                                'Stop',
                                style: TextStyle(
                                  color:      Colors.white,
                                  fontSize:   15,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      _CircleBtn(
                        icon:  Icons.edit_outlined,
                        color: scheme.onSurfaceVariant,
                        onTap: () => Get.toNamed(AppRoutes.addTxn),
                      ),
                    ],
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
    _ctrl  = AnimationController(
      vsync:    this,
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
      width:  220,
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
                    width:  132.0 + i * 24,
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
            width:  132,
            height: 132,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin:  const Alignment(-0.7, -0.7),
                end:    Alignment.bottomRight,
                colors: <Color>[scheme.primary, scheme.secondary],
              ),
              shape: BoxShape.circle,
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color:      scheme.primary.withValues(alpha: 0.5),
                  blurRadius: 40,
                  offset:     const Offset(0, 12),
                ),
                const BoxShadow(
                  color:      Color(0x33FFFFFF),
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
  final _heights = <double>[
    18, 28, 22, 34, 24, 30, 16, 28, 22, 18, 26, 12,
  ];

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync:    this,
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
            final h     = 8 + (_heights[i] - 8) * (0.4 + 0.6 * phase);
            return Container(
              margin:     const EdgeInsets.symmetric(horizontal: 2),
              width:      4,
              height:     h,
              decoration: BoxDecoration(
                color:        scheme.primary.withValues(
                  alpha: 0.6 + (i % 3) * 0.13,
                ),
                borderRadius: BorderRadius.circular(99),
              ),
            );
          }),
        );
      },
    );
  }
}

class _CircleBtn extends StatelessWidget {
  const _CircleBtn({
    required this.icon,
    required this.color,
    required this.onTap,
  });
  final IconData icon;
  final Color    color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width:  36,
        height: 36,
        decoration: BoxDecoration(
          color:  isDark
              ? Colors.white.withValues(alpha: 0.06)
              : Colors.black.withValues(alpha: 0.04),
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        child: Icon(icon, size: 18, color: color),
      ),
    );
  }
}
