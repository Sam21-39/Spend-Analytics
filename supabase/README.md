# Supabase SQL Setup

This folder contains idempotent SQL scripts for bootstrapping Spend Analytics on Supabase.

## Script order

1. `00_extensions.sql`
2. `01_schema.sql`
3. `02_indexes.sql`
4. `03_triggers.sql`
5. `04_rls.sql`
6. `05_grants.sql`
7. `06_crons.sql`

## Run all scripts

```bash
./supabase/scripts/run_all_sql.sh linked
```

Targets:

- `linked` (default): uses your linked Supabase project
- `local`: runs against `supabase start` local Postgres
- `db-url`: uses `SUPABASE_DB_URL`

Example with DB URL:

```bash
SUPABASE_DB_URL='postgresql://...' ./supabase/scripts/run_all_sql.sh db-url
```

## Notes

- Scripts are safe to re-run (`if not exists`, policy drops before create, cron reschedule).
- Cron jobs require `pg_cron`.
- Tables use RLS with per-user isolation via `auth.uid()`.
