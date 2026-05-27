# Spend Analytics — Architecture & Design Patterns

> **App**: Spend Analytics `v3.0.0+12`  
> **Stack**: Flutter · Dart · GetX · Drift (SQLite) · Supabase · Firebase  
> **Core principle**: Offline-first, privacy-respecting expense tracker with optional cloud sync.

---

## Table of Contents

1. [High-Level Architecture](#1-high-level-architecture)
2. [Startup Sequence](#2-startup-sequence)
3. [State Management — GetX](#3-state-management--getx)
4. [Dependency Injection](#4-dependency-injection)
5. [Routing](#5-routing)
6. [Local Database (Drift / SQLite)](#6-local-database-drift--sqlite)
7. [Offline-First Sync Architecture](#7-offline-first-sync-architecture)
8. [Conflict Resolution](#8-conflict-resolution)
9. [Realtime (Supabase Channels)](#9-realtime-supabase-channels)
10. [Rule Engine](#10-rule-engine)
11. [Notification Pipeline](#11-notification-pipeline)
12. [Voice Input Pipeline](#12-voice-input-pipeline)
13. [Authentication & Guest Mode](#13-authentication--guest-mode)
14. [Budget Tracking](#14-budget-tracking)
15. [Firebase Observability](#15-firebase-observability)
16. [Configuration & Secrets](#16-configuration--secrets)
17. [Design System — Liquid Glass](#17-design-system--liquid-glass)
18. [UI Component Hierarchy](#18-ui-component-hierarchy)
19. [Supabase Backend Schema](#19-supabase-backend-schema)
20. [Security — Row Level Security](#20-security--row-level-security)
21. [Backend Automation (pg_cron)](#21-backend-automation-pgcron)
22. [Data Flow Diagrams](#22-data-flow-diagrams)
23. [Key Design Patterns Summary](#23-key-design-patterns-summary)

---

## 1. High-Level Architecture

```
┌─────────────────────────────────────────────────────────┐
│                     Flutter App                         │
│                                                         │
│  ┌────────────┐   ┌─────────────┐   ┌───────────────┐  │
│  │  Features  │   │    Core     │   │    Shared     │  │
│  │ (screens + │◄──│ (services + │   │ (models +     │  │
│  │controllers)│   │  DI + cfg)  │   │  widgets)     │  │
│  └────────────┘   └─────────────┘   └───────────────┘  │
│         │                │                              │
│         ▼                ▼                              │
│  ┌─────────────────────────────┐                        │
│  │   Drift (SQLite) — local    │  ← Source of Truth     │
│  └──────────────┬──────────────┘                        │
│                 │ SyncManager / RealtimeService          │
└─────────────────┼───────────────────────────────────────┘
                  │
      ┌───────────┴────────────┐
      ▼                        ▼
 Supabase                  Firebase
 (Auth, Postgres,          (Crashlytics,
  Realtime, Storage)        Analytics, FCM)
```

**Layer responsibilities:**

| Layer           | Path                                | Responsibility                |
| --------------- | ----------------------------------- | ----------------------------- |
| `lib/core/`     | Config, DI, Routes, Theme, Services | App-wide infrastructure       |
| `lib/features/` | Per-feature screens + controllers   | Business logic & UI           |
| `lib/shared/`   | Models, widgets, utils              | Cross-feature shared code     |
| `supabase/sql/` | SQL migrations                      | Backend schema, RLS, triggers |

---

## 2. Startup Sequence

[lib/main.dart](lib/main.dart) orchestrates a strictly ordered boot:

```
main()
 ├── WidgetsFlutterBinding.ensureInitialized()
 ├── AppConfig.init()            → loads .env / secrets
 └── DependencyInjection.init()  → boots all services in order
      ├── FirebaseBootstrapService.init()
      ├── SupabaseService.init()
      ├── CrashlyticsService.init()
      ├── AnalyticsService.init()
      ├── FcmService.init()
      ├── AppDatabase.init()      → enables FK pragma
      ├── SyncManager.init()      → connectivity watch + flush queue
      ├── RealtimeService.init()  → subscribes to Supabase channels
      ├── RuleEngine.init()
      └── AuthController (permanent GetX controller)
```

All core services are registered as **permanent GetX services** so they survive route navigation and are never garbage-collected.

---

## 3. State Management — GetX

The app uses [GetX](https://pub.dev/packages/get) (`^4.7.2`) as the unified state management, DI, and routing framework.

### Reactive State

Controllers expose `Rx` observables. The UI wraps reactive sections in `Obx(() { ... })`:

```dart
// In DashboardController
final transactions = <TransactionModel>[].obs;
final monthlySpend = 0.0.obs;

// In DashboardScreen
Obx(() {
  final spend = controller.monthlySpend.value;
  ...
})
```

### Service vs. Controller

| Type           | Base class       | Lifecycle                             | Examples                                        |
| -------------- | ---------------- | ------------------------------------- | ----------------------------------------------- |
| **Service**    | `GetxService`    | App lifetime (`permanent: true`)      | `SupabaseService`, `SyncManager`, `AppDatabase` |
| **Controller** | `GetxController` | Route lifetime (lazy put via binding) | `DashboardController`, `TransactionController`  |

### GetView Convention

Every feature screen extends `GetView<TController>` for zero-boilerplate controller access:

```dart
class DashboardScreen extends GetView<DashboardController> {
  // `controller` property is auto-provided
}
```

---

## 4. Dependency Injection

[lib/core/di/dependency_injection.dart](lib/core/di/dependency_injection.dart)

All services are registered using `Get.put(service, permanent: true)` which:

- Makes them globally accessible via `Get.find<T>()`
- Prevents disposal when routes change
- Guarantees single-instance semantics (singleton pattern)

Controllers are lazily registered via **BindingsBuilder** in [lib/core/routes/app_routes.dart](lib/core/routes/app_routes.dart):

```dart
GetPage(
  name: dashboard,
  page: () => const DashboardScreen(),
  binding: BindingsBuilder(
    () => Get.lazyPut<DashboardController>(() => DashboardController()),
  ),
),
```

`lazyPut` means the controller is only instantiated when its route is first visited, and is destroyed when the route is popped.

---

## 5. Routing

[lib/core/routes/app_routes.dart](lib/core/routes/app_routes.dart)

Routes are declared as compile-time string constants and mapped to `GetPage` entries:

```
/login            → LoginScreen
/dashboard        → DashboardScreen  [DashboardController binding]
/transaction/add  → AddTransactionScreen [TransactionController binding]
/transactions     → TransactionListScreen
/analytics        → AnalyticsScreen  [AnalyticsController binding]
/budgets          → BudgetScreen     [BudgetController binding]
/recurring        → RecurringScreen  [RecurringController binding]
/rules            → RulesScreen      [RulesController binding]
/categories       → CategoryScreen   [CategoryController binding]
/settings         → SettingsScreen   [SettingsController binding]
/notifications    → NotificationCenterScreen
/subscription     → SubscriptionPlansScreen
/legal/privacy    → PrivacyPolicyScreen
/legal/terms      → TermsOfServiceScreen
/voice/review     → VoiceAutoReviewScreen [VoiceController binding]
```

All navigation uses named routes (`Get.toNamed`, `Get.offAllNamed`). The default transition is `Transition.fadeIn`.

---

## 6. Local Database (Drift / SQLite)

[lib/core/local_db/app_database.dart](lib/core/local_db/app_database.dart)

Drift (`^2.28.2`) provides a type-safe, reactive SQLite layer. The database is the **primary source of truth** for all reads; cloud is a sync target.

### Tables

| Table                | Primary Key      | Purpose                  |
| -------------------- | ---------------- | ------------------------ |
| `Transactions`       | `id` (TEXT/UUID) | Expense/income records   |
| `SyncQueueItems`     | `id` (auto-inc)  | Outbound sync queue      |
| `Budgets`            | `id` (auto-inc)  | Monthly category budgets |
| `UserRules`          | `id` (TEXT/UUID) | Automation rules         |
| `NotificationEvents` | `id` (auto-inc)  | In-app notification log  |

### Schema Version

Current schema version is **6**. Migrations are additive:

```
v1 → initial Transactions table
v2 → SyncQueueItems table added
v3 → Transactions.updatedAt column added
v4 → Budgets table added
v5 → UserRules table added
v6 → NotificationEvents table added
```

### Reactive Queries (Stream Pattern)

Drift streams power live UI updates without polling:

```dart
// AppDatabase exposes streams
Stream<List<TransactionModel>> watchAllTransactions()
Stream<Map<String, double>> watchCategorySpendByMonth(...)
Stream<List<Budget>> watchBudgetsForMonth(...)
Stream<List<NotificationEvent>> watchNotificationEvents(...)
```

Controllers subscribe in `onInit()` and cancel in `onClose()`:

```dart
_transactionsSub = _db.watchAllTransactions().listen((rows) {
  transactions.assignAll(rows);
});

@override
void onClose() {
  _transactionsSub?.cancel();
}
```

### Upsert Semantics

All write operations use `insertOnConflictUpdate` which maps to SQLite `INSERT OR REPLACE`. This ensures idempotent writes from both local mutations and incoming sync payloads.

---

## 7. Offline-First Sync Architecture

[lib/core/sync/sync_manager.dart](lib/core/sync/sync_manager.dart)

The sync architecture follows a **local-first, queue-based outbox pattern**:

```
User Action
    │
    ▼
AppDatabase.upsertTransaction()   ← immediate local write
    │
    ▼
SyncManager.enqueueTransactionUpsert()
    │
    ▼
SyncQueueItems table (persisted queue)
    │
    ├── if online + authenticated → flushQueueIfPossible()
    │       │
    │       ▼
    │   Supabase.upsert()
    │       ├── success → markSyncQueueSuccess() → delete row
    │       └── failure → markSyncQueueFailure() → increment retryCount
    │
    └── if offline → stays in queue, flushed on connectivity restored
```

### Flush Triggers

The queue is flushed in three scenarios:

1. **On enqueue** — immediately after a new item is added
2. **On connectivity restored** — `connectivity_plus` stream fires when going online
3. **On auth state change** — when a user signs in

### Observable Sync State

```dart
final isOnline = true.obs;       // live connectivity state
final isSyncing = false.obs;     // flush in progress
final pendingSyncCount = 0.obs;  // items awaiting sync
```

These can be observed by any widget to show sync indicators.

### Queue Item Structure

```dart
class SyncQueueItems extends Table {
  entityType   // 'transaction'
  operation    // 'upsert'
  entityId     // UUID of the entity
  payloadJson  // full serialized model
  retryCount   // incremented on failure
  lastError    // last error message
}
```

---

## 8. Conflict Resolution

[lib/core/sync/conflict_resolver.dart](lib/core/sync/conflict_resolver.dart)

Uses a **Last-Write-Wins (LWW)** strategy based on `updated_at` timestamps:

```dart
enum ConflictResolution { localWins, remoteWins, tie }

ConflictResolution resolve({
  required DateTime localUpdatedAt,
  required DateTime remoteUpdatedAt,
})
```

| Condition                            | Resolution                                      |
| ------------------------------------ | ----------------------------------------------- |
| `local.updatedAt > remote.updatedAt` | `localWins` → keep local, re-enqueue to push    |
| `remote.updatedAt > local.updatedAt` | `remoteWins` → overwrite local with remote      |
| Equal timestamps                     | `tie` → local retained (local-first preference) |

The `ConflictResolver` is a **pure stateless class** (`const ConflictResolver()`) used by `RealtimeService` during incoming realtime events.

---

## 9. Realtime (Supabase Channels)

[lib/core/supabase/realtime_service.dart](lib/core/supabase/realtime_service.dart)

Subscribes to PostgreSQL changes on the `transactions` table via Supabase Realtime:

```dart
channel.onPostgresChanges(
  event: PostgresChangeEvent.all,
  schema: 'public',
  table: 'transactions',
  filter: PostgresChangeFilter(
    type: PostgresChangeFilterType.eq,
    column: 'user_id',
    value: userId,
  ),
  callback: _handleTransactionChange,
)
```

### Event Handling

| Event               | Logic                                                              |
| ------------------- | ------------------------------------------------------------------ |
| `INSERT` / `UPDATE` | `_mergeUpsert()` — resolve conflict, apply remote or re-push local |
| `DELETE`            | `_mergeDelete()` — apply if remote wins, otherwise re-push local   |

Subscription is per-user-id and refreshed on sign-in/sign-out via `refreshSubscription()`.

---

## 10. Rule Engine

[lib/core/rules/rule_engine.dart](lib/core/rules/rule_engine.dart)

A lightweight **rules evaluation engine** that runs after each expense transaction is saved. It implements a simple **Chain of Responsibility** pattern.

### Evaluation Flow

```
TransactionController.addTransaction(txn)
    └── RuleEngine.evaluate(txn)
            ├── guard: skip if not 'expense'
            ├── load active rules from DB
            └── for each rule:
                    switch(ruleType)
                    ├── 'budget_threshold' → _checkBudgetThreshold()
                    ├── 'daily_limit'      → _checkDailyLimit()
                    └── default            → (skip)
```

### Rule Types

| `ruleType`          | Parameters                | Behaviour                                                                    |
| ------------------- | ------------------------- | ---------------------------------------------------------------------------- |
| `budget_threshold`  | `threshold_pct` (0.0–1.0) | Alert when category spend crosses the % of monthly budget for the first time |
| `daily_limit`       | `limit_amount` (₹)        | Alert when total daily expense crosses the limit for the first time          |
| `no_entry_reminder` | `time` (HH:mm)            | _(stored, not yet evaluated)_ Reminder if no expense logged                  |
| `category_spike`    | `multiplier`              | _(stored, not yet evaluated)_ Unusual category jump                          |
| `weekend_overspend` | —                         | _(stored, not yet evaluated)_ Weekend vs weekday comparison                  |
| `recurring_due`     | `days_before`             | _(stored, not yet evaluated)_ Upcoming recurring charge                      |

### Edge-Case Guards

- Thresholds are only fired **once per crossing** — the engine checks `previousRatio < threshold && currentRatio >= threshold` to avoid spamming.
- Rules with `isActive = false` are filtered out by `getActiveRules()`.

### Default Rules (seeded per user)

When a user first opens Rules, three defaults are created:

1. `budget_threshold` at 80%
2. `daily_limit` at ₹1,500
3. `no_entry_reminder` at 21:00

---

## 11. Notification Pipeline

There are two notification channels working in parallel:

### A. Firebase Cloud Messaging (FCM)

[lib/core/firebase/fcm_service.dart](lib/core/firebase/fcm_service.dart)

Used for server-push notifications (e.g., future backend alerts). Also wraps `flutter_local_notifications` for in-app display of incoming FCM messages.

FCM token is written to `user_profiles.fcm_token` in Supabase on login and refreshed via `onTokenRefresh`.

### B. In-App Notification Center

[lib/core/local_db/app_database.dart](lib/core/local_db/app_database.dart) — `NotificationEvents` table

Rule-triggered notifications are written locally to `NotificationEvents` AND shown as local push notifications simultaneously:

```dart
// Rule fires both:
await _db.addNotificationEvent(...)   // persists to local DB
await _fcm.showLocalNotification(...) // shows OS notification
```

The `NotificationCenterScreen` watches the local DB stream and displays all past events.

### Notification Tap Routing

Both FCM and local notifications carry a `route` field in the payload. Tapping navigates to the relevant screen:

```dart
Get.toNamed(route, arguments: data);
```

---

## 12. Voice Input Pipeline

[lib/features/voice/voice_controller.dart](lib/features/voice/voice_controller.dart)  
[lib/features/voice/voice_parser.dart](lib/features/voice/voice_parser.dart)

```
Microphone
    │
    ▼
speech_to_text (SpeechToText)
    │ transcript (Rx<String>)
    ▼
VoiceParser.parse(transcript)
    ├── Amount extraction: regex \d+(\.\d+)?( rupees|rs|inr|₹)?
    ├── Category detection: keyword matching against dict
    │   Food, Transport, Shopping, Health, Bills → Others
    ├── Payment mode: keyword match (upi, card, cash, netbanking)
    └── Merchant: regex `at <MerchantName>`
    │
    ▼
VoiceAutoReviewScreen (editable fields)
    │
    ▼
VoiceController.saveParsedTransaction()
    └── TransactionController.addTransaction()
```

**VoiceParser** is a **pure static class** — no state, no side effects — making it trivially testable.

---

## 13. Authentication & Guest Mode

[lib/features/auth/auth_controller.dart](lib/features/auth/auth_controller.dart)

### Auth Flow

```
LoginScreen
    ├── "Continue as Guest"
    │       └── isLoggedIn = false → navigate to Dashboard
    │           (all data stored locally under userId = 'guest')
    │
    └── "Sign in with Google"
            ├── GoogleSignIn.signIn()
            ├── Supabase.auth.signInWithIdToken(idToken)
            ├── upsert user_profiles (display_name, avatar_url)
            ├── updateUser() metadata
            ├── RealtimeService.refreshSubscription()
            ├── Privacy Gate (one-time modal per userId)
            └── navigate to Dashboard
```

### User ID Resolution

The `resolveActiveUserId()` pattern is used across all controllers to handle both authenticated and guest users:

```dart
String resolveActiveUserId() {
  if (_supabase.isAuthenticated) {
    return _supabase.currentUserId!;  // Supabase UUID
  }
  return 'guest';                     // fallback for local-only mode
}
```

### Privacy Gate

A non-dismissible `AlertDialog` shown **once per userId** (flag persisted in `SharedPreferences`). Communicates privacy guarantees before the user reaches the main app.

### Sign Out

Clears both Google and Supabase sessions, unsubscribes from realtime channels, navigates back to login.

---

## 14. Budget Tracking

[lib/features/budgets/budget_controller.dart](lib/features/budgets/budget_controller.dart)

Budget data is stored **both locally and in Supabase**. On init:

```
BudgetController.onInit()
    └── _bootstrap()
            ├── _seedDefaultBudgetsIfNeeded()  (Food ₹4000, Transport ₹2500, Shopping ₹3000)
            ├── _syncWithCloud()               (pull cloud → push local)
            ├── watchBudgetsForMonth()          → reactive categoryBudgets map
            └── watchCategorySpendByMonth()     → reactive categorySpend map
```

The **budget vs. actual spend** comparison is done via two parallel streams from Drift:

- `watchBudgetsForMonth` → limits per category
- `watchCategorySpendByMonth` → actual expense totals aggregated from `Transactions`

---

## 15. Firebase Observability

Three Firebase services are integrated:

| Service                    | File                                                                                                   | Purpose                                                                   |
| -------------------------- | ------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------- |
| `FirebaseBootstrapService` | [lib/core/firebase/firebase_bootstrap_service.dart](lib/core/firebase/firebase_bootstrap_service.dart) | Initializes `Firebase.initializeApp()`, gates all other Firebase services |
| `AnalyticsService`         | [lib/core/firebase/analytics_service.dart](lib/core/firebase/analytics_service.dart)                   | `logEvent()`, `logTransactionAdded()`                                     |
| `CrashlyticsService`       | [lib/core/firebase/crashlytics_service.dart](lib/core/firebase/crashlytics_service.dart)               | `recordError(error, stack, customKeys)` — all `catch` blocks call this    |

**Guard pattern**: All Firebase services check `_enabled = Get.find<FirebaseBootstrapService>().isEnabled` before executing. If Firebase is not configured (e.g., in development without `google-services.json`), all calls are silently no-ops.

**Error context**: `customKeys` map is always set at call sites to provide triage context:

```dart
customKeys: <String, Object?>{
  'action': 'add_transaction',
  'type': txn.type,
}
```

---

## 16. Configuration & Secrets

[lib/core/config/app_config.dart](lib/core/config/app_config.dart)

Two-tier configuration:

| Source                           | Contents                                                                    | Mechanism                                             |
| -------------------------------- | --------------------------------------------------------------------------- | ----------------------------------------------------- |
| `assets/env/.env`                | `APP_NAME`, `APP_VERSION_STRING`, etc.                                      | `envified` runtime env loading                        |
| `lib/core/config/secrets.g.dart` | `SUPABASE_URL`, `SUPABASE_ANON_KEY`, `GOOGLE_WEB_CLIENT_ID`, OIDC endpoints | `envified` code-gen at build time from `.env.secrets` |

`AppConfig` is a static-only class (private constructor, `AppConfig._()`) accessed via static getters:

```dart
AppConfig.supabaseUrl        // from secrets.g.dart
AppConfig.appName            // from .env at runtime
AppConfig.hasSupabaseConfig  // guard helper
```

---

## 17. Design System — Liquid Glass

The app ships a custom **Liquid Glass** design system introduced in recent commits, sitting on top of Material 3.

### Token Layer

[lib/core/theme/liquid_glass_tokens.dart](lib/core/theme/liquid_glass_tokens.dart)

```dart
class LiquidGlassColors { ... }   // dark-first palette
class LiquidGlassDecor  { ... }   // border radii, shadows, gradients
```

| Token              | Value                    | Usage               |
| ------------------ | ------------------------ | ------------------- |
| `background`       | `#121317`                | App background      |
| `surface`          | `#121317`                | Base surface        |
| `surfaceContainer` | `#1E1F23`                | Cards               |
| `primary`          | `#ADC6FF`                | Accent, interactive |
| `secondary`        | `#FFB3B5`                | Secondary accent    |
| `cardRadius`       | `24px`                   | Card corners        |
| `chipRadius`       | `999px`                  | Pills / bottom nav  |
| `glowPrimary`      | `rgba(173,198,255,0.22)` | Card glow           |

### Theme Layer

[lib/core/theme/app_theme.dart](lib/core/theme/app_theme.dart)

- Material 3 (`useMaterial3: true`)
- `Inter` font via Google Fonts
- Custom overrides for `AppBarTheme`, `FilledButtonTheme`, `InputDecorationTheme`, `SnackBarTheme`
- Both `light` and `dark` themes; system theme mode (`ThemeMode.system`)

---

## 18. UI Component Hierarchy

### Layout Components

```
LiquidPageScaffold
├── LiquidGlassBackground    ← full-screen animated gradient backdrop
├── SafeArea
│   ├── LiquidGlassSurface (app bar row — "Spend Analytics" title + actions)
│   └── SingleChildScrollView
│       └── [screen content]
└── LiquidBottomNav          ← floating frosted-glass pill nav bar
    └── LiquidGlassSurface (pill shape, opacity=0.22, blur=28)
```

### `LiquidGlassSurface`

[lib/shared/widgets/liquid_glass_surface.dart](lib/shared/widgets/liquid_glass_surface.dart)

The core glass card primitive:

```dart
Container (border + shadow)
  └── ClipRRect
        └── BackdropFilter (ImageFilter.blur σ=22)
              └── Container (semi-transparent white gradient fill)
                    └── child
```

Parameters: `opacity`, `blur`, `borderOpacity`, `borderRadius`, `padding`, `margin` — all configurable per instance.

### `SpendCard`

[lib/shared/widgets/spend_card.dart](lib/shared/widgets/spend_card.dart)

A styled card for transaction display, built on `LiquidGlassSurface`.

### `LiquidBottomNav`

[lib/shared/widgets/liquid_bottom_nav.dart](lib/shared/widgets/liquid_bottom_nav.dart)

Fixed 4-item nav: Home, Analytics, Budgets, Rules. Uses `Get.offAllNamed` (clears stack) for tab switching.

---

## 19. Supabase Backend Schema

[supabase/sql/01_schema.sql](supabase/sql/01_schema.sql)

### Tables

```sql
user_profiles      (id uuid PK → auth.users)
categories         (id uuid PK, user_id FK)
transactions       (id uuid PK, user_id FK, amount, type, payment_mode, tags[], is_deleted)
recurring_expenses (id uuid PK, user_id FK, frequency, next_due_date, auto_log)
budgets            (id uuid PK, user_id FK, category_name, month, year, limit_amount)
user_rules         (id uuid PK, user_id FK, rule_type, parameters jsonb, is_active)
job_run_log        (id bigserial, job_name, status, details jsonb)
```

### Notable Design Decisions

- `transactions.is_deleted` — soft-delete flag; hard-deleted by cron after 90 days
- `transactions.category_name` — denormalized text alongside optional `category_id` FK to avoid joins in the mobile client
- `budgets` has **two unique indexes**: one on `(user_id, category_id, month, year)` and one partial index on `(user_id, category_name, month, year) WHERE category_name IS NOT NULL`
- `user_rules.parameters` stored as `jsonb` to allow flexible rule configuration without schema migrations
- All timestamps are `timestamptz` (timezone-aware)

### Triggers

[supabase/sql/03_triggers.sql](supabase/sql/03_triggers.sql)

A single `set_updated_at()` function is attached as a `BEFORE UPDATE` trigger on all tables that have `updated_at`:

```sql
create or replace function public.set_updated_at()
returns trigger language plpgsql as $$
begin
  new.updated_at = now();
  return new;
end;
$$;
```

This is the server-side complement to the client-side `updatedAt` tracking used in conflict resolution.

---

## 20. Security — Row Level Security

[supabase/sql/04_rls.sql](supabase/sql/04_rls.sql)

RLS is enabled on **all tables**. The policy pattern is uniform:

```sql
create policy "Users access own [table]"
on public.[table]
for all to authenticated
using ((select auth.uid()) = user_id)
with check ((select auth.uid()) = user_id);
```

Using `(select auth.uid())` (subquery form) instead of `auth.uid()` is a Supabase performance best practice — it avoids re-evaluating the function per row.

`job_run_log` has a blanket deny policy (`using (false)`) to prevent any authenticated client from reading cron audit logs.

---

## 21. Backend Automation (pg_cron)

[supabase/sql/06_crons.sql](supabase/sql/06_crons.sql)

Two scheduled jobs run via `pg_cron`:

| Job                                        | Schedule                   | Logic                                                                               |
| ------------------------------------------ | -------------------------- | ----------------------------------------------------------------------------------- |
| `Spend Analytics-clean-soft-deleted`       | `30 2 * * *` (02:30 daily) | Hard-deletes transactions with `is_deleted = true AND updated_at < now() - 90 days` |
| `Spend Analytics-roll-recurring-due-dates` | `0 6 * * *` (06:00 daily)  | Advances `next_due_date` for active recurring expenses that are past due            |

Both functions:

- Are `SECURITY DEFINER` (run as the function owner, not the caller)
- Have `REVOKE ALL ... FROM public, anon, authenticated` — only `service_role` can call them
- Write execution metadata (rows affected) to `job_run_log`

---

## 22. Data Flow Diagrams

### Adding a Transaction

```
User taps "Save" in AddTransactionScreen
        │
        ▼
TransactionController.addTransaction(txn)
        ├── AppDatabase.upsertTransaction(txn)        ← SQLite write
        ├── SyncManager.enqueueTransactionUpsert(txn) ← queue for cloud
        ├── RuleEngine.evaluate(txn)                  ← check rules
        │       ├── _checkBudgetThreshold()
        │       │       └── if crossed → addNotificationEvent() + showLocalNotification()
        │       └── _checkDailyLimit()
        │               └── if crossed → addNotificationEvent() + showLocalNotification()
        └── AnalyticsService.logTransactionAdded(txn) ← Firebase event
```

### Incoming Realtime Change (Remote Device)

```
Remote device saves transaction
        │
        ▼
Supabase Postgres change event
        │
        ▼
RealtimeService._handleTransactionChange(payload)
        │
        ├── INSERT/UPDATE → _mergeUpsert()
        │       ├── load localTxn from SQLite
        │       ├── ConflictResolver.resolve(local.updatedAt, remote.updatedAt)
        │       │       ├── remoteWins → AppDatabase.upsertTransaction(remoteTxn)
        │       │       └── localWins  → SyncManager.enqueueTransactionUpsert(localTxn)
        │       └── (new record) → AppDatabase.upsertTransaction(remoteTxn)
        │
        └── DELETE → _mergeDelete()
                ├── ConflictResolver.shouldApplyRemote(...)
                ├── true  → AppDatabase.deleteTransactionById(id)
                └── false → SyncManager.enqueueTransactionUpsert(localTxn) ← resurrect
```

### Rule Sync (Bidirectional)

```
RulesController._syncWithCloud()
        ├── SupabaseService.fetchRules()
        │       └── for each cloud rule → AppDatabase.upsertRule()
        │
        └── AppDatabase.getRules(userId)
                └── for each local rule → SupabaseService.upsertRule()
```

---

## 23. Key Design Patterns Summary

| Pattern                           | Where Used                                       | Purpose                                                             |
| --------------------------------- | ------------------------------------------------ | ------------------------------------------------------------------- |
| **Service Locator**               | `Get.find<T>()` everywhere                       | Zero-coupling dependency access                                     |
| **Singleton (permanent service)** | `Get.put(..., permanent: true)`                  | Single app-lifetime instance for services                           |
| **Observer / Reactive**           | Drift streams + `Rx<T>` + `Obx()`                | Auto-updating UI without manual refresh                             |
| **Repository**                    | `AppDatabase`                                    | All data access in one place; UI never touches SQLite directly      |
| **Outbox / Queue**                | `SyncQueueItems` + `SyncManager`                 | Guaranteed eventual consistency offline-first writes                |
| **Last-Write-Wins**               | `ConflictResolver`                               | Simple, deterministic conflict resolution based on `updated_at`     |
| **Chain of Responsibility**       | `RuleEngine.evaluate()`                          | Ordered rule evaluation, easy to add new rule types                 |
| **ViewModel**                     | `RuleViewModel`                                  | Transforms DB model to display-ready strings (titles, subtitles)    |
| **Strategy**                      | `ConflictResolution` enum                        | Selects merge strategy at runtime based on timestamp comparison     |
| **Guard / Null Object**           | `isEnabled` checks on Firebase/Supabase services | Graceful degradation when optional services not configured          |
| **Immutable Value Object**        | `@immutable TransactionModel`                    | Safe to share, compare, and cache without defensive copies          |
| **Pure Static Function**          | `VoiceParser.parse()`                            | Stateless transformation, trivially unit-testable                   |
| **Dual-index Unique Constraint**  | Supabase `budgets` table                         | Supports both UUID category FK and plain-text category name lookups |

---

_Last updated: May 2026 — reflects codebase at commit `ba3ad77`_
