import 'package:flutter/cupertino.dart';
import 'package:spend_analytics/Utils/common.dart';
import 'package:spend_analytics/Views/UI/ui_color.dart';

class UiText {
  static final TextStyle headerText = new TextStyle(
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w900,
    fontSize: setFontSize(30.0),
    letterSpacing: setSize(1.1),
    height: setHeight(1.5),
    color: UiColor.dark,
  );

  static final TextStyle normalText = new TextStyle(
    fontFamily: 'Roboto',
    fontSize: setFontSize(20.0),
    height: setHeight(1.5),
  );

  static final TextStyle buttonText = new TextStyle(
    fontFamily: 'Roboto',
    fontSize: setFontSize(24.0),
    fontWeight: FontWeight.w700,
    height: setHeight(1.5),
  );
}
