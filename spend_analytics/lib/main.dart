import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:spend_analytics/Functions/Blocs/common/theme_bloc.dart';
import 'package:spend_analytics/Functions/Screens/splash.dart';
import 'package:spend_analytics/Core/UI/uicolors.dart';
import 'package:spend_analytics/Core/UI/uitext.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize without device test ids.
  MobileAds.instance.initialize();
  runApp(
    MyApp(
      key: appKey,
    ),
  );
}

GlobalKey<_MyAppState> appKey = GlobalKey<_MyAppState>();
// bool isDarkMode = true;

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final ThemeBloc themeBloc;
  // bool isDarkMode = true;
  @override
  void initState() {
    // setDarkModePrefrence();
    themeBloc = ThemeBloc();
    themeBloc.init();
    super.initState();
    // SharedPreferences.getInstance().then((sp) {
    //   setState(() {
    //     isDarkMode = sp.getBool(THEME) ?? true;
    //   });
    // });
  }

  @override
  void dispose() {
    themeBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(
    //   isDarkMode
    //       ? SystemUiOverlayStyle.dark.copyWith(
    //           statusBarBrightness: Brightness.light,
    //           statusBarIconBrightness: Brightness.light,
    //           // systemNavigationBarDividerColor: UiColors.darkGrey,
    //           systemNavigationBarColor: UiColors.black,
    //           systemNavigationBarIconBrightness: Brightness.light,
    //         )
    //       : SystemUiOverlayStyle.light.copyWith(
    //           statusBarBrightness: Brightness.dark,
    //           statusBarIconBrightness: Brightness.dark,
    //           // systemNavigationBarDividerColor: UiColors.darkGrey,
    //           systemNavigationBarColor: UiColors.background,
    //           systemNavigationBarIconBrightness: Brightness.dark,
    //         ),
    // );
    return ScreenUtilInit(
      designSize: Size(480.0, 800.0),
      minTextAdapt: true,
      builder: (context, child) => StreamBuilder<ThemeMode>(
          stream: themeBloc.mainThemeCtrl.stream,
          initialData: ThemeMode.dark,
          builder: (context, themeMode) {
            // if (themeMode.hasData) {
            log("Main Theme: " + themeMode.data.toString());
            SystemChrome.setSystemUIOverlayStyle(
              themeMode.data == ThemeMode.dark
                  ? SystemUiOverlayStyle.dark.copyWith(
                      statusBarBrightness: Brightness.light,
                      statusBarIconBrightness: Brightness.light,
                      // systemNavigationBarDividerColor: UiColors.darkGrey,
                      systemNavigationBarColor: UiColors.black,
                      systemNavigationBarIconBrightness: Brightness.light,
                    )
                  : SystemUiOverlayStyle.light.copyWith(
                      statusBarBrightness: Brightness.dark,
                      statusBarIconBrightness: Brightness.dark,
                      // systemNavigationBarDividerColor: UiColors.darkGrey,
                      systemNavigationBarColor: UiColors.background,
                      systemNavigationBarIconBrightness: Brightness.dark,
                    ),
            );
            return MaterialApp(
              title: 'Spend Analytics',
              debugShowCheckedModeBanner: false,
              theme: lightTheme(),
              darkTheme: darkTheme(),
              themeMode: themeMode.data,
              home: Splash(),
            );
            // }
            // return Container();
            // return MaterialApp(
            //   title: 'Spend Analytics',
            //   debugShowCheckedModeBanner: false,
            //   theme: lightTheme(),
            //   darkTheme: darkTheme(),
            //   themeMode: ThemeMode.system,
            //   home: Splash(),
            // );
          }),
    );
  }

  ThemeData darkTheme() {
    return ThemeData(
      primaryColor: UiColors.primary,
      bannerTheme: MaterialBannerThemeData(
        backgroundColor: UiColors.black,
        contentTextStyle: UiText.normalText.copyWith(
          color: Colors.white,
        ),
      ),
      disabledColor: Colors.white.withOpacity(0.5),
      dividerColor: Colors.white.withOpacity(0.7),
      canvasColor: UiColors.black,
      textTheme: TextTheme(
        headlineMedium: UiText.headerText.copyWith(color: Colors.white),
        bodyLarge: UiText.normalText.copyWith(color: Colors.white),
        titleMedium: UiText.subtitleText.copyWith(color: Colors.white),
        labelLarge: UiText.buttonText.copyWith(color: Colors.white),
        bodySmall: UiText.normalText.copyWith(
          color: Colors.white.withOpacity(0.7),
        ),
      ),
      focusColor: UiColors.lightBlue,
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
      appBarTheme: AppBarTheme(
        elevation: 10.0,
        color: UiColors.black,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        toolbarTextStyle: TextTheme(
          displayLarge: UiText.headerText.copyWith(color: Colors.white),
        ).bodyMedium,
        titleTextStyle: TextTheme(
          displayLarge: UiText.headerText.copyWith(color: Colors.white),
        ).titleLarge,
      ),
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
      popupMenuTheme: PopupMenuThemeData(
        textStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Colors.white,
            ),
        color: UiColors.lightRed,
        elevation: 10.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      colorScheme: ColorScheme.fromSwatch()
          .copyWith(secondary: UiColors.black, background: UiColors.black),
    );
  }

  ThemeData lightTheme() {
    return ThemeData(
      primaryColor: UiColors.primary,
      bannerTheme: MaterialBannerThemeData(
        backgroundColor: UiColors.background,
        contentTextStyle: UiText.normalText,
      ),
      disabledColor: UiColors.darkGrey.withOpacity(0.5),
      dividerColor: UiColors.darkGrey,
      canvasColor: UiColors.background,
      textTheme: TextTheme(
        headlineMedium: UiText.headerText.copyWith(color: UiColors.black),
        bodyLarge: UiText.normalText.copyWith(color: UiColors.black),
        titleMedium: UiText.subtitleText.copyWith(color: UiColors.black),
        labelLarge: UiText.buttonText.copyWith(color: UiColors.black),
        bodySmall: UiText.normalText.copyWith(
          color: UiColors.darkGrey.withOpacity(0.8),
        ),
      ),
      focusColor: UiColors.lightBlue,
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
      shadowColor: UiColors.shadow,
      appBarTheme: AppBarTheme(
        elevation: 10.0,
        color: UiColors.background,
        iconTheme: IconThemeData(
          color: UiColors.black,
        ),
        toolbarTextStyle: TextTheme(
          displayLarge: UiText.headerText,
        ).bodyMedium,
        titleTextStyle: TextTheme(
          displayLarge: UiText.headerText,
        ).titleLarge,
      ),
      iconTheme: IconThemeData(
        color: UiColors.black,
      ),
      popupMenuTheme: PopupMenuThemeData(
        textStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Colors.white,
            ),
        color: UiColors.lightRed,
        elevation: 10.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      colorScheme: ColorScheme.fromSwatch().copyWith(
        secondary: UiColors.background,
        background: UiColors.background,
      ),
    );
  }
}
