# SpendWise Database Capstone

A PostgreSQL-first capstone for a multi-tenant personal budget and expense tracker. Includes requirements, ER diagram source, ordered Flyway migrations, Redis cache rationale, query optimization evidence template, backup/restore scripts, security checklist, and a short walkthrough presentation.

## Files
- `docs/requirements.md` — requirements and acceptance criteria.
- `docs/er_diagram.mmd` — Mermaid ER diagram source.
- `migrations/` — five ordered PostgreSQL Flyway migrations.
- `docs/nosql_decision.md` — Redis design rationale.
- `queries/` — analytical SQL and optimization evidence template.
- `scripts/` — backup, restore-test, and application-role scripts.
- `docs/security_checklist.md` — security checks.
- `presentation/walkthrough.md` — short presentation outline.
- `docker-compose.yml` — local PostgreSQL and Redis.
- `flyway.conf.example` — example Flyway settings.

## Run locally
Requires Docker Desktop / Docker Compose and Flyway installed.
1. Copy `flyway.conf.example` to `flyway.conf`.
2. Run `docker compose up -d`.
3. Run `flyway -configFiles=flyway.conf migrate`.
4. Connect with `docker compose exec postgres psql -U capstone_admin -d capstone`.

`flyway clean` is destructive. Only run it against a disposable development database. To test a clean migration, use `flyway -configFiles=flyway.conf clean` and then `flyway -configFiles=flyway.conf migrate` only when you have intentionally enabled clean and confirmed the target database is disposable.

## Evidence note
Files are prepared as a starter project, but you must run them in your environment and capture real EXPLAIN ANALYZE output, create a real backup, and test restoring it before claiming those steps passed. Performance numbers are not fabricated.
