-- Row Level Security

alter table public.user_profiles enable row level security;
alter table public.categories enable row level security;
alter table public.transactions enable row level security;
alter table public.recurring_expenses enable row level security;
alter table public.budgets enable row level security;
alter table public.user_rules enable row level security;
alter table public.job_run_log enable row level security;

drop policy if exists "Users access own profile" on public.user_profiles;
create policy "Users access own profile"
on public.user_profiles
for all
to authenticated
using ((select auth.uid()) = id)
with check ((select auth.uid()) = id);

drop policy if exists "Users access own categories" on public.categories;
create policy "Users access own categories"
on public.categories
for all
to authenticated
using ((select auth.uid()) = user_id)
with check ((select auth.uid()) = user_id);

drop policy if exists "Users access own transactions" on public.transactions;
create policy "Users access own transactions"
on public.transactions
for all
to authenticated
using ((select auth.uid()) = user_id)
with check ((select auth.uid()) = user_id);

drop policy if exists "Users access own recurring" on public.recurring_expenses;
create policy "Users access own recurring"
on public.recurring_expenses
for all
to authenticated
using ((select auth.uid()) = user_id)
with check ((select auth.uid()) = user_id);

drop policy if exists "Users access own budgets" on public.budgets;
create policy "Users access own budgets"
on public.budgets
for all
to authenticated
using ((select auth.uid()) = user_id)
with check ((select auth.uid()) = user_id);

drop policy if exists "Users access own rules" on public.user_rules;
create policy "Users access own rules"
on public.user_rules
for all
to authenticated
using ((select auth.uid()) = user_id)
with check ((select auth.uid()) = user_id);

-- Cron/system logs should not be client-readable.
drop policy if exists "No direct access to job_run_log" on public.job_run_log;
create policy "No direct access to job_run_log"
on public.job_run_log
for all
to authenticated
using (false)
with check (false);
