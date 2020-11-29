import 'package:flutter/cupertino.dart';
import 'package:spend_analytics/UI/uicolors.dart';
import 'package:spend_analytics/Utils/display_utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UiText {
  static final TextStyle headerText = TextStyle(
    color: UiColors.black,
    fontSize: setScreenUtill(36.0),
    fontWeight: FontWeight.w600,
  );

  static final subtitleText = TextStyle(
    color: UiColors.black,
    fontSize: setScreenUtill(24.0),
    height: 1.5.h,
  );

  static final buttonText = TextStyle(
    color: UiColors.black,
    fontSize: setScreenUtill(18.0),
  );

  static final normalText = TextStyle(
    color: UiColors.black,
    fontSize: setScreenUtill(16.0),
  );
}
