-- Synthetic demo data only.
INSERT INTO app_users (id, email, display_name) VALUES
('11111111-1111-4111-8111-111111111111', 'amina.demo@example.test', 'Amina Demo'),
('22222222-2222-4222-8222-222222222222', 'brian.demo@example.test', 'Brian Demo');

INSERT INTO budgets (id, user_id, name, monthly_limit, currency, starts_on) VALUES
('aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa', '11111111-1111-4111-8111-111111111111', 'October Budget', 25000.00, 'KES', DATE '2026-10-01'),
('bbbbbbbb-bbbb-4bbb-8bbb-bbbbbbbbbbbb', '22222222-2222-4222-8222-222222222222', 'October Budget', 18000.00, 'KES', DATE '2026-10-01');

INSERT INTO categories (id, user_id, name, kind) VALUES
('cccccccc-cccc-4ccc-8ccc-cccccccccccc', '11111111-1111-4111-8111-111111111111', 'Food', 'expense'),
('dddddddd-dddd-4ddd-8ddd-dddddddddddd', '11111111-1111-4111-8111-111111111111', 'Transport', 'expense'),
('eeeeeeee-eeee-4eee-8eee-eeeeeeeeeeee', '22222222-2222-4222-8222-222222222222', 'Food', 'expense');

INSERT INTO transactions (user_id, budget_id, category_id, kind, amount, description, occurred_on) VALUES
('11111111-1111-4111-8111-111111111111', 'aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa', 'cccccccc-cccc-4ccc-8ccc-cccccccccccc', 'expense', 850.00, 'Groceries', DATE '2026-10-02'),
('11111111-1111-4111-8111-111111111111', 'aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa', 'dddddddd-dddd-4ddd-8ddd-dddddddddddd', 'expense', 220.00, 'Bus fare', DATE '2026-10-03'),
('22222222-2222-4222-8222-222222222222', 'bbbbbbbb-bbbb-4bbb-8bbb-bbbbbbbbbbbb', 'eeeeeeee-eeee-4eee-8eee-eeeeeeeeeeee', 'expense', 600.00, 'Groceries', DATE '2026-10-04');
