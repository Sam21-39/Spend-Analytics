import 'package:hive_ce/hive.dart';
import 'package:injectable/injectable.dart';

import '../../constants/hive_box_names.dart';
import '../../storage/hive_service.dart';

// Typed box accessors are exposed here so injectable can inject them by type
// into data sources. As model classes are generated in Phase 1, these return
// types are narrowed from Box<dynamic> to Box<ConcreteModel>.
//
// Phase 1: replace Box<dynamic> with Box<ExpenseModel>, Box<BudgetModel>, etc.

@module
abstract class HiveModule {
  @lazySingleton
  HiveService get hiveService => HiveService.instance;

  @lazySingleton
  @Named(HiveBoxNames.expenses)
  Box<dynamic> get expensesBox => HiveService.instance.expensesBox;

  @lazySingleton
  @Named(HiveBoxNames.budgets)
  Box<dynamic> get budgetsBox => HiveService.instance.budgetsBox;

  @lazySingleton
  @Named(HiveBoxNames.rules)
  Box<dynamic> get rulesBox => HiveService.instance.rulesBox;

  @lazySingleton
  @Named(HiveBoxNames.recurring)
  Box<dynamic> get recurringBox => HiveService.instance.recurringBox;

  @lazySingleton
  @Named(HiveBoxNames.categories)
  Box<dynamic> get categoriesBox => HiveService.instance.categoriesBox;

  @lazySingleton
  @Named(HiveBoxNames.notificationEvents)
  Box<dynamic> get notificationEventsBox =>
      HiveService.instance.notificationEventsBox;

  @lazySingleton
  @Named(HiveBoxNames.settings)
  Box<dynamic> get settingsBox => HiveService.instance.settingsBox;

  @lazySingleton
  @Named(HiveBoxNames.syncQueue)
  Box<dynamic> get syncQueueBox => HiveService.instance.syncQueueBox;
}
