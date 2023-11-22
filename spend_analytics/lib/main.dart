import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spend_analytics/Core/UI/uicolors.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';
// import 'package:spend_analytics/Core/UI/uicolors.dart';

import 'View/Screens/Splash/splash.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  // Initialize without device test ids.
  // MobileAds.instance.initialize();
  runApp(
    MyApp(),
  );
  FlutterNativeSplash.remove();
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // @override
  // void initState() {
  //   super.initState();
  //   SharedPreferences.getInstance().then((sp) {
  //     setState(() {
  //       isDarkMode = sp.getBool(THEME) == null ? true : sp.getBool(THEME);
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(
    //   isDarkMode
    //       ? SystemUiOverlayStyle.dark.copyWith(
    //           statusBarBrightness: Brightness.light,
    //           statusBarIconBrightness: Brightness.light,
    //           systemNavigationBarDividerColor: UiColors.darkGrey,
    //           systemNavigationBarColor: UiColors.black,
    //           systemNavigationBarIconBrightness: Brightness.light,
    //         )
    //       : SystemUiOverlayStyle.light.copyWith(
    //           statusBarBrightness: Brightness.dark,
    //           statusBarIconBrightness: Brightness.dark,
    //           systemNavigationBarDividerColor: UiColors.darkGrey,
    //           systemNavigationBarColor: UiColors.background,
    //           systemNavigationBarIconBrightness: Brightness.dark,
    //         ),
    // );
    return ScreenUtilInit(
      designSize: const Size(480.0, 960.0),
      builder: (c, _) => MaterialApp(
        title: 'Spend Analytics',
        debugShowCheckedModeBanner: false,
        theme: lightTheme(),
        darkTheme: darkTheme(),
        themeMode: ThemeMode.light,
        home: Splash(),
        builder: EasyLoading.init(
          builder: (Context, child) => MediaQuery(
              data: MediaQueryData(
                textScaler: TextScaler.noScaling,
              ),
              child: child!),
        ),
      ),
    );
  }

  ThemeData darkTheme() {
    return ThemeData(
      fontFamily: 'Roboto',
      appBarTheme: AppBarTheme(
        backgroundColor: UiColors.backgroundDark,
      ),
      colorScheme: ColorScheme.fromSeed(
        seedColor: UiColors.primary,
        background: UiColors.backgroundDark,
        error: UiColors.red,
      ),
      textTheme: TextTheme(
        bodyMedium: TextStyle(
          color: UiColors.backgroundLight,
          fontFamily: 'Roboto',
        ),
      ),
    );
  }

  ThemeData lightTheme() {
    return ThemeData(
      fontFamily: 'Roboto',
      appBarTheme: AppBarTheme(
        backgroundColor: UiColors.backgroundLight,
      ),
      colorScheme: ColorScheme.fromSeed(
        seedColor: UiColors.primary,
        background: UiColors.backgroundLight,
        error: UiColors.red,
      ),
      textTheme: TextTheme(
        bodyMedium: TextStyle(
          color: UiColors.black,
          fontFamily: 'Roboto',
        ),
      ),
    );
  }
}
