import 'package:flutter/cupertino.dart';
import 'package:spend_analytics/Utils/common.dart';

class UiText {
  static final TextStyle headerText = new TextStyle(
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w900,
    fontSize: setFontSize(25.0),
    height: setHeight(1.5),
  );

  static final TextStyle normalText = new TextStyle(
    fontFamily: 'Roboto',
    fontSize: setFontSize(20.0),
    height: setHeight(1.5),
  );

  static final TextStyle buttonText = new TextStyle(
    fontFamily: 'Roboto',
    fontSize: setFontSize(20.0),
    fontWeight: FontWeight.w600,
    height: setHeight(1.5),
  );
}
