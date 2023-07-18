import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spend_analytics/Core/Utils/sp_constants.dart';

class ThemeBloc {
  final mainThemeCtrl = StreamController<ThemeMode>.broadcast();

  init() {
    setDarkModePrefrence();
  }

  void setDarkModePrefrence() async {
    final sp = await SharedPreferences.getInstance();
    final bool isDarkMode = sp.getBool(THEME) ?? false;
    if (!mainThemeCtrl.isClosed) {
      log("isDarkMode: $isDarkMode");
      mainThemeCtrl.sink.add(isDarkMode ? ThemeMode.dark : ThemeMode.light);
    }
  }

  void dispose() {
    if (!mainThemeCtrl.isClosed) mainThemeCtrl.close();
  }
}
