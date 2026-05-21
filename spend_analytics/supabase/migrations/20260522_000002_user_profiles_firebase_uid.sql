alter table public.user_profiles
  add column if not exists firebase_uid text;

create unique index if not exists user_profiles_firebase_uid_key
  on public.user_profiles(firebase_uid)
  where firebase_uid is not null;
