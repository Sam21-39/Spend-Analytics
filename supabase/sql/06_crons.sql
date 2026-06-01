-- Cron jobs (pg_cron)

create or replace function public.spendsense_cleanup_soft_deleted()
returns void
language plpgsql
security definer
set search_path = public
as $$
declare
  deleted_count integer;
begin
  delete from public.transactions
  where is_deleted = true
    and updated_at < now() - interval '90 days';

  get diagnostics deleted_count = row_count;

  insert into public.job_run_log(job_name, status, details)
  values (
    'spendsense-clean-soft-deleted',
    'ok',
    jsonb_build_object('deleted_rows', deleted_count)
  );
end;
$$;

revoke all on function public.spendsense_cleanup_soft_deleted() from public, anon, authenticated;
grant execute on function public.spendsense_cleanup_soft_deleted() to service_role;

create or replace function public.spendsense_roll_recurring_due_dates()
returns void
language plpgsql
security definer
set search_path = public
as $$
declare
  updated_count integer;
begin
  update public.recurring_expenses
  set next_due_date = case frequency
    when 'daily' then greatest(current_date, coalesce(next_due_date, current_date)) + interval '1 day'
    when 'weekly' then greatest(current_date, coalesce(next_due_date, current_date)) + interval '7 day'
    when 'monthly' then greatest(current_date, coalesce(next_due_date, current_date)) + interval '1 month'
    when 'yearly' then greatest(current_date, coalesce(next_due_date, current_date)) + interval '1 year'
    else next_due_date
  end
  where is_active = true
    and next_due_date is not null
    and next_due_date < current_date;

  get diagnostics updated_count = row_count;

  insert into public.job_run_log(job_name, status, details)
  values (
    'spendsense-roll-recurring-due-dates',
    'ok',
    jsonb_build_object('updated_rows', updated_count)
  );
end;
$$;

revoke all on function public.spendsense_roll_recurring_due_dates() from public, anon, authenticated;
grant execute on function public.spendsense_roll_recurring_due_dates() to service_role;

do $cron$
begin
  if exists (select 1 from cron.job where jobname = 'spendsense-clean-soft-deleted') then
    perform cron.unschedule('spendsense-clean-soft-deleted');
  end if;

  if exists (select 1 from cron.job where jobname = 'spendsense-roll-recurring-due-dates') then
    perform cron.unschedule('spendsense-roll-recurring-due-dates');
  end if;

  perform cron.schedule(
    'spendsense-clean-soft-deleted',
    '30 2 * * *',
    $cmd$select public.spendsense_cleanup_soft_deleted();$cmd$
  );

  perform cron.schedule(
    'spendsense-roll-recurring-due-dates',
    '0 6 * * *',
    $cmd$select public.spendsense_roll_recurring_due_dates();$cmd$
  );
end $cron$;
