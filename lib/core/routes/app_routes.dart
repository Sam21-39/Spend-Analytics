import 'package:get/get.dart';
import 'package:spend_analytics/features/analytics/analytics_controller.dart';
import 'package:spend_analytics/features/analytics/analytics_screen.dart';
import 'package:spend_analytics/features/auth/login_screen.dart';
import 'package:spend_analytics/features/auth/onboarding_screen.dart';
import 'package:spend_analytics/features/auth/privacy_gate_screen.dart';
import 'package:spend_analytics/features/auth/splash_screen.dart';
import 'package:spend_analytics/features/budgets/budget_controller.dart';
import 'package:spend_analytics/features/budgets/budget_detail_screen.dart';
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
import 'package:spend_analytics/features/rules/add_rule_screen.dart';
import 'package:spend_analytics/features/rules/rules_controller.dart';
import 'package:spend_analytics/features/rules/rules_screen.dart';
import 'package:spend_analytics/features/settings/logout_confirm_screen.dart';
import 'package:spend_analytics/features/settings/settings_controller.dart';
import 'package:spend_analytics/features/settings/settings_screen.dart';
import 'package:spend_analytics/features/subscription/subscription_plans_screen.dart';
import 'package:spend_analytics/features/transactions/add_transaction_screen.dart';
import 'package:spend_analytics/features/transactions/transaction_controller.dart';
import 'package:spend_analytics/features/transactions/transaction_detail_screen.dart';
import 'package:spend_analytics/features/transactions/transaction_list_screen.dart';
import 'package:spend_analytics/features/voice/voice_auto_review_screen.dart';
import 'package:spend_analytics/features/voice/voice_controller.dart';
import 'package:spend_analytics/features/voice/voice_input_screen.dart';

class AppRoutes {
  // ── Auth flow ──────────────────────────────────────────────────
  static const splash = '/';
  static const onboarding = '/onboarding';
  static const login = '/login';
  static const privacyGate = '/privacy-gate';

  // ── Main tabs ──────────────────────────────────────────────────
  static const dashboard = '/dashboard';
  static const analytics = '/analytics';
  static const budgets = '/budgets';
  static const rules = '/rules';

  // ── Transactions ───────────────────────────────────────────────
  static const addTxn = '/transaction/add';
  static const txns = '/transactions';
  static const txnDetail = '/transaction/detail';

  // ── Budgets ────────────────────────────────────────────────────
  static const budgetDetail = '/budget/detail';

  // ── Voice ──────────────────────────────────────────────────────
  static const voiceInput = '/voice/input';
  static const voiceReview = '/voice/review';

  // ── Other features ─────────────────────────────────────────────
  static const recurring = '/recurring';
  static const categories = '/categories';
  static const notifications = '/notifications';

  // ── Rules ──────────────────────────────────────────────────────
  static const addRule = '/rules/add';

  // ── Settings ───────────────────────────────────────────────────
  static const settings = '/settings';
  static const logout = '/logout';

  // ── Subscription & legal ───────────────────────────────────────
  static const subscription = '/subscription';
  static const privacyPolicy = '/legal/privacy';
  static const terms = '/legal/terms';

  static final pages = <GetPage<dynamic>>[
    // Auth flow
    GetPage(name: splash, page: () => const SplashScreen()),
    GetPage(name: onboarding, page: () => const OnboardingScreen()),
    GetPage(name: login, page: () => const LoginScreen()),
    GetPage(name: privacyGate, page: () => const PrivacyGateScreen()),

    // Main tabs
    GetPage(
      name: dashboard,
      page: () => const DashboardScreen(),
      binding: BindingsBuilder(
        () => Get.lazyPut<DashboardController>(() => DashboardController()),
      ),
    ),
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
      name: rules,
      page: () => const RulesScreen(),
      binding: BindingsBuilder(
        () => Get.lazyPut<RulesController>(() => RulesController()),
      ),
    ),

    // Transactions
    GetPage(
      name: addTxn,
      page: () => const AddTransactionScreen(),
      binding: BindingsBuilder(
        () => Get.lazyPut<TransactionController>(() => TransactionController()),
      ),
    ),
    GetPage(
      name: txns,
      page: () => const TransactionListScreen(),
      binding: BindingsBuilder(
        () => Get.lazyPut<TransactionController>(() => TransactionController()),
      ),
    ),
    GetPage(
      name: txnDetail,
      page: () => const TransactionDetailScreen(),
      binding: BindingsBuilder(
        () => Get.lazyPut<TransactionController>(() => TransactionController()),
      ),
    ),

    // Budgets
    GetPage(name: budgetDetail, page: () => const BudgetDetailScreen()),

    // Voice
    GetPage(
      name: voiceInput,
      page: () => const VoiceInputScreen(),
      binding: BindingsBuilder(
        () => Get.lazyPut<VoiceController>(() => VoiceController()),
      ),
    ),
    GetPage(
      name: voiceReview,
      page: () => const VoiceAutoReviewScreen(),
      binding: BindingsBuilder(
        () => Get.lazyPut<VoiceController>(() => VoiceController()),
      ),
    ),

    // Other features
    GetPage(
      name: recurring,
      page: () => const RecurringScreen(),
      binding: BindingsBuilder(
        () => Get.lazyPut<RecurringController>(() => RecurringController()),
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
      name: notifications,
      page: () => const NotificationCenterScreen(),
      binding: BindingsBuilder(
        () => Get.lazyPut<NotificationCenterController>(
          () => NotificationCenterController(),
        ),
      ),
    ),

    // Rules
    GetPage(name: addRule, page: () => const AddRuleScreen()),

    // Settings
    GetPage(
      name: settings,
      page: () => const SettingsScreen(),
      binding: BindingsBuilder(
        () => Get.lazyPut<SettingsController>(() => SettingsController()),
      ),
    ),
    GetPage(name: logout, page: () => const LogoutConfirmScreen()),

    // Subscription & legal
    GetPage(name: subscription, page: () => const SubscriptionPlansScreen()),
    GetPage(name: privacyPolicy, page: () => const PrivacyPolicyScreen()),
    GetPage(name: terms, page: () => const TermsOfServiceScreen()),
  ];
}
