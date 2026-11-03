CREATE INDEX idx_budgets_user_id ON budgets(user_id);
CREATE INDEX idx_categories_user_id ON categories(user_id);
CREATE INDEX idx_transactions_user_date ON transactions(user_id, occurred_on DESC);
CREATE INDEX idx_transactions_user_kind_date ON transactions(user_id, kind, occurred_on DESC);
CREATE INDEX idx_transactions_category_id ON transactions(category_id);
CREATE INDEX idx_audit_log_changed_at ON audit_log(changed_at DESC);
