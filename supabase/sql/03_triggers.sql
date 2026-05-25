-- Updated-at triggers

create or replace function public.set_updated_at()
returns trigger
language plpgsql
as $$
begin
  new.updated_at = now();
  return new;
end;
$$;

drop trigger if exists set_updated_at_user_profiles on public.user_profiles;
create trigger set_updated_at_user_profiles
before update on public.user_profiles
for each row execute function public.set_updated_at();

drop trigger if exists set_updated_at_categories on public.categories;
create trigger set_updated_at_categories
before update on public.categories
for each row execute function public.set_updated_at();

drop trigger if exists set_updated_at_transactions on public.transactions;
create trigger set_updated_at_transactions
before update on public.transactions
for each row execute function public.set_updated_at();

drop trigger if exists set_updated_at_recurring_expenses on public.recurring_expenses;
create trigger set_updated_at_recurring_expenses
before update on public.recurring_expenses
for each row execute function public.set_updated_at();

drop trigger if exists set_updated_at_budgets on public.budgets;
create trigger set_updated_at_budgets
before update on public.budgets
for each row execute function public.set_updated_at();

drop trigger if exists set_updated_at_user_rules on public.user_rules;
create trigger set_updated_at_user_rules
before update on public.user_rules
for each row execute function public.set_updated_at();
