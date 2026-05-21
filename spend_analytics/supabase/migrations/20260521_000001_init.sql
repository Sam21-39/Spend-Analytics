-- SpendSense baseline schema (dev/prod)
-- Run in Supabase SQL editor for each environment.

create extension if not exists pgcrypto;

create table if not exists public.user_profiles (
  id uuid references auth.users primary key,
  display_name text,
  avatar_url text,
  currency_code text default 'INR',
  monthly_income numeric(12,2),
  fcm_token text,
  created_at timestamptz default now(),
  updated_at timestamptz default now()
);

create table if not exists public.categories (
  id uuid primary key default gen_random_uuid(),
  user_id uuid references public.user_profiles(id),
  name text not null,
  icon text,
  color text,
  is_system boolean default false,
  sort_order int default 0,
  created_at timestamptz default now()
);

create table if not exists public.transactions (
  id uuid primary key default gen_random_uuid(),
  user_id uuid references public.user_profiles(id),
  amount numeric(12,2) not null,
  type text check (type in ('expense', 'income', 'transfer')) not null,
  category_id uuid references public.categories(id),
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
  frequency text check (frequency in ('daily','weekly','monthly','yearly')),
  next_due_date date,
  auto_log boolean default false,
  is_active boolean default true
);

create table if not exists public.budgets (
  id uuid primary key default gen_random_uuid(),
  user_id uuid references public.user_profiles(id),
  category_id uuid references public.categories(id),
  month int check (month between 1 and 12),
  year int,
  limit_amount numeric(12,2) not null,
  unique(user_id, category_id, month, year)
);

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
  created_at timestamptz default now()
);

alter table public.user_profiles enable row level security;
alter table public.categories enable row level security;
alter table public.transactions enable row level security;
alter table public.recurring_expenses enable row level security;
alter table public.budgets enable row level security;
alter table public.user_rules enable row level security;

drop policy if exists "Users access own profile" on public.user_profiles;
create policy "Users access own profile"
  on public.user_profiles
  for all
  using (auth.uid() = id)
  with check (auth.uid() = id);

drop policy if exists "Users access own categories" on public.categories;
create policy "Users access own categories"
  on public.categories
  for all
  using (auth.uid() = user_id)
  with check (auth.uid() = user_id);

drop policy if exists "Users access own transactions" on public.transactions;
create policy "Users access own transactions"
  on public.transactions
  for all
  using (auth.uid() = user_id)
  with check (auth.uid() = user_id);

drop policy if exists "Users access own recurring" on public.recurring_expenses;
create policy "Users access own recurring"
  on public.recurring_expenses
  for all
  using (auth.uid() = user_id)
  with check (auth.uid() = user_id);

drop policy if exists "Users access own budgets" on public.budgets;
create policy "Users access own budgets"
  on public.budgets
  for all
  using (auth.uid() = user_id)
  with check (auth.uid() = user_id);

drop policy if exists "Users access own rules" on public.user_rules;
create policy "Users access own rules"
  on public.user_rules
  for all
  using (auth.uid() = user_id)
  with check (auth.uid() = user_id);
