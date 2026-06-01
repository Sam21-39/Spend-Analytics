-- Performance indexes

create index if not exists categories_user_id_idx
  on public.categories(user_id);

create index if not exists transactions_user_date_idx
  on public.transactions(user_id, transaction_date desc);

create index if not exists transactions_user_updated_at_idx
  on public.transactions(user_id, updated_at desc);

create index if not exists transactions_user_category_name_idx
  on public.transactions(user_id, category_name);

create index if not exists transactions_user_type_idx
  on public.transactions(user_id, type);

create index if not exists transactions_active_only_idx
  on public.transactions(user_id, transaction_date desc)
  where is_deleted = false;

create index if not exists recurring_expenses_user_active_due_idx
  on public.recurring_expenses(user_id, is_active, next_due_date);

create index if not exists budgets_user_month_year_idx
  on public.budgets(user_id, year, month);

create index if not exists user_rules_user_active_idx
  on public.user_rules(user_id, is_active);

create index if not exists job_run_log_job_name_created_at_idx
  on public.job_run_log(job_name, created_at desc);
