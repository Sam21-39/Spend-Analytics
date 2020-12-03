import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spend_analytics/Screens/MainDashboard/main_dashboard.dart';
import 'package:spend_analytics/Screens/Onboarding/onboadring.dart';
import 'package:spend_analytics/Utils/sp_constants.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  bool isOnboardingDone = false;
  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((sp) {
      setState(() {
        isOnboardingDone =
            sp.getInt(AMOUNT) != null && sp.getString(NAME) != null
                ? true
                : false;
      });
    });
    Future.delayed(
      Duration(
        seconds: 4,
      ),
    ).then(
      (_) => Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) =>
              isOnboardingDone ? MainDashboard() : Onboarding(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, height: 800.0, width: 480.0);
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Theme.of(context).backgroundColor,
      child: Center(
        child: Hero(
          tag: "logo",
          child: SvgPicture.asset(
            'assets/images/sp_logo.svg',
          ),
        ),
      ),
    );
  }
}
