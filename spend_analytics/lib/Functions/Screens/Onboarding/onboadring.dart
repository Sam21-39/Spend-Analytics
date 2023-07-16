import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spend_analytics/Functions/Screens/Onboarding/name.dart';
import 'package:spend_analytics/Core/Utils/display_utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spend_analytics/Core/Widgets/button.dart';

class Onboarding extends StatefulWidget {
  @override
  _OnboardingState createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Material(
      type: MaterialType.canvas,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
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
                      child: Hero(
                        tag: "logo",
                        child: SvgPicture.asset(
                          'assets/images/sp_logo.svg',
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Text(
                      'Hi There!',
                      style: textTheme.headlineMedium?.copyWith(
                        fontSize: setScreenUtill(36.0),
                      ),
                    ),
                    SizedBox(
                      height: 50.h,
                    ),
                    Text(
                      'Welcome To',
                      style: textTheme.titleMedium?.copyWith(
                        fontSize: setScreenUtill(24.0),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      'Spend Analytics',
                      style: textTheme.headlineMedium?.copyWith(
                        fontSize: setScreenUtill(30.0),
                        fontWeight: FontWeight.w600,
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
        ),
      ),
    );
  }
}
