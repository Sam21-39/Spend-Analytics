import 'package:flutter/material.dart';

class LiquidGlassBackground extends StatelessWidget {
  const LiquidGlassBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          DecoratedBox(
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                center: Alignment(-0.75, -0.65),
                radius: 0.8,
                colors: <Color>[
                  Color.fromRGBO(75, 142, 255, 0.22),
                  Colors.transparent,
                ],
              ),
            ),
          ),
          DecoratedBox(
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                center: Alignment(0.92, 0.78),
                radius: 0.9,
                colors: <Color>[
                  Color.fromRGBO(63, 223, 165, 0.20),
                  Colors.transparent,
                ],
              ),
            ),
          ),
          DecoratedBox(
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                center: Alignment(0.2, 0.3),
                radius: 1.0,
                colors: <Color>[
                  Color.fromRGBO(222, 5, 65, 0.10),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
