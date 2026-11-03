#!/usr/bin/env bash
set -euo pipefail
mkdir -p backups
stamp="$(date +%F_%H%M%S)"
out="backups/capstone_${stamp}.dump"
pg_dump -Fc -f "$out" "${PGDATABASE:-capstone}"
echo "Backup created: $out"
