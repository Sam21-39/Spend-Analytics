import 'package:flutter/material.dart';
import 'package:spend_analytics/Views/Screens/splash.dart';
import 'package:spend_analytics/Views/UI/ui_color.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Spend Analytics',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        accentColor: UiColor.light,
        appBarTheme: AppBarTheme(
          elevation: 0.0,
          color: UiColor.light,
          iconTheme: IconThemeData(color: UiColor.dark),
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: UiColor.light,
          foregroundColor: UiColor.light,
          elevation: 12.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100.0),
            side: BorderSide(color: Colors.white30),
          ),
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Splash(),
    );
  }
}
