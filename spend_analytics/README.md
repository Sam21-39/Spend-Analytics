# SpendSense (Reinvented Spend Analytics)

Offline-first personal finance app built with Flutter + GetX + Supabase + Firebase observability.

## Environment Setup (envified 3.3.0)

This project is configured for **prod-only** environment:
- Runtime config from `assets/env/.env.prod` (non-sensitive flags)
- Supabase/Firebase keys and IDs from local `.env.secrets.prod`
- Obfuscated generated secrets in `lib/core/config/secrets.g.dart`

## 1) Runtime env file

Copy and fill:
- `assets/env/env.prod.example` -> `assets/env/.env.prod`

`.env.prod` controls Firebase service file locations used by the setup script:
- `FIREBASE_ANDROID_SERVICE_FILE`
- `FIREBASE_IOS_SERVICE_FILE`

Default convention in this repo:
- `firebase/prod/google-services.json`
- `firebase/prod/GoogleService-Info.plist`

## 2) Secrets file

Copy and fill:
- `.env.secrets.prod.example` -> `.env.secrets.prod`

## 3) Generate service files + secrets

```bash
./tool/generate_secrets.sh
# or explicitly
./tool/generate_secrets.sh prod
```

Equivalent direct command:

```bash
fvm dart run envified --env=prod
```

## 4) Firebase setup (prod)

1. Create/select Firebase prod project.
2. Add Android app package:
   `com.sumit.spofficial.spend_analytics`
3. Add iOS app bundle id:
   `com.sumit.spofficial.spendanalytics`
4. Download configs and place them at:
   - `firebase/prod/google-services.json`
   - `firebase/prod/GoogleService-Info.plist`
5. Enable Analytics, Crashlytics, and Cloud Messaging.

## 5) Supabase setup (prod)

1. Create/select Supabase prod project.
2. Get URL, anon key, and project id.
3. Put them in `.env.secrets.prod`.
4. Apply schema + RLS SQL:
   - `supabase/migrations/20260521_000001_init.sql`
5. Enable Google auth provider in Supabase Auth.

## 6) Install dependencies

```bash
fvm flutter pub get
```

## 7) SDK sanity checks

If you ever see `The current Dart SDK version is 3.7.2`, the global SDK is being used instead of FVM.

Use:

```bash
fvm dart --version
fvm flutter --version
fvm flutter pub get
```

Expected:
- Flutter `3.44.0`
- Dart `3.12.0` (satisfies `>=3.9.0 <4.0.0`)

## Notes

- `.env.*` and `.env.secrets.*` are gitignored.
- `AppConfig.get(key)` resolves runtime `.env.prod` first, then generated `AppSecrets`.
- Always run through FVM in this repo.
