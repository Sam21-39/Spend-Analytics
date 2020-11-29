import 'package:flutter/material.dart';
import 'package:spend_analytics/Screens/splash.dart';
import 'package:spend_analytics/UI/uicolors.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Spend Analytics',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: UiColors.primary,
        accentColor: UiColors.background,
        appBarTheme: AppBarTheme(
          elevation: 0.0,
          color: UiColors.background,
          iconTheme: IconThemeData(
            color: UiColors.black,
          ),
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Splash(),
    );
  }
}
