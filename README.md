# SpendSense (Reinvented Spend Analytics)

Offline-first personal finance app built with Flutter + GetX + Supabase + Firebase observability.

## Production Setup (dotenv)

### 1) Create dotenv file

Copy:

- `assets/env/.env.example` -> `assets/env/.env`

Sample keys used across app:

```env
SUPABASE_URL=https://YOUR_PROD_PROJECT.supabase.co
SUPABASE_ANON_KEY=your_prod_supabase_anon_key
SUPABASE_PROJECT_ID=YOUR_PROD_PROJECT
FIREBASE_API_KEY=your_prod_firebase_api_key
FIREBASE_APP_ID=1:1234567890:android:abcdef123456
FIREBASE_MESSAGING_SENDER_ID=1234567890
FIREBASE_PROJECT_ID=your-prod-firebase-project
FIREBASE_STORAGE_BUCKET=your-prod-project.appspot.com
FIREBASE_AUTH_DOMAIN=your-prod-project.firebaseapp.com
FIREBASE_IOS_BUNDLE_ID=com.example.prod
```

### 2) Firebase service files

Place:

- `firebase/prod/google-services.json`
- `firebase/prod/GoogleService-Info.plist`

Then run:

```bash
./tool/generate_secrets.sh prod
```

### 3) Install and run

```bash
fvm flutter pub get
fvm flutter run
```

## Notes

- Single environment only.
- No `envified` usage.
- Firebase is used for Analytics, Crashlytics, and FCM only.
