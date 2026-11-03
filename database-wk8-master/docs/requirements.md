# Requirements Summary — SpendWise Database Capstone

## Purpose
SpendWise lets users record income and expenses, organize transactions into categories, set monthly budgets, and review spending trends. It must support multiple users while ensuring each user can access only their own financial records.

## Users and workflows
- A user owns one or more budgets.
- A user creates categories and records income or expenses.
- A user can assign a transaction to an optional category and a budget.
- A user views monthly totals by category and compares spending against budget limits.
- Authorized audit personnel can review a restricted audit trail; ordinary users must not modify audit records.

## Functional requirements
1. Store users, budgets, categories, transactions, and audit events with stable primary keys.
2. Enforce foreign-key integrity and validation (positive amount, supported transaction type, timestamps).
3. Support monthly spending and category-total reports.
4. Record INSERT, UPDATE, and DELETE activity on financial transactions.
5. Use PostgreSQL row-level security (RLS) so sessions can access only rows for the current application user.
6. Apply schema changes through ordered Flyway migrations.
7. Use Redis as an optional cache for frequently requested dashboard summaries; PostgreSQL remains authoritative.
8. Provide repeatable backup and restore-test procedures.

## Non-functional requirements
Security: least privilege, no app superuser, RLS, parameterized queries, restricted audit data. Reliability: constraints, migration history, and backups. Performance: indexes for tenant/date filters and query-plan evidence. Maintainability: versioned SQL and operational notes.

## Assumptions and acceptance criteria
PostgreSQL 15+ is the source of truth. Trusted server-side application code authenticates users and sets `app.user_id` per database transaction. Demo rows are synthetic. Authentication, password hashing, secrets management, and deployment hardening must be implemented outside this SQL starter.

Acceptance: migrations apply in order to an empty development database; RLS and triggers work; query plans are captured before and after the index; backup and restore test are completed and documented.
