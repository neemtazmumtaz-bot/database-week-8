# Security Checklist

- [ ] Least-privilege application role tested; not a superuser and not a table owner.
- [x] RLS enabled and forced on tenant-owned budgets, categories, and transactions.
- [ ] Test RLS as the real app role with two tenant IDs.
- [ ] Authentication/password hashing implemented in the application identity layer; this SQL schema intentionally stores no passwords.
- [x] Audit trigger records INSERT, UPDATE, DELETE on transactions.
- [ ] Restrict audit table writes/deletes to a controlled owner/function and audit readers.
- [ ] Application SQL uses bound parameters only; no string concatenation.
- [ ] Backup created and restore test completed.
- [ ] Secrets kept out of Git.
- [ ] Redis is private, authenticated, and used only as cache.

The application must set `app.user_id` from a trusted authenticated identity using `SET LOCAL` inside each transaction. A custom PostgreSQL setting is not an authentication system by itself. Do not give untrusted clients direct database credentials. Superusers and roles with BYPASSRLS can bypass RLS.
