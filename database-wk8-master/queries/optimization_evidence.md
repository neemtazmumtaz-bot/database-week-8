# Query Optimization Evidence

**Question:** What expense transactions belong to one user in a given date range?

Use a realistic synthetic dataset (ideally 100,000+ rows across users/dates) and run `ANALYZE transactions;`. Compare the same query and parameters before and after the index.

## Before
On a disposable test database only:
```sql
DROP INDEX IF EXISTS idx_transactions_user_kind_date;
ANALYZE transactions;
EXPLAIN (ANALYZE, BUFFERS, VERBOSE)
SELECT id, occurred_on, amount
FROM transactions
WHERE user_id = '11111111-1111-4111-8111-111111111111'
  AND kind = 'expense'
  AND occurred_on >= DATE '2026-10-01'
  AND occurred_on < DATE '2026-11-01';
```
Paste actual output here. Do not invent timings.

## Change
```sql
CREATE INDEX idx_transactions_user_kind_date
ON transactions(user_id, kind, occurred_on DESC);
ANALYZE transactions;
```
The index matches equality filters on user and kind, followed by a date range. It may reduce scanned rows when filters are selective. PostgreSQL may still choose a sequential scan on small tables or if many rows match.

## After
Run the exact same `EXPLAIN (ANALYZE, BUFFERS, VERBOSE)` query again and paste its actual output here.

## Result (fill with measurements)
- Before execution time: TODO
- After execution time: TODO
- Observed plan change: TODO
- Buffer/row-count comparison: TODO

Do not claim an improvement unless the measured output supports it.
