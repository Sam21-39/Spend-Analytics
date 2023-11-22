import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spend_analytics/Core/UI/uicolors.dart';
import 'package:spend_analytics/Core/Utils/app_constatns.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: UiColors.background,
      child: Center(
        child: SvgPicture.asset(
          LOGO_SVG,
        ),
      ),
    );
  }
}
