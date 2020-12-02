import 'package:flutter/material.dart';
import 'package:spend_analytics/Screens/splash.dart';
import 'package:spend_analytics/UI/uicolors.dart';
import 'package:spend_analytics/UI/uitext.dart';
import 'package:spend_analytics/Utils/display_utils.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Spend Analytics',
      debugShowCheckedModeBanner: false,
      theme: lightTheme(),
      home: Splash(),
    );
  }

  ThemeData lightTheme() {
    return ThemeData(
      backgroundColor: UiColors.background,
      primaryColor: UiColors.primary,
      accentColor: UiColors.background,
      accentIconTheme: IconThemeData(
        color: UiColors.black,
      ),
      bannerTheme: MaterialBannerThemeData(
        backgroundColor: Colors.white,
        contentTextStyle: UiText.normalText,
      ),
      buttonColor: UiColors.primary,
      disabledColor: UiColors.darkGrey.withOpacity(0.5),
      cursorColor: UiColors.primary,
      dividerColor: UiColors.darkGrey,
      canvasColor: Colors.white,
      accentTextTheme: TextTheme(
        headline4: UiText.headerText,
        bodyText1: UiText.normalText,
        subtitle1: UiText.subtitleText,
        button: UiText.buttonText,
        caption: UiText.normalText.copyWith(
          color: UiColors.darkGrey.withOpacity(0.7),
        ),
      ),
      focusColor: UiColors.lightBlue,
      errorColor: UiColors.red,
      cardTheme: CardTheme(
        color: Colors.white,
        elevation: 8.0,
        shadowColor: UiColors.shadow,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
      fontFamily: 'Roboto',
      dialogTheme: DialogTheme(
        titleTextStyle: UiText.headerText,
        backgroundColor: Colors.white,
        elevation: 10.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
      dialogBackgroundColor: UiColors.shadow,
      chipTheme: ChipThemeData(
        elevation: 10.0,
        shadowColor: UiColors.shadow,
        selectedShadowColor: UiColors.lightBlue.withOpacity(0.25),
        backgroundColor: Colors.white,
        disabledColor: UiColors.darkGrey.withOpacity(0.5),
        selectedColor: UiColors.primary.withOpacity(0.5),
        secondarySelectedColor: UiColors.lightBlue.withOpacity(0.5),
        padding: const EdgeInsets.all(
          6.0,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        labelStyle: UiText.subtitleText,
        secondaryLabelStyle: UiText.normalText,
        brightness: Brightness.light,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        elevation: 10.0,
        backgroundColor: UiColors.primary,
        foregroundColor: UiColors.primary.withOpacity(0.7),
      ),
      buttonTheme: ButtonThemeData(
        buttonColor: UiColors.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        padding: const EdgeInsets.all(5.0),
      ),
      accentColorBrightness: Brightness.light,
      shadowColor: UiColors.shadow,
      appBarTheme: AppBarTheme(
        elevation: 8.0,
        shadowColor: UiColors.shadow,
        textTheme: TextTheme(
          headline1: UiText.headerText,
        ),
        color: UiColors.background,
        iconTheme: IconThemeData(
          color: UiColors.black,
        ),
      ),
      iconTheme: IconThemeData(
        color: UiColors.black,
      ),
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }
}
