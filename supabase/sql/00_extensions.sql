-- Core extensions
create extension if not exists pgcrypto;
create extension if not exists pg_cron;

-- Optional for HTTP-based cron -> edge function patterns
create extension if not exists pg_net;
