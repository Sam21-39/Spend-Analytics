-- Spend Analytics base schema

create table if not exists public.user_profiles (
  id uuid references auth.users primary key,
  firebase_uid text,
  display_name text,
  avatar_url text,
  currency_code text default 'INR',
  monthly_income numeric(12,2),
  fcm_token text,
  created_at timestamptz default now(),
  updated_at timestamptz default now()
);

create unique index if not exists user_profiles_firebase_uid_key
  on public.user_profiles(firebase_uid)
  where firebase_uid is not null;

create table if not exists public.categories (
  id uuid primary key default gen_random_uuid(),
  user_id uuid references public.user_profiles(id),
  name text not null,
  icon text,
  color text,
  is_system boolean default false,
  sort_order int default 0,
  created_at timestamptz default now(),
  updated_at timestamptz default now()
);

create table if not exists public.transactions (
  id uuid primary key default gen_random_uuid(),
  user_id uuid references public.user_profiles(id),
  amount numeric(12,2) not null,
  type text check (type in ('expense', 'income', 'transfer')) not null,
  category_id uuid references public.categories(id),
  category_name text,
  payment_mode text check (payment_mode in ('cash','upi','card','netbanking','other')),
  note text,
  tags text[],
  receipt_url text,
  transaction_date date not null,
  created_at timestamptz default now(),
  updated_at timestamptz default now(),
  is_deleted boolean default false
);

create table if not exists public.recurring_expenses (
  id uuid primary key default gen_random_uuid(),
  user_id uuid references public.user_profiles(id),
  name text not null,
  amount numeric(12,2) not null,
  category_id uuid references public.categories(id),
  category_name text,
  frequency text check (frequency in ('daily','weekly','monthly','yearly')),
  next_due_date date,
  auto_log boolean default false,
  is_active boolean default true,
  created_at timestamptz default now(),
  updated_at timestamptz default now()
);

create table if not exists public.budgets (
  id uuid primary key default gen_random_uuid(),
  user_id uuid references public.user_profiles(id),
  category_id uuid references public.categories(id),
  category_name text,
  month int check (month between 1 and 12),
  year int,
  limit_amount numeric(12,2) not null,
  created_at timestamptz default now(),
  updated_at timestamptz default now(),
  unique(user_id, category_id, month, year)
);

create unique index if not exists budgets_user_category_name_month_year_key
  on public.budgets(user_id, category_name, month, year)
  where category_name is not null;

create table if not exists public.user_rules (
  id uuid primary key default gen_random_uuid(),
  user_id uuid references public.user_profiles(id),
  rule_type text check (rule_type in (
    'budget_threshold',
    'daily_limit',
    'category_spike',
    'no_entry_reminder',
    'weekend_overspend',
    'recurring_due'
  )),
  parameters jsonb not null,
  is_active boolean default true,
  created_at timestamptz default now(),
  updated_at timestamptz default now()
);

create table if not exists public.job_run_log (
  id bigserial primary key,
  job_name text not null,
  status text not null default 'ok',
  details jsonb,
  created_at timestamptz not null default now()
);
