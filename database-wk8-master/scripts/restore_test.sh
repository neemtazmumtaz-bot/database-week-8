#!/usr/bin/env bash
set -euo pipefail
if [[ $# -ne 1 ]]; then
  echo "Usage: $0 path/to/backup.dump" >&2
  exit 2
fi
dump_file="$1"
test_db="${PGRESTORE_TEST_DB:-capstone_restore_test}"
[[ -f "$dump_file" ]] || { echo "Backup not found: $dump_file" >&2; exit 2; }
# Destructive only to the named test database, never point this at production.
dropdb --if-exists "$test_db"
createdb "$test_db"
pg_restore --no-owner --dbname="$test_db" "$dump_file"
psql --dbname="$test_db" -v ON_ERROR_STOP=1 -c '\dt'
echo "Restore test completed: $test_db"
