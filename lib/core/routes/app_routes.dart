import 'package:get/get.dart';
import 'package:spend_analytics/features/analytics/analytics_controller.dart';
import 'package:spend_analytics/features/analytics/analytics_screen.dart';
import 'package:spend_analytics/features/auth/auth_controller.dart';
import 'package:spend_analytics/features/auth/login_screen.dart';
import 'package:spend_analytics/features/budgets/budget_controller.dart';
import 'package:spend_analytics/features/budgets/budget_screen.dart';
import 'package:spend_analytics/features/categories/category_controller.dart';
import 'package:spend_analytics/features/categories/category_screen.dart';
import 'package:spend_analytics/features/dashboard/dashboard_controller.dart';
import 'package:spend_analytics/features/dashboard/dashboard_screen.dart';
import 'package:spend_analytics/features/legal/privacy_policy_screen.dart';
import 'package:spend_analytics/features/legal/terms_of_service_screen.dart';
import 'package:spend_analytics/features/notifications/notification_center_controller.dart';
import 'package:spend_analytics/features/notifications/notification_center_screen.dart';
import 'package:spend_analytics/features/recurring/recurring_controller.dart';
import 'package:spend_analytics/features/recurring/recurring_screen.dart';
import 'package:spend_analytics/features/rules/rules_controller.dart';
import 'package:spend_analytics/features/rules/rules_screen.dart';
import 'package:spend_analytics/features/settings/settings_controller.dart';
import 'package:spend_analytics/features/settings/settings_screen.dart';
import 'package:spend_analytics/features/subscription/subscription_plans_screen.dart';
import 'package:spend_analytics/features/transactions/add_transaction_screen.dart';
import 'package:spend_analytics/features/transactions/transaction_controller.dart';
import 'package:spend_analytics/features/transactions/transaction_list_screen.dart';
import 'package:spend_analytics/features/voice/voice_controller.dart';
import 'package:spend_analytics/features/voice/voice_auto_review_screen.dart';

class AppRoutes {
  static const login = '/login';
  static const dashboard = '/dashboard';
  static const addTxn = '/transaction/add';
  static const txns = '/transactions';
  static const analytics = '/analytics';
  static const budgets = '/budgets';
  static const recurring = '/recurring';
  static const rules = '/rules';
  static const categories = '/categories';
  static const settings = '/settings';
  static const notifications = '/notifications';
  static const subscription = '/subscription';
  static const privacyPolicy = '/legal/privacy';
  static const terms = '/legal/terms';
  static const voiceReview = '/voice/review';

  static final pages = <GetPage<dynamic>>[
    GetPage(
      name: login,
      page: () => const LoginScreen(),
      binding: BindingsBuilder(
        () => Get.lazyPut<AuthController>(() => AuthController()),
      ),
    ),
    GetPage(
      name: dashboard,
      page: () => const DashboardScreen(),
      binding: BindingsBuilder(
        () => Get.lazyPut<DashboardController>(() => DashboardController()),
      ),
    ),
    GetPage(
      name: addTxn,
      page: () => const AddTransactionScreen(),
      binding: BindingsBuilder(
        () => Get.lazyPut<TransactionController>(() => TransactionController()),
      ),
    ),
    GetPage(name: txns, page: () => const TransactionListScreen()),
    GetPage(
      name: analytics,
      page: () => const AnalyticsScreen(),
      binding: BindingsBuilder(
        () => Get.lazyPut<AnalyticsController>(() => AnalyticsController()),
      ),
    ),
    GetPage(
      name: budgets,
      page: () => const BudgetScreen(),
      binding: BindingsBuilder(
        () => Get.lazyPut<BudgetController>(() => BudgetController()),
      ),
    ),
    GetPage(
      name: recurring,
      page: () => const RecurringScreen(),
      binding: BindingsBuilder(
        () => Get.lazyPut<RecurringController>(() => RecurringController()),
      ),
    ),
    GetPage(
      name: rules,
      page: () => const RulesScreen(),
      binding: BindingsBuilder(
        () => Get.lazyPut<RulesController>(() => RulesController()),
      ),
    ),
    GetPage(
      name: categories,
      page: () => const CategoryScreen(),
      binding: BindingsBuilder(
        () => Get.lazyPut<CategoryController>(() => CategoryController()),
      ),
    ),
    GetPage(
      name: settings,
      page: () => const SettingsScreen(),
      binding: BindingsBuilder(
        () => Get.lazyPut<SettingsController>(() => SettingsController()),
      ),
    ),
    GetPage(
      name: notifications,
      page: () => const NotificationCenterScreen(),
      binding: BindingsBuilder(
        () => Get.lazyPut<NotificationCenterController>(
          () => NotificationCenterController(),
        ),
      ),
    ),
    GetPage(name: subscription, page: () => const SubscriptionPlansScreen()),
    GetPage(name: privacyPolicy, page: () => const PrivacyPolicyScreen()),
    GetPage(name: terms, page: () => const TermsOfServiceScreen()),
    GetPage(
      name: voiceReview,
      page: () => const VoiceAutoReviewScreen(),
      binding: BindingsBuilder(
        () => Get.lazyPut<VoiceController>(() => VoiceController()),
      ),
    ),
  ];
}
