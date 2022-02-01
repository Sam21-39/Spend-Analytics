import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spend_analytics/Screens/splash.dart';
import 'package:spend_analytics/UI/uicolors.dart';
import 'package:spend_analytics/UI/uitext.dart';
import 'package:spend_analytics/Utils/sp_constants.dart';

void main() {
  runApp(
    MyApp(
      key: appKey,
    ),
  );
}

GlobalKey appKey = GlobalKey();
bool isDarkMode = true;

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((sp) {
      setState(() {
        isDarkMode = sp.getBool(THEME) == null ? true : sp.getBool(THEME);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      isDarkMode
          ? SystemUiOverlayStyle.dark.copyWith(
              statusBarBrightness: Brightness.light,
              statusBarIconBrightness: Brightness.light,
              systemNavigationBarDividerColor: UiColors.darkGrey,
              systemNavigationBarColor: UiColors.black,
              systemNavigationBarIconBrightness: Brightness.light,
            )
          : SystemUiOverlayStyle.light.copyWith(
              statusBarBrightness: Brightness.dark,
              statusBarIconBrightness: Brightness.dark,
              systemNavigationBarDividerColor: UiColors.darkGrey,
              systemNavigationBarColor: UiColors.background,
              systemNavigationBarIconBrightness: Brightness.dark,
            ),
    );
    return ScreenUtilInit(
      designSize: Size(480.0, 800.0),
      allowFontScaling: true,
      builder: () => MaterialApp(
        title: 'Spend Analytics',
        debugShowCheckedModeBanner: false,
        theme: lightTheme(),
        darkTheme: darkTheme(),
        themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
        home: Splash(),
      ),
    );
  }

  ThemeData darkTheme() {
    return ThemeData(
      backgroundColor: UiColors.black,
      primaryColor: UiColors.primary,
      accentColor: UiColors.black,
      accentIconTheme: IconThemeData(
        color: Colors.white,
      ),
      bannerTheme: MaterialBannerThemeData(
        backgroundColor: UiColors.black,
        contentTextStyle: UiText.normalText.copyWith(
          color: Colors.white,
        ),
      ),
      buttonColor: UiColors.primary,
      disabledColor: Colors.white.withOpacity(0.5),
      cursorColor: UiColors.primary,
      dividerColor: Colors.white.withOpacity(0.7),
      canvasColor: UiColors.black,
      textTheme: TextTheme(
        headline4: UiText.headerText.copyWith(color: Colors.white),
        bodyText1: UiText.normalText.copyWith(color: Colors.white),
        subtitle1: UiText.subtitleText.copyWith(color: Colors.white),
        button: UiText.buttonText.copyWith(color: Colors.white),
        caption: UiText.normalText.copyWith(
          color: Colors.white.withOpacity(0.7),
        ),
      ),
      focusColor: UiColors.lightBlue,
      errorColor: UiColors.red,
      cardTheme: CardTheme(
        color: UiColors.lightRed,
        shadowColor: UiColors.lightRed.withOpacity(0.75),
        elevation: 8.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12.0),
            topRight: Radius.circular(62.0),
            bottomLeft: Radius.circular(12.0),
            bottomRight: Radius.circular(12.0),
          ),
        ),
      ),
      fontFamily: 'Roboto',
      dialogTheme: DialogTheme(
        titleTextStyle: UiText.headerText.copyWith(
          color: Colors.white,
        ),
        backgroundColor: UiColors.black,
        elevation: 10.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
      dialogBackgroundColor: UiColors.shadow,
      chipTheme: ChipThemeData(
        elevation: 10.0,
        shadowColor: UiColors.lightRed.withOpacity(0.75),
        selectedShadowColor: UiColors.lightBlue.withOpacity(0.25),
        backgroundColor: UiColors.lightRed,
        disabledColor: UiColors.darkGrey.withOpacity(0.5),
        selectedColor: UiColors.primary.withOpacity(0.5),
        secondarySelectedColor: UiColors.lightBlue.withOpacity(0.5),
        padding: const EdgeInsets.all(
          6.0,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        labelStyle: UiText.subtitleText.copyWith(color: Colors.white),
        secondaryLabelStyle: UiText.normalText.copyWith(color: Colors.white),
        brightness: Brightness.dark,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        elevation: 10.0,
        backgroundColor: UiColors.primary,
        foregroundColor: UiColors.primary.withOpacity(0.7),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22.0),
        ),
      ),
      buttonTheme: ButtonThemeData(
        buttonColor: UiColors.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        padding: const EdgeInsets.all(5.0),
      ),
      accentColorBrightness: Brightness.dark,
      appBarTheme: AppBarTheme(
        elevation: 10.0,
        textTheme: TextTheme(
          headline1: UiText.headerText.copyWith(color: Colors.white),
        ),
        color: UiColors.black,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
      popupMenuTheme: PopupMenuThemeData(
        textStyle: Theme.of(context).textTheme.caption.copyWith(
              color: Colors.white,
            ),
        color: UiColors.lightRed,
        elevation: 10.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
      visualDensity: VisualDensity.adaptivePlatformDensity,
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
        backgroundColor: UiColors.background,
        contentTextStyle: UiText.normalText,
      ),
      buttonColor: UiColors.primary,
      disabledColor: UiColors.darkGrey.withOpacity(0.5),
      cursorColor: UiColors.primary,
      dividerColor: UiColors.darkGrey,
      canvasColor: UiColors.background,
      textTheme: TextTheme(
        headline4: UiText.headerText.copyWith(color: UiColors.black),
        bodyText1: UiText.normalText.copyWith(color: UiColors.black),
        subtitle1: UiText.subtitleText.copyWith(color: UiColors.black),
        button: UiText.buttonText.copyWith(color: UiColors.black),
        caption: UiText.normalText.copyWith(
          color: UiColors.darkGrey.withOpacity(0.8),
        ),
      ),
      focusColor: UiColors.lightBlue,
      errorColor: UiColors.red,
      cardTheme: CardTheme(
        color: UiColors.lightRed,
        elevation: 8.0,
        shadowColor: UiColors.lightRed.withOpacity(0.75),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12.0),
            topRight: Radius.circular(62.0),
            bottomLeft: Radius.circular(12.0),
            bottomRight: Radius.circular(12.0),
          ),
        ),
      ),
      fontFamily: 'Roboto',
      dialogTheme: DialogTheme(
        titleTextStyle: UiText.headerText,
        backgroundColor: UiColors.background.withOpacity(0.8),
        elevation: 10.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
      dialogBackgroundColor: UiColors.shadow,
      chipTheme: ChipThemeData(
        elevation: 10.0,
        shadowColor: UiColors.lightRed.withOpacity(0.75),
        selectedShadowColor: UiColors.lightBlue.withOpacity(0.25),
        backgroundColor: UiColors.lightRed,
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
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22.0),
        ),
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
        elevation: 10.0,
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
      popupMenuTheme: PopupMenuThemeData(
        textStyle: Theme.of(context).textTheme.bodyText1.copyWith(
              color: Colors.white,
            ),
        color: UiColors.lightRed,
        elevation: 10.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }
}
