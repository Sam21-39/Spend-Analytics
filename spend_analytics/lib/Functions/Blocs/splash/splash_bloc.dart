import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Core/Utils/sp_constants.dart';
import '../../Screens/MainDashboard/main_dashboard.dart';
import '../../Screens/Onboarding/onboadring.dart';

class SpalshBloc {
  final onboardingCtrl = StreamController<bool>.broadcast();

  static bool isOnboardingDone = false;

  init(BuildContext context) {
    setOnboarding();
    Future.delayed(
      Duration(
        seconds: 2,
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

  void setOnboarding() async {
    final sp = await SharedPreferences.getInstance();
    isOnboardingDone =
        sp.getDouble(AMOUNT) != null && sp.getString(NAME) != null
            ? true
            : false;
    if (!onboardingCtrl.isClosed) {
      onboardingCtrl.sink.add(isOnboardingDone);
    }
  }
}
