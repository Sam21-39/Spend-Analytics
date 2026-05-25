-- Explicit Data API grants (recommended with 2026 defaults)

grant usage on schema public to authenticated, service_role;

grant select, insert, update, delete on table public.user_profiles to authenticated, service_role;
grant select, insert, update, delete on table public.categories to authenticated, service_role;
grant select, insert, update, delete on table public.transactions to authenticated, service_role;
grant select, insert, update, delete on table public.recurring_expenses to authenticated, service_role;
grant select, insert, update, delete on table public.budgets to authenticated, service_role;
grant select, insert, update, delete on table public.user_rules to authenticated, service_role;

grant select on table public.job_run_log to service_role;
grant insert on table public.job_run_log to service_role;

alter default privileges for role postgres in schema public
  grant select, insert, update, delete on tables to authenticated, service_role;
