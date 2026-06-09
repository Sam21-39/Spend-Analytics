import 'package:hive_ce/hive.dart';
import 'package:injectable/injectable.dart';

import '../../constants/hive_box_names.dart';
import '../../storage/hive_service.dart';
import '../../sync/models/sync_operation_model.dart';
import '../../../features/budget/data/models/budget_model.dart';
import '../../../features/categories/data/models/category_model.dart';
import '../../../features/expense/data/models/expense_model.dart';
import '../../../features/notifications/data/models/notification_event_model.dart';
import '../../../features/recurring/data/models/recurring_model.dart';
import '../../../features/rules/data/models/rule_model.dart';
import '../../../features/settings/data/models/settings_model.dart';

@module
abstract class HiveModule {
  @lazySingleton
  HiveService get hiveService => HiveService.instance;

  @lazySingleton
  @Named(HiveBoxNames.expenses)
  Box<ExpenseModel> get expensesBox => HiveService.instance.expensesBox;

  @lazySingleton
  @Named(HiveBoxNames.budgets)
  Box<BudgetModel> get budgetsBox => HiveService.instance.budgetsBox;

  @lazySingleton
  @Named(HiveBoxNames.rules)
  Box<RuleModel> get rulesBox => HiveService.instance.rulesBox;

  @lazySingleton
  @Named(HiveBoxNames.recurring)
  Box<RecurringModel> get recurringBox => HiveService.instance.recurringBox;

  @lazySingleton
  @Named(HiveBoxNames.categories)
  Box<CategoryModel> get categoriesBox => HiveService.instance.categoriesBox;

  @lazySingleton
  @Named(HiveBoxNames.notificationEvents)
  Box<NotificationEventModel> get notificationEventsBox =>
      HiveService.instance.notificationEventsBox;

  @lazySingleton
  @Named(HiveBoxNames.settings)
  Box<SettingsModel> get settingsBox => HiveService.instance.settingsBox;

  @lazySingleton
  @Named(HiveBoxNames.syncQueue)
  Box<SyncOperationModel> get syncQueueBox => HiveService.instance.syncQueueBox;
}
