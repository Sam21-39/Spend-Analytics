abstract final class RouteNames {
  // Auth & onboarding
  static const splash = '/';
  static const onboarding = '/onboarding';
  static const login = '/auth/login';

  // Shell tabs
  static const dashboard = '/dashboard';
  static const reports = '/reports';
  static const budgets = '/budgets';
  static const rules = '/rules';

  // Expenses
  static const expenseAdd = '/expenses/add';
  static const expenseList = '/expenses';
  static const expenseDetail = '/expenses/detail/:id';
  static const expenseEdit = '/expenses/edit/:id';

  // Budget
  static const budgetDetail = '/budgets/detail/:id';

  // Voice
  static const voice = '/voice';

  // Other features
  static const recurring = '/recurring';
  static const categories = '/categories';
  static const notifications = '/notifications';
  static const settings = '/settings';

  // Premium
  static const premiumPaywall = '/premium/paywall';
  static const premiumManage = '/premium/manage';

  // Legal
  static const privacyPolicy = '/legal/privacy';
  static const terms = '/legal/terms';

  // Helpers for parameterised paths
  static String expenseDetailPath(String id) => '/expenses/detail/$id';
  static String expenseEditPath(String id) => '/expenses/edit/$id';
  static String budgetDetailPath(String id) => '/budgets/detail/$id';
  static String paywallPath({String? feature}) =>
      feature != null ? '/premium/paywall?feature=$feature' : '/premium/paywall';
}
