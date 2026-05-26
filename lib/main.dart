import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spend_analytics/core/config/app_config.dart';
import 'package:spend_analytics/core/di/dependency_injection.dart';
import 'package:spend_analytics/core/routes/app_routes.dart';
import 'package:spend_analytics/core/theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppConfig.init();
  await DependencyInjection.init();
  runApp(const SpendAnalyticsApp());
}

class SpendAnalyticsApp extends StatelessWidget {
  const SpendAnalyticsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: AppConfig.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
      initialRoute: AppRoutes.login,
      getPages: AppRoutes.pages,
      defaultTransition: Transition.fadeIn,
      enableLog: kDebugMode,
      builder: (context, child) => child ?? const SizedBox.shrink(),
    );
  }
}
