ALTER TABLE budgets ENABLE ROW LEVEL SECURITY;
ALTER TABLE categories ENABLE ROW LEVEL SECURITY;
ALTER TABLE transactions ENABLE ROW LEVEL SECURITY;

CREATE POLICY budgets_tenant_policy ON budgets
USING (user_id = NULLIF(current_setting('app.user_id', true), '')::uuid)
WITH CHECK (user_id = NULLIF(current_setting('app.user_id', true), '')::uuid);

CREATE POLICY categories_tenant_policy ON categories
USING (user_id = NULLIF(current_setting('app.user_id', true), '')::uuid)
WITH CHECK (user_id = NULLIF(current_setting('app.user_id', true), '')::uuid);

CREATE POLICY transactions_tenant_policy ON transactions
USING (user_id = NULLIF(current_setting('app.user_id', true), '')::uuid)
WITH CHECK (user_id = NULLIF(current_setting('app.user_id', true), '')::uuid);

ALTER TABLE budgets FORCE ROW LEVEL SECURITY;
ALTER TABLE categories FORCE ROW LEVEL SECURITY;
ALTER TABLE transactions FORCE ROW LEVEL SECURITY;
