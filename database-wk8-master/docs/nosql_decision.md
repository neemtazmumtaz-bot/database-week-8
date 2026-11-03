# NoSQL Decision — Redis Dashboard Cache

Redis is used only as an optional cache for frequently requested dashboard summaries. PostgreSQL remains the source of truth for users, budgets, categories, transactions, constraints, and audit history.

Redis is suitable for derived values that are repeatedly requested and can be regenerated: it provides fast key-value reads and TTL expiry. Transactions should not live only in Redis because they need durable relational integrity, joins, tenant policies, and auditability.

Suggested cache key: `spendwise:dashboard:<user_uuid>:<yyyy-mm>`. Cache TTL: 60–300 seconds. On a miss, query PostgreSQL; after a transaction commits, invalidate the affected key. Measure cache hit and miss latency under a repeatable workload before making performance claims. Keep Redis private and configure authentication/TLS for deployment.
