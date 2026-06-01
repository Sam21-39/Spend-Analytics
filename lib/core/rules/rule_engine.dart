import 'package:get/get.dart';
import 'package:spend_analytics/core/services/local_notification_service.dart';
import 'package:spend_analytics/core/local_db/app_database.dart';
import 'package:spend_analytics/core/routes/app_routes.dart';
import 'package:spend_analytics/shared/models/transaction_model.dart';
import 'package:spend_analytics/shared/utils/currency_formatter.dart';

class RuleEngine extends GetxService {
  final AppDatabase _db = Get.find<AppDatabase>();
  final LocalNotificationService _fcm = Get.find<LocalNotificationService>();

  Future<RuleEngine> init() async {
    return this;
  }

  Future<void> evaluate(TransactionModel txn) async {
    if (txn.type != 'expense') {
      return;
    }

    final rules = await _db.getActiveRules(txn.userId);
    for (final rule in rules) {
      final params = _db.parseRuleParameters(rule);
      switch (rule.ruleType) {
        case 'budget_threshold':
          await _checkBudgetThreshold(txn, params);
          break;
        case 'daily_limit':
          await _checkDailyLimit(txn, params);
          break;
        default:
          break;
      }
    }
  }

  Future<void> _checkBudgetThreshold(TransactionModel txn, Map<String, dynamic> params) async {
    final threshold = (params['threshold_pct'] as num? ?? 0.8).toDouble();
    if (threshold <= 0 || threshold > 1) {
      return;
    }

    final month = txn.transactionDate.month;
    final year = txn.transactionDate.year;
    final budgets =
        await _db.watchBudgetsForMonth(userId: txn.userId, month: month, year: year).first;

    final matched = budgets.where((b) => b.category == txn.category).toList();
    if (matched.isEmpty) {
      return;
    }

    final budget = matched.first.limitAmount;
    if (budget <= 0) {
      return;
    }

    final spent = await _db.getCategorySpendForMonth(
      userId: txn.userId,
      category: txn.category,
      month: month,
      year: year,
    );
    final ratio = spent / budget;
    final previousRatio = (spent - txn.amount) / budget;
    if (ratio < threshold || previousRatio >= threshold) {
      return;
    }

    final percent = (ratio * 100).toStringAsFixed(0);
    final remaining = (budget - spent).toStringAsFixed(0);
    final title = 'Budget alert: ${txn.category}';
    final body = '${txn.category} is $percent% used - ${getCurrencySymbol()}$remaining left';

    await _db.addNotificationEvent(
      userId: txn.userId,
      title: title,
      body: body,
      route: AppRoutes.budgets,
      payload: <String, dynamic>{'category': txn.category},
      source: 'rule',
    );
    try {
      await _fcm.showLocalNotification(
        title: title,
        body: body,
        route: AppRoutes.budgets,
        payload: <String, dynamic>{'category': txn.category},
      );
    } catch (e) {
      // Ignore notification errors
    }
  }

  Future<void> _checkDailyLimit(TransactionModel txn, Map<String, dynamic> params) async {
    final limit = (params['limit_amount'] as num? ?? 1500).toDouble();
    if (limit <= 0) {
      return;
    }

    final total = await _db.getDailyExpenseTotal(userId: txn.userId, date: txn.transactionDate);
    final previous = total - txn.amount;
    if (total < limit || previous >= limit) {
      return;
    }

    final percent = (total / limit * 100).toStringAsFixed(0);
    final remaining = (limit - total).toStringAsFixed(0);
    final title = 'Daily limit reached';
    final body =
        '$percent% of ${getCurrencySymbol()}$limit used - ${getCurrencySymbol()}$remaining left';

    await _db.addNotificationEvent(
      userId: txn.userId,
      title: title,
      body: body,
      route: AppRoutes.dashboard,
      payload: <String, dynamic>{},
      source: 'rule',
    );
    try {
      await _fcm.showLocalNotification(
        title: title,
        body: body,
        route: AppRoutes.dashboard,
        payload: <String, dynamic>{},
      );
    } catch (e) {
      // Ignore notification errors
    }
  }
}
