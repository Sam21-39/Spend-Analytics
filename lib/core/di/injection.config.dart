// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as _i974;
import 'package:connectivity_plus/connectivity_plus.dart' as _i895;
import 'package:firebase_analytics/firebase_analytics.dart' as _i398;
import 'package:firebase_auth/firebase_auth.dart' as _i59;
import 'package:firebase_crashlytics/firebase_crashlytics.dart' as _i141;
import 'package:firebase_messaging/firebase_messaging.dart' as _i892;
import 'package:firebase_performance/firebase_performance.dart' as _i346;
import 'package:firebase_remote_config/firebase_remote_config.dart' as _i627;
import 'package:firebase_storage/firebase_storage.dart' as _i457;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:hive_ce/hive.dart' as _i738;
import 'package:injectable/injectable.dart' as _i526;
import 'package:local_auth/local_auth.dart' as _i152;
import 'package:speech_to_text/speech_to_text.dart' as _i941;

import '../../features/analytics/presentation/bloc/reports_bloc.dart' as _i430;
import '../../features/auth/data/repositories/auth_repository.dart' as _i573;
import '../../features/auth/domain/repositories/i_auth_repository.dart'
    as _i589;
import '../../features/auth/domain/usecases/link_google_account_use_case.dart'
    as _i943;
import '../../features/auth/domain/usecases/sign_in_anonymously_use_case.dart'
    as _i444;
import '../../features/auth/domain/usecases/sign_in_with_google_use_case.dart'
    as _i1014;
import '../../features/auth/domain/usecases/sign_out_use_case.dart' as _i580;
import '../../features/auth/domain/usecases/watch_auth_state_use_case.dart'
    as _i873;
import '../../features/auth/presentation/bloc/auth_cubit.dart' as _i52;
import '../../features/budget/data/datasources/local/budget_local_datasource.dart'
    as _i1032;
import '../../features/budget/data/datasources/remote/budget_remote_datasource.dart'
    as _i718;
import '../../features/budget/data/models/budget_model.dart' as _i404;
import '../../features/budget/data/repositories/budget_repository_impl.dart'
    as _i74;
import '../../features/budget/domain/repositories/i_budget_repository.dart'
    as _i826;
import '../../features/budget/domain/usecases/archive_budget_use_case.dart'
    as _i757;
import '../../features/budget/domain/usecases/get_budget_progress_use_case.dart'
    as _i731;
import '../../features/budget/domain/usecases/load_budgets_use_case.dart'
    as _i613;
import '../../features/budget/domain/usecases/seed_default_budgets_use_case.dart'
    as _i974;
import '../../features/budget/domain/usecases/upsert_budget_use_case.dart'
    as _i966;
import '../../features/budget/presentation/bloc/budget_bloc.dart' as _i438;
import '../../features/categories/data/datasources/local/category_local_datasource.dart'
    as _i84;
import '../../features/categories/data/datasources/remote/category_remote_datasource.dart'
    as _i747;
import '../../features/categories/data/models/category_model.dart' as _i587;
import '../../features/categories/data/repositories/category_repository_impl.dart'
    as _i894;
import '../../features/categories/domain/repositories/i_category_repository.dart'
    as _i314;
import '../../features/categories/domain/usecases/add_category_use_case.dart'
    as _i809;
import '../../features/categories/domain/usecases/get_categories_use_case.dart'
    as _i308;
import '../../features/categories/domain/usecases/reorder_categories_use_case.dart'
    as _i244;
import '../../features/categories/domain/usecases/sync_categories_use_case.dart'
    as _i7;
import '../../features/categories/presentation/bloc/category_cubit.dart'
    as _i1054;
import '../../features/dashboard/presentation/bloc/dashboard_bloc.dart'
    as _i652;
import '../../features/expense/data/datasources/local/expense_local_datasource.dart'
    as _i104;
import '../../features/expense/data/datasources/remote/expense_remote_datasource.dart'
    as _i1056;
import '../../features/expense/data/models/expense_model.dart' as _i164;
import '../../features/expense/data/repositories/expense_repository_impl.dart'
    as _i587;
import '../../features/expense/domain/repositories/i_expense_repository.dart'
    as _i758;
import '../../features/expense/domain/usecases/add_expense_use_case.dart'
    as _i367;
import '../../features/expense/domain/usecases/delete_expense_use_case.dart'
    as _i105;
import '../../features/expense/domain/usecases/get_expense_by_id_use_case.dart'
    as _i742;
import '../../features/expense/domain/usecases/get_monthly_totals_use_case.dart'
    as _i861;
import '../../features/expense/domain/usecases/update_expense_use_case.dart'
    as _i920;
import '../../features/expense/domain/usecases/watch_expenses_use_case.dart'
    as _i106;
import '../../features/expense/presentation/bloc/expense_bloc.dart' as _i484;
import '../../features/notifications/data/datasources/local/notification_local_datasource.dart'
    as _i946;
import '../../features/notifications/data/models/notification_event_model.dart'
    as _i779;
import '../../features/notifications/data/repositories/notification_repository_impl.dart'
    as _i361;
import '../../features/notifications/domain/repositories/i_notification_repository.dart'
    as _i809;
import '../../features/notifications/presentation/bloc/notification_cubit.dart'
    as _i1060;
import '../../features/onboarding/presentation/bloc/onboarding_bloc.dart'
    as _i792;
import '../../features/premium/data/repositories/premium_repository.dart'
    as _i759;
import '../../features/premium/domain/repositories/i_premium_repository.dart'
    as _i352;
import '../../features/premium/domain/usecases/get_subscription_status_use_case.dart'
    as _i500;
import '../../features/premium/domain/usecases/purchase_premium_use_case.dart'
    as _i881;
import '../../features/premium/domain/usecases/restore_purchases_use_case.dart'
    as _i884;
import '../../features/premium/domain/usecases/verify_purchase_use_case.dart'
    as _i179;
import '../../features/premium/presentation/bloc/premium_cubit.dart' as _i578;
import '../../features/recurring/data/datasources/local/recurring_local_datasource.dart'
    as _i199;
import '../../features/recurring/data/datasources/remote/recurring_remote_datasource.dart'
    as _i999;
import '../../features/recurring/data/models/recurring_model.dart' as _i439;
import '../../features/recurring/data/repositories/recurring_repository_impl.dart'
    as _i558;
import '../../features/recurring/domain/repositories/i_recurring_repository.dart'
    as _i829;
import '../../features/recurring/domain/usecases/advance_recurring_due_date_use_case.dart'
    as _i675;
import '../../features/recurring/domain/usecases/check_recurring_due_use_case.dart'
    as _i428;
import '../../features/recurring/domain/usecases/create_recurring_use_case.dart'
    as _i1005;
import '../../features/recurring/domain/usecases/delete_recurring_use_case.dart'
    as _i0;
import '../../features/recurring/domain/usecases/load_recurring_use_case.dart'
    as _i645;
import '../../features/recurring/domain/usecases/update_recurring_use_case.dart'
    as _i605;
import '../../features/recurring/presentation/bloc/recurring_bloc.dart'
    as _i883;
import '../../features/rules/data/datasources/local/rules_local_datasource.dart'
    as _i799;
import '../../features/rules/data/datasources/remote/rules_remote_datasource.dart'
    as _i224;
import '../../features/rules/data/models/rule_model.dart' as _i578;
import '../../features/rules/data/repositories/rules_repository_impl.dart'
    as _i508;
import '../../features/rules/domain/repositories/i_rules_repository.dart'
    as _i25;
import '../../features/rules/domain/usecases/create_rule_use_case.dart'
    as _i602;
import '../../features/rules/domain/usecases/delete_rule_use_case.dart'
    as _i585;
import '../../features/rules/domain/usecases/evaluate_rules_use_case.dart'
    as _i784;
import '../../features/rules/domain/usecases/load_rules_use_case.dart' as _i237;
import '../../features/rules/domain/usecases/toggle_rule_use_case.dart'
    as _i697;
import '../../features/rules/domain/usecases/update_rule_use_case.dart' as _i74;
import '../../features/rules/presentation/bloc/rules_bloc.dart' as _i183;
import '../../features/settings/data/datasources/local/settings_local_datasource.dart'
    as _i280;
import '../../features/settings/data/models/settings_model.dart' as _i435;
import '../../features/settings/data/repositories/settings_repository_impl.dart'
    as _i955;
import '../../features/settings/domain/repositories/i_settings_repository.dart'
    as _i657;
import '../../features/settings/domain/usecases/clear_data_use_case.dart'
    as _i86;
import '../../features/settings/domain/usecases/export_csv_use_case.dart'
    as _i463;
import '../../features/settings/domain/usecases/export_pdf_use_case.dart'
    as _i1035;
import '../../features/settings/domain/usecases/get_settings_use_case.dart'
    as _i1064;
import '../../features/settings/domain/usecases/update_settings_use_case.dart'
    as _i932;
import '../../features/settings/presentation/bloc/settings_cubit.dart' as _i819;
import '../../features/voice/domain/usecases/start_listening_use_case.dart'
    as _i724;
import '../../features/voice/domain/usecases/stop_listening_use_case.dart'
    as _i846;
import '../../features/voice/domain/usecases/voice_parser_use_case.dart'
    as _i986;
import '../../features/voice/presentation/bloc/voice_bloc.dart' as _i754;
import '../biometric/cubit/biometric_cubit.dart' as _i577;
import '../services/sync_service.dart' as _i979;
import '../storage/hive_service.dart' as _i459;
import '../sync/cubit/sync_cubit.dart' as _i924;
import '../sync/models/sync_operation_model.dart' as _i732;
import '../theme/cubit/theme_cubit.dart' as _i194;
import 'modules/firebase_module.dart' as _i398;
import 'modules/hive_module.dart' as _i31;
import 'modules/platform_module.dart' as _i807;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final firebaseModule = _$FirebaseModule();
    final hiveModule = _$HiveModule();
    final platformModule = _$PlatformModule();
    gh.factory<_i986.VoiceParserUseCase>(
      () => const _i986.VoiceParserUseCase(),
    );
    gh.singleton<_i59.FirebaseAuth>(() => firebaseModule.auth);
    gh.singleton<_i974.FirebaseFirestore>(() => firebaseModule.firestore);
    gh.singleton<_i457.FirebaseStorage>(() => firebaseModule.storage);
    gh.singleton<_i398.FirebaseAnalytics>(() => firebaseModule.analytics);
    gh.singleton<_i141.FirebaseCrashlytics>(() => firebaseModule.crashlytics);
    gh.singleton<_i892.FirebaseMessaging>(() => firebaseModule.messaging);
    gh.singleton<_i346.FirebasePerformance>(() => firebaseModule.performance);
    await gh.singletonAsync<_i627.FirebaseRemoteConfig>(
      () => firebaseModule.remoteConfig,
      preResolve: true,
    );
    gh.lazySingleton<_i459.HiveService>(() => hiveModule.hiveService);
    gh.lazySingleton<_i558.FlutterSecureStorage>(
      () => platformModule.secureStorage,
    );
    gh.lazySingleton<_i895.Connectivity>(() => platformModule.connectivity);
    gh.lazySingleton<_i152.LocalAuthentication>(() => platformModule.localAuth);
    gh.lazySingleton<_i941.SpeechToText>(() => platformModule.speechToText);
    gh.lazySingleton<_i924.SyncCubit>(() => _i924.SyncCubit());
    gh.lazySingleton<_i1032.BudgetLocalDataSource>(
      () => _i1032.BudgetLocalDataSource(),
    );
    gh.lazySingleton<_i84.CategoryLocalDataSource>(
      () => _i84.CategoryLocalDataSource(),
    );
    gh.lazySingleton<_i104.ExpenseLocalDataSource>(
      () => _i104.ExpenseLocalDataSource(),
    );
    gh.lazySingleton<_i946.NotificationLocalDataSource>(
      () => _i946.NotificationLocalDataSource(),
    );
    gh.lazySingleton<_i199.RecurringLocalDataSource>(
      () => _i199.RecurringLocalDataSource(),
    );
    gh.lazySingleton<_i799.RulesLocalDataSource>(
      () => _i799.RulesLocalDataSource(),
    );
    gh.lazySingleton<_i280.SettingsLocalDataSource>(
      () => _i280.SettingsLocalDataSource(),
    );
    gh.lazySingleton<_i589.IAuthRepository>(() => _i573.AuthRepository());
    gh.lazySingleton<_i738.Box<_i578.RuleModel>>(
      () => hiveModule.rulesBox,
      instanceName: 'rules_box',
    );
    gh.lazySingleton<_i738.Box<_i404.BudgetModel>>(
      () => hiveModule.budgetsBox,
      instanceName: 'budgets_box',
    );
    gh.lazySingleton<_i738.Box<_i779.NotificationEventModel>>(
      () => hiveModule.notificationEventsBox,
      instanceName: 'notification_events_box',
    );
    gh.lazySingleton<_i738.Box<_i435.SettingsModel>>(
      () => hiveModule.settingsBox,
      instanceName: 'settings_box',
    );
    gh.lazySingleton<_i738.Box<_i164.ExpenseModel>>(
      () => hiveModule.expensesBox,
      instanceName: 'expenses_box',
    );
    gh.lazySingleton<_i738.Box<_i587.CategoryModel>>(
      () => hiveModule.categoriesBox,
      instanceName: 'categories_box',
    );
    gh.lazySingleton<_i352.IPremiumRepository>(() => _i759.PremiumRepository());
    gh.factory<_i500.GetSubscriptionStatusUseCase>(
      () => _i500.GetSubscriptionStatusUseCase(gh<_i352.IPremiumRepository>()),
    );
    gh.factory<_i881.PurchasePremiumUseCase>(
      () => _i881.PurchasePremiumUseCase(gh<_i352.IPremiumRepository>()),
    );
    gh.factory<_i884.RestorePurchasesUseCase>(
      () => _i884.RestorePurchasesUseCase(gh<_i352.IPremiumRepository>()),
    );
    gh.factory<_i179.VerifyPurchaseUseCase>(
      () => _i179.VerifyPurchaseUseCase(gh<_i352.IPremiumRepository>()),
    );
    gh.lazySingleton<_i738.Box<_i439.RecurringModel>>(
      () => hiveModule.recurringBox,
      instanceName: 'recurring_box',
    );
    gh.factory<_i943.LinkGoogleAccountUseCase>(
      () => _i943.LinkGoogleAccountUseCase(gh<_i589.IAuthRepository>()),
    );
    gh.factory<_i444.SignInAnonymouslyUseCase>(
      () => _i444.SignInAnonymouslyUseCase(gh<_i589.IAuthRepository>()),
    );
    gh.factory<_i1014.SignInWithGoogleUseCase>(
      () => _i1014.SignInWithGoogleUseCase(gh<_i589.IAuthRepository>()),
    );
    gh.factory<_i580.SignOutUseCase>(
      () => _i580.SignOutUseCase(gh<_i589.IAuthRepository>()),
    );
    gh.factory<_i873.WatchAuthStateUseCase>(
      () => _i873.WatchAuthStateUseCase(gh<_i589.IAuthRepository>()),
    );
    gh.lazySingleton<_i738.Box<_i732.SyncOperationModel>>(
      () => hiveModule.syncQueueBox,
      instanceName: 'sync_queue_box',
    );
    gh.lazySingleton<_i577.BiometricCubit>(
      () => _i577.BiometricCubit(gh<_i152.LocalAuthentication>()),
    );
    gh.lazySingleton<_i979.SyncService>(
      () => _i979.SyncService(
        gh<_i974.FirebaseFirestore>(),
        gh<_i141.FirebaseCrashlytics>(),
        gh<_i895.Connectivity>(),
      ),
    );
    gh.lazySingleton<_i25.IRulesRepository>(
      () => _i508.RulesRepositoryImpl(
        gh<_i799.RulesLocalDataSource>(),
        gh<_i979.SyncService>(),
      ),
    );
    gh.lazySingleton<_i809.INotificationRepository>(
      () => _i361.NotificationRepositoryImpl(
        gh<_i946.NotificationLocalDataSource>(),
      ),
    );
    gh.factory<_i602.CreateRuleUseCase>(
      () => _i602.CreateRuleUseCase(gh<_i25.IRulesRepository>()),
    );
    gh.factory<_i585.DeleteRuleUseCase>(
      () => _i585.DeleteRuleUseCase(gh<_i25.IRulesRepository>()),
    );
    gh.factory<_i237.LoadRulesUseCase>(
      () => _i237.LoadRulesUseCase(gh<_i25.IRulesRepository>()),
    );
    gh.factory<_i697.ToggleRuleUseCase>(
      () => _i697.ToggleRuleUseCase(gh<_i25.IRulesRepository>()),
    );
    gh.factory<_i74.UpdateRuleUseCase>(
      () => _i74.UpdateRuleUseCase(gh<_i25.IRulesRepository>()),
    );
    gh.lazySingleton<_i578.PremiumCubit>(
      () => _i578.PremiumCubit(
        gh<_i500.GetSubscriptionStatusUseCase>(),
        gh<_i881.PurchasePremiumUseCase>(),
        gh<_i884.RestorePurchasesUseCase>(),
        gh<_i179.VerifyPurchaseUseCase>(),
      ),
    );
    gh.lazySingleton<_i657.ISettingsRepository>(
      () => _i955.SettingsRepositoryImpl(gh<_i280.SettingsLocalDataSource>()),
    );
    gh.lazySingleton<_i718.BudgetRemoteDataSource>(
      () => _i718.BudgetRemoteDataSource(gh<_i974.FirebaseFirestore>()),
    );
    gh.lazySingleton<_i747.CategoryRemoteDataSource>(
      () => _i747.CategoryRemoteDataSource(gh<_i974.FirebaseFirestore>()),
    );
    gh.lazySingleton<_i1056.ExpenseRemoteDataSource>(
      () => _i1056.ExpenseRemoteDataSource(gh<_i974.FirebaseFirestore>()),
    );
    gh.lazySingleton<_i999.RecurringRemoteDataSource>(
      () => _i999.RecurringRemoteDataSource(gh<_i974.FirebaseFirestore>()),
    );
    gh.lazySingleton<_i224.RulesRemoteDataSource>(
      () => _i224.RulesRemoteDataSource(gh<_i974.FirebaseFirestore>()),
    );
    gh.lazySingleton<_i758.IExpenseRepository>(
      () => _i587.ExpenseRepositoryImpl(
        gh<_i104.ExpenseLocalDataSource>(),
        gh<_i1056.ExpenseRemoteDataSource>(),
        gh<_i979.SyncService>(),
      ),
    );
    gh.lazySingleton<_i52.AuthCubit>(
      () => _i52.AuthCubit(
        gh<_i873.WatchAuthStateUseCase>(),
        gh<_i1014.SignInWithGoogleUseCase>(),
        gh<_i444.SignInAnonymouslyUseCase>(),
        gh<_i943.LinkGoogleAccountUseCase>(),
        gh<_i580.SignOutUseCase>(),
      ),
    );
    gh.lazySingleton<_i314.ICategoryRepository>(
      () => _i894.CategoryRepositoryImpl(
        gh<_i84.CategoryLocalDataSource>(),
        gh<_i979.SyncService>(),
      ),
    );
    gh.factory<_i724.StartListeningUseCase>(
      () => _i724.StartListeningUseCase(gh<_i941.SpeechToText>()),
    );
    gh.factory<_i846.StopListeningUseCase>(
      () => _i846.StopListeningUseCase(gh<_i941.SpeechToText>()),
    );
    gh.factory<_i463.ExportCsvUseCase>(
      () => _i463.ExportCsvUseCase(gh<_i758.IExpenseRepository>()),
    );
    gh.factory<_i1035.ExportPdfUseCase>(
      () => _i1035.ExportPdfUseCase(gh<_i758.IExpenseRepository>()),
    );
    gh.factory<_i754.VoiceBloc>(
      () => _i754.VoiceBloc(
        gh<_i724.StartListeningUseCase>(),
        gh<_i846.StopListeningUseCase>(),
        gh<_i986.VoiceParserUseCase>(),
      ),
    );
    gh.lazySingleton<_i194.ThemeCubit>(
      () => _i194.ThemeCubit(gh<_i657.ISettingsRepository>()),
    );
    gh.factory<_i367.AddExpenseUseCase>(
      () => _i367.AddExpenseUseCase(gh<_i758.IExpenseRepository>()),
    );
    gh.factory<_i105.DeleteExpenseUseCase>(
      () => _i105.DeleteExpenseUseCase(gh<_i758.IExpenseRepository>()),
    );
    gh.factory<_i742.GetExpenseByIdUseCase>(
      () => _i742.GetExpenseByIdUseCase(gh<_i758.IExpenseRepository>()),
    );
    gh.factory<_i861.GetMonthlyTotalsUseCase>(
      () => _i861.GetMonthlyTotalsUseCase(gh<_i758.IExpenseRepository>()),
    );
    gh.factory<_i920.UpdateExpenseUseCase>(
      () => _i920.UpdateExpenseUseCase(gh<_i758.IExpenseRepository>()),
    );
    gh.factory<_i106.WatchExpensesUseCase>(
      () => _i106.WatchExpensesUseCase(gh<_i758.IExpenseRepository>()),
    );
    gh.factory<_i430.ReportsBloc>(
      () => _i430.ReportsBloc(
        gh<_i106.WatchExpensesUseCase>(),
        gh<_i463.ExportCsvUseCase>(),
        gh<_i1035.ExportPdfUseCase>(),
      ),
    );
    gh.lazySingleton<_i826.IBudgetRepository>(
      () => _i74.BudgetRepositoryImpl(
        gh<_i1032.BudgetLocalDataSource>(),
        gh<_i979.SyncService>(),
      ),
    );
    gh.factory<_i731.GetBudgetProgressUseCase>(
      () => _i731.GetBudgetProgressUseCase(
        gh<_i826.IBudgetRepository>(),
        gh<_i758.IExpenseRepository>(),
      ),
    );
    gh.factory<_i757.ArchiveBudgetUseCase>(
      () => _i757.ArchiveBudgetUseCase(gh<_i826.IBudgetRepository>()),
    );
    gh.factory<_i613.LoadBudgetsUseCase>(
      () => _i613.LoadBudgetsUseCase(gh<_i826.IBudgetRepository>()),
    );
    gh.factory<_i974.SeedDefaultBudgetsUseCase>(
      () => _i974.SeedDefaultBudgetsUseCase(gh<_i826.IBudgetRepository>()),
    );
    gh.factory<_i966.UpsertBudgetUseCase>(
      () => _i966.UpsertBudgetUseCase(gh<_i826.IBudgetRepository>()),
    );
    gh.lazySingleton<_i829.IRecurringRepository>(
      () => _i558.RecurringRepositoryImpl(
        gh<_i199.RecurringLocalDataSource>(),
        gh<_i979.SyncService>(),
      ),
    );
    gh.factory<_i438.BudgetBloc>(
      () => _i438.BudgetBloc(
        gh<_i731.GetBudgetProgressUseCase>(),
        gh<_i966.UpsertBudgetUseCase>(),
        gh<_i757.ArchiveBudgetUseCase>(),
        gh<_i974.SeedDefaultBudgetsUseCase>(),
      ),
    );
    gh.factory<_i1060.NotificationCubit>(
      () => _i1060.NotificationCubit(gh<_i809.INotificationRepository>()),
    );
    gh.factory<_i809.AddCategoryUseCase>(
      () => _i809.AddCategoryUseCase(gh<_i314.ICategoryRepository>()),
    );
    gh.factory<_i308.GetCategoriesUseCase>(
      () => _i308.GetCategoriesUseCase(gh<_i314.ICategoryRepository>()),
    );
    gh.factory<_i244.ReorderCategoriesUseCase>(
      () => _i244.ReorderCategoriesUseCase(gh<_i314.ICategoryRepository>()),
    );
    gh.factory<_i7.SyncCategoriesUseCase>(
      () => _i7.SyncCategoriesUseCase(gh<_i314.ICategoryRepository>()),
    );
    gh.factory<_i86.ClearDataUseCase>(
      () => _i86.ClearDataUseCase(gh<_i657.ISettingsRepository>()),
    );
    gh.factory<_i1064.GetSettingsUseCase>(
      () => _i1064.GetSettingsUseCase(gh<_i657.ISettingsRepository>()),
    );
    gh.factory<_i932.UpdateSettingsUseCase>(
      () => _i932.UpdateSettingsUseCase(gh<_i657.ISettingsRepository>()),
    );
    gh.factory<_i675.AdvanceRecurringDueDateUseCase>(
      () => _i675.AdvanceRecurringDueDateUseCase(
        gh<_i829.IRecurringRepository>(),
      ),
    );
    gh.factory<_i1005.CreateRecurringUseCase>(
      () => _i1005.CreateRecurringUseCase(gh<_i829.IRecurringRepository>()),
    );
    gh.factory<_i0.DeleteRecurringUseCase>(
      () => _i0.DeleteRecurringUseCase(gh<_i829.IRecurringRepository>()),
    );
    gh.factory<_i645.LoadRecurringUseCase>(
      () => _i645.LoadRecurringUseCase(gh<_i829.IRecurringRepository>()),
    );
    gh.factory<_i605.UpdateRecurringUseCase>(
      () => _i605.UpdateRecurringUseCase(gh<_i829.IRecurringRepository>()),
    );
    gh.factory<_i792.OnboardingBloc>(
      () => _i792.OnboardingBloc(
        gh<_i1064.GetSettingsUseCase>(),
        gh<_i932.UpdateSettingsUseCase>(),
        gh<_i974.SeedDefaultBudgetsUseCase>(),
      ),
    );
    gh.factory<_i428.CheckRecurringDueUseCase>(
      () => _i428.CheckRecurringDueUseCase(
        gh<_i829.IRecurringRepository>(),
        gh<_i809.INotificationRepository>(),
      ),
    );
    gh.factory<_i1054.CategoryCubit>(
      () => _i1054.CategoryCubit(
        gh<_i308.GetCategoriesUseCase>(),
        gh<_i809.AddCategoryUseCase>(),
        gh<_i244.ReorderCategoriesUseCase>(),
        gh<_i7.SyncCategoriesUseCase>(),
      ),
    );
    gh.factory<_i883.RecurringBloc>(
      () => _i883.RecurringBloc(
        gh<_i645.LoadRecurringUseCase>(),
        gh<_i1005.CreateRecurringUseCase>(),
        gh<_i605.UpdateRecurringUseCase>(),
        gh<_i0.DeleteRecurringUseCase>(),
        gh<_i675.AdvanceRecurringDueDateUseCase>(),
        gh<_i428.CheckRecurringDueUseCase>(),
      ),
    );
    gh.factory<_i819.SettingsCubit>(
      () => _i819.SettingsCubit(
        gh<_i1064.GetSettingsUseCase>(),
        gh<_i932.UpdateSettingsUseCase>(),
        gh<_i463.ExportCsvUseCase>(),
        gh<_i1035.ExportPdfUseCase>(),
        gh<_i86.ClearDataUseCase>(),
        gh<_i758.IExpenseRepository>(),
        gh<_i152.LocalAuthentication>(),
        gh<_i941.SpeechToText>(),
      ),
    );
    gh.factory<_i784.EvaluateRulesUseCase>(
      () => _i784.EvaluateRulesUseCase(
        gh<_i25.IRulesRepository>(),
        gh<_i758.IExpenseRepository>(),
        gh<_i826.IBudgetRepository>(),
        gh<_i809.INotificationRepository>(),
      ),
    );
    gh.factory<_i652.DashboardBloc>(
      () => _i652.DashboardBloc(
        gh<_i106.WatchExpensesUseCase>(),
        gh<_i731.GetBudgetProgressUseCase>(),
      ),
    );
    gh.factory<_i484.ExpenseBloc>(
      () => _i484.ExpenseBloc(
        gh<_i106.WatchExpensesUseCase>(),
        gh<_i367.AddExpenseUseCase>(),
        gh<_i920.UpdateExpenseUseCase>(),
        gh<_i105.DeleteExpenseUseCase>(),
        gh<_i784.EvaluateRulesUseCase>(),
      ),
    );
    gh.factory<_i183.RulesBloc>(
      () => _i183.RulesBloc(
        gh<_i237.LoadRulesUseCase>(),
        gh<_i602.CreateRuleUseCase>(),
        gh<_i74.UpdateRuleUseCase>(),
        gh<_i585.DeleteRuleUseCase>(),
        gh<_i697.ToggleRuleUseCase>(),
        gh<_i784.EvaluateRulesUseCase>(),
      ),
    );
    return this;
  }
}

class _$FirebaseModule extends _i398.FirebaseModule {}

class _$HiveModule extends _i31.HiveModule {}

class _$PlatformModule extends _i807.PlatformModule {}
