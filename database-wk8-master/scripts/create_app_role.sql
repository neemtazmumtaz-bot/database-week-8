-- Run as a database administrator; replace secret outside source control.
CREATE ROLE spendwise_app LOGIN PASSWORD 'REPLACE_WITH_SECRET'
  NOSUPERUSER NOCREATEDB NOCREATEROLE NOINHERIT NOBYPASSRLS;
GRANT CONNECT ON DATABASE capstone TO spendwise_app;
GRANT USAGE ON SCHEMA public TO spendwise_app;
GRANT SELECT, INSERT, UPDATE, DELETE ON budgets, categories, transactions TO spendwise_app;
-- Production hardening required: audit trigger inserts should use a carefully
-- designed SECURITY DEFINER function owned by a restricted role. Do not grant
-- the app role UPDATE or DELETE on audit_log.
