import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spend_analytics/Core/UI/uicolors.dart';
import 'package:spend_analytics/Core/Utils/app_constatns.dart';
import 'package:spend_analytics/Data/ViewModel/Splash/cubit/splash_cubit.dart';
import 'package:spend_analytics/View/Screens/Setup/setup.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashCubit()..init(),
      child: BlocBuilder<SplashCubit, SplashState>(
        builder: (context, state) {
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 1600),
            child: state.isSplashLoaded
                ? Setup()
                : Container(
                    color: UiColors.backgroundLight,
                    child: Center(
                      child: Hero(
                        tag: '_logo',
                        child: SvgPicture.asset(
                          LOGO_SVG,
                        ),
                      ),
                    ),
                  ),
          );
        },
      ),
    );
  }
}
