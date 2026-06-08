abstract final class AppConstants {
  // Hive schema versioning (bump when a breaking field change requires DataMigrationService)
  static const hiveSchemaVersionKey = 'hiveSchemaVersion';
  static const hiveSchemaVersion = 1;

  // Secure storage key for Hive AES encryption cipher
  static const hiveEncryptionKeyStorageKey = 'hive_aes_encryption_key';

  // Free tier limits (also controlled by Remote Config — these are compile-time fallbacks)
  static const maxFreeExpensesPerMonth = 50;
  static const maxFreeBudgets = 2;
  static const maxFreeRules = 3;

  // Biometric lock grace window
  static const biometricGraceWindowMinutes = 15;

  // Voice input
  static const voiceListenMaxSeconds = 35;
  static const voicePauseThresholdSeconds = 2;

  // Sync queue
  static const syncQueueBatchSize = 100;
  static const syncQueueMaxRetries = 5;

  // Default budget seeds (INR amounts; displayed with selected currency)
  static const defaultBudgets = [
    (category: 'Food', amountInr: 4000.0),
    (category: 'Transport', amountInr: 2500.0),
    (category: 'Shopping', amountInr: 3000.0),
  ];

  // Default categories (mirrors CategoryController hardcoded lists)
  static const defaultExpenseCategories = [
    'Food', 'Groceries', 'Rent', 'Transport', 'Shopping',
    'Bills', 'Health', 'Education', 'Entertainment', 'Travel',
    'Insurance', 'Others',
  ];

  static const defaultIncomeCategories = [
    'Salary', 'Freelance', 'Business', 'Interest', 'Dividends',
    'Bonus', 'Rental Income', 'Refund', 'Gift Received', 'Others',
  ];

  static const defaultTransferCategories = [
    'Bank Transfer', 'UPI Transfer', 'Wallet Transfer', 'Cash Withdrawal',
    'Cash Deposit', 'Card Payment', 'Credit Card Bill', 'Internal Transfer',
  ];

  // IAP product IDs
  static const iapPremiumMonthly = 'com.appamania.spendanalytics.premium_monthly';
  static const iapPremiumLifetime = 'com.appamania.spendanalytics.premium_lifetime';

  // Firebase Remote Config keys
  static const rcMaxFreeExpensesPerMonth = 'max_free_expenses_per_month';
  static const rcMaxFreeBudgets = 'max_free_budgets';
  static const rcMaxFreeRules = 'max_free_rules';
  static const rcRazorpayEnabled = 'razorpay_enabled';
  static const rcOnboardingVariant = 'onboarding_variant';
  static const rcPremiumFeaturesEnabled = 'premium_features_enabled';
  static const rcVoiceEntryEnabled = 'voice_entry_enabled';
  static const rcRecurringEnabled = 'recurring_enabled';

  // Firestore collections / field names
  static const firestoreUsersCollection = 'users';
  static const firestoreExpensesCollection = 'expenses';
  static const firestoreBudgetsCollection = 'budgets';
  static const firestoreRulesCollection = 'rules';
  static const firestoreRecurringCollection = 'recurring';
  static const firestoreCategoriesCollection = 'categories';
  static const firestoreNotificationsCollection = 'notification_events';
  static const firestoreFcmTokenField = 'fcmToken';
  static const firestoreSubscriptionTierField = 'subscriptionTier';
  static const firestoreIsDeletedField = 'isDeleted';
  static const firestoreDeletedAtField = 'deletedAt';
  static const firestoreUpdatedAtField = 'updatedAt';
  static const firestoreCreatedAtField = 'createdAt';

  // SharedPreferences keys (legacy — kept for DataMigrationService reads in Phase 1h)
  static const legacyCategoryOrderKey = 'category_order_v2_';
  static const legacyPrivacyGateKey = 'privacy_gate_seen_';
  static const legacySettingsCurrency = 'settings_currency';
  static const legacySettingsNotificationsEnabled = 'settings_notifications_enabled';
  static const legacySettingsBiometricEnabled = 'settings_biometric_enabled';
  static const legacySettingsVoiceEntryEnabled = 'settings_voice_entry_enabled';
  static const legacySettingsPremiumEnabled = 'settings_premium_enabled';
  static const legacyThemeMode = 'theme_mode';
}
