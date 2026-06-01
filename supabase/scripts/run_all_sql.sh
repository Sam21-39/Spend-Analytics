#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
SQL_DIR="$ROOT_DIR/supabase/sql"

TARGET="${1:-linked}"

SQL_FILES=(
  "00_extensions.sql"
  "01_schema.sql"
  "02_indexes.sql"
  "03_triggers.sql"
  "04_rls.sql"
  "05_grants.sql"
  "06_crons.sql"
)

run_sql() {
  local file_path="$1"

  case "$TARGET" in
    linked)
      supabase db query --linked --file "$file_path" --workdir "$ROOT_DIR"
      ;;
    local)
      supabase db query --local --file "$file_path" --workdir "$ROOT_DIR"
      ;;
    db-url)
      if [[ -z "${SUPABASE_DB_URL:-}" ]]; then
        echo "SUPABASE_DB_URL is required when TARGET=db-url"
        exit 1
      fi
      supabase db query --db-url "$SUPABASE_DB_URL" --file "$file_path" --workdir "$ROOT_DIR"
      ;;
    *)
      echo "Invalid target: $TARGET"
      echo "Usage: $0 [linked|local|db-url]"
      exit 1
      ;;
  esac
}

for sql_file in "${SQL_FILES[@]}"; do
  full_path="$SQL_DIR/$sql_file"
  if [[ ! -f "$full_path" ]]; then
    echo "Missing SQL file: $full_path"
    exit 1
  fi

  echo "==> Running $sql_file"
  run_sql "$full_path"
  echo "==> Done: $sql_file"
  echo
done

echo "All Supabase SQL scripts applied successfully."
