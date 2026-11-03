BEGIN;
SET LOCAL app.user_id = '11111111-1111-4111-8111-111111111111';

SELECT date_trunc('month', t.occurred_on)::date AS month,
       c.name AS category,
       SUM(t.amount) AS total_spent,
       COUNT(*) AS transaction_count
FROM transactions AS t
LEFT JOIN categories AS c ON c.id = t.category_id AND c.user_id = t.user_id
WHERE t.user_id = current_setting('app.user_id')::uuid
  AND t.kind = 'expense'
  AND t.occurred_on >= DATE '2026-10-01'
  AND t.occurred_on < DATE '2026-11-01'
GROUP BY date_trunc('month', t.occurred_on)::date, c.name
ORDER BY total_spent DESC;
COMMIT;
