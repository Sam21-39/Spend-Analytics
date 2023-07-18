import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spend_analytics/Functions/Blocs/splash/splash_bloc.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  late SpalshBloc spalshBloc;
  @override
  void initState() {
    super.initState();
    spalshBloc = SpalshBloc();
    spalshBloc.init(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Theme.of(context).colorScheme.background,
      child: Center(
        child: Hero(
          tag: "logo",
          child: SizedBox(
            width: 150.w,
            child: SvgPicture.asset(
              'assets/images/sp_logo.svg',
            ),
          ),
        ),
      ),
    );
  }
}
