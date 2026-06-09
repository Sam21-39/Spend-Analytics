import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';
import 'package:spend_analytics/core/enums/expense_type.dart';
import 'package:spend_analytics/core/enums/rule_type.dart';
import 'package:spend_analytics/core/error/failures.dart';
import 'package:spend_analytics/features/budget/domain/repositories/i_budget_repository.dart';
import 'package:spend_analytics/features/expense/domain/entities/expense_entity.dart';
import 'package:spend_analytics/features/expense/domain/repositories/i_expense_repository.dart';
import 'package:spend_analytics/features/notifications/domain/entities/notification_event_entity.dart';
import 'package:spend_analytics/features/notifications/domain/repositories/i_notification_repository.dart';
import 'package:spend_analytics/features/rules/domain/repositories/i_rules_repository.dart';

@injectable
class EvaluateRulesUseCase {
  const EvaluateRulesUseCase(
    this._rulesRepo,
    this._expenseRepo,
    this._budgetRepo,
    this._notifRepo,
  );

  final IRulesRepository _rulesRepo;
  final IExpenseRepository _expenseRepo;
  final IBudgetRepository _budgetRepo;
  final INotificationRepository _notifRepo;

  static const _uuid = Uuid();

  /// Evaluates all active rules against [expense].
  /// Returns fired notification entities so the BLoC can display push alerts.
  /// Only runs for expense-type transactions.
  Future<Either<Failure, List<NotificationEventEntity>>> call(
    ExpenseEntity expense,
  ) async {
    if (expense.expenseType != ExpenseType.expense) {
      return const Right([]);
    }

    final rulesResult = await _rulesRepo.getActiveRules(expense.userId);
    if (rulesResult.isLeft()) return rulesResult.map((_) => []);

    final rules = rulesResult.getOrElse(() => []);
    final fired = <NotificationEventEntity>[];

    for (final rule in rules) {
      try {
        NotificationEventEntity? notif;
        switch (rule.ruleType) {
          case RuleType.budgetThreshold:
            notif = await _checkBudgetThreshold(expense, rule.parameters);
          case RuleType.dailyLimit:
            notif = await _checkDailyLimit(expense, rule.parameters);
          default:
            break;
        }
        if (notif != null) {
          await _notifRepo.addNotification(notif);
          fired.add(notif);
        }
      } catch (_) {
        // Single rule failure never aborts evaluation of remaining rules.
      }
    }

    return Right(fired);
  }

  Future<NotificationEventEntity?> _checkBudgetThreshold(
    ExpenseEntity expense,
    Map<String, dynamic> params,
  ) async {
    final threshold = (params['threshold_pct'] as num? ?? 0.8).toDouble();
    if (threshold <= 0 || threshold > 1) return null;

    final month = expense.transactionDate.month;
    final year = expense.transactionDate.year;

    final budgets = (await _budgetRepo.getBudgetsForMonth(
      userId: expense.userId,
      month: month,
      year: year,
    ))
        .getOrElse(() => [])
        .where((b) => b.category == expense.category)
        .toList();
    if (budgets.isEmpty) return null;

    final limit = budgets.first.limitAmount;
    if (limit <= 0) return null;

    final spendMap = (await _expenseRepo.getCategorySpendForMonth(
      userId: expense.userId,
      month: month,
      year: year,
    ))
        .getOrElse(() => {});
    final spent = spendMap[expense.category] ?? 0;
    final ratio = spent / limit;
    final prevRatio = (spent - expense.amount) / limit;

    if (ratio < threshold || prevRatio >= threshold) return null;

    final percent = (ratio * 100).toStringAsFixed(0);
    final remaining = (limit - spent).toStringAsFixed(0);
    return _buildNotif(
      userId: expense.userId,
      title: 'Budget alert: ${expense.category}',
      body: '${expense.category} is $percent% used — ₹$remaining left',
      route: '/budgets',
      payload: {'category': expense.category},
    );
  }

  Future<NotificationEventEntity?> _checkDailyLimit(
    ExpenseEntity expense,
    Map<String, dynamic> params,
  ) async {
    final limit = (params['limit_amount'] as num? ?? 1500).toDouble();
    if (limit <= 0) return null;

    final allExpenses = (await _expenseRepo.getExpensesForMonth(
      userId: expense.userId,
      month: expense.transactionDate.month,
      year: expense.transactionDate.year,
    ))
        .getOrElse(() => []);

    final dayTotal = allExpenses.fold<double>(
      0,
      (sum, e) =>
          _sameDay(e.transactionDate, expense.transactionDate) &&
                  e.expenseType == ExpenseType.expense
              ? sum + e.amount
              : sum,
    );
    final prev = dayTotal - expense.amount;
    if (dayTotal < limit || prev >= limit) return null;

    final percent = (dayTotal / limit * 100).toStringAsFixed(0);
    final remaining = (limit - dayTotal).toStringAsFixed(0);
    return _buildNotif(
      userId: expense.userId,
      title: 'Daily limit reached',
      body: '$percent% of ₹${limit.toStringAsFixed(0)} used — ₹$remaining left',
      route: '/dashboard',
      payload: const {},
    );
  }

  NotificationEventEntity _buildNotif({
    required String userId,
    required String title,
    required String body,
    required String route,
    required Map<String, dynamic> payload,
  }) =>
      NotificationEventEntity(
        id: _uuid.v4(),
        userId: userId,
        title: title,
        body: body,
        route: route,
        payload: payload,
        source: 'rule',
        createdAt: DateTime.now().toUtc(),
      );

  bool _sameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;
}
