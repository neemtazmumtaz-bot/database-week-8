# SpendWise Database Capstone — Walkthrough

## Slide 1 — Problem
SpendWise tracks income, expenses, categories, and monthly budgets. It must isolate each user's financial records.

## Slide 2 — ER model
Entities: App Users, Budgets, Categories, Transactions, Audit Log. One user can own many budgets, create categories, record transactions, and generate audit events. Each transaction belongs to one user and may reference a budget and category.

## Slide 3 — Migrations
Flyway migrations separate core tables, indexes, audit triggers, RLS, and demo data. Test clean/migrate only on a disposable development database.

## Slide 4 — NoSQL
PostgreSQL is authoritative. Redis is an optional TTL cache for derived dashboard summaries; cache misses query PostgreSQL.

## Slide 5 — Optimization
The composite index matches user, kind, and date filters. Insert actual before/after `EXPLAIN (ANALYZE, BUFFERS)` plans and measured results here—do not invent performance numbers.

## Slide 6 — Security and recovery
RLS uses trusted server-set tenant context. A trigger audits transaction changes. The app role must be non-owner, non-superuser, and without BYPASSRLS. Demonstrate a compressed pg_dump backup and a restore into a separate test database.

## Slide 7 — Demo and next steps
Show migrations, a tenant-scoped query, an audit event, query plans, the Redis cache contract, and restore verification. Production hardening includes role separation, audit-write restrictions, secrets management, and workload testing.
