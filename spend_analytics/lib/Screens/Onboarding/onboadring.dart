import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spend_analytics/Screens/Onboarding/name.dart';
import 'package:spend_analytics/UI/uitext.dart';
import 'package:spend_analytics/Utils/display_utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spend_analytics/Widgets/button.dart';

class Onboarding extends StatefulWidget {
  @override
  _OnboardingState createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Color(0xfff2f2f2),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.all(
          setScreenUtill(20.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Container(
                  width: 150.w,
                  height: 150.h,
                  padding: EdgeInsets.all(
                    setScreenUtill(2.0),
                  ),
                  child: SvgPicture.asset('assets/images/sp_logo_tp.svg'),
                ),
                SizedBox(
                  height: 30.h,
                ),
                Text(
                  'Hi There!',
                  style: UiText.headerText,
                ),
                SizedBox(
                  height: 50.h,
                ),
                Text(
                  'Welcome To',
                  style: UiText.subtitleText,
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  'Spend Analytics',
                  style: UiText.headerText.copyWith(
                    fontSize: setScreenUtill(26.0),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Button(
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => Name(),
                    ),
                  ),
                  text: 'Let\'s Get Started',
                ),
                SizedBox(
                  height: 40.h,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
