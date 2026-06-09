import 'package:spend_analytics/features/budget/domain/entities/budget_entity.dart';

class BudgetProgress {
  const BudgetProgress({required this.budget, required this.spent});

  final BudgetEntity budget;
  final double spent;

  double get percentage =>
      budget.limitAmount > 0
          ? (spent / budget.limitAmount).clamp(0.0, 1.0)
          : 0.0;
}
