CREATE EXTENSION IF NOT EXISTS pgcrypto;

CREATE TABLE app_users (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    email varchar(254) NOT NULL UNIQUE,
    display_name varchar(100) NOT NULL,
    created_at timestamptz NOT NULL DEFAULT now()
);

CREATE TABLE budgets (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id uuid NOT NULL REFERENCES app_users(id) ON DELETE CASCADE,
    name varchar(100) NOT NULL,
    monthly_limit numeric(12,2) NOT NULL CHECK (monthly_limit >= 0),
    currency char(3) NOT NULL DEFAULT 'KES',
    starts_on date NOT NULL,
    ends_on date,
    created_at timestamptz NOT NULL DEFAULT now(),
    CHECK (ends_on IS NULL OR ends_on >= starts_on),
    UNIQUE (id, user_id)
);

CREATE TABLE categories (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id uuid NOT NULL REFERENCES app_users(id) ON DELETE CASCADE,
    name varchar(80) NOT NULL,
    kind varchar(10) NOT NULL CHECK (kind IN ('income', 'expense')),
    created_at timestamptz NOT NULL DEFAULT now(),
    UNIQUE (user_id, name, kind),
    UNIQUE (id, user_id)
);

CREATE TABLE transactions (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id uuid NOT NULL REFERENCES app_users(id) ON DELETE CASCADE,
    budget_id uuid,
    category_id uuid,
    kind varchar(10) NOT NULL CHECK (kind IN ('income', 'expense')),
    amount numeric(12,2) NOT NULL CHECK (amount > 0),
    description varchar(500) NOT NULL DEFAULT '',
    occurred_on date NOT NULL DEFAULT CURRENT_DATE,
    created_at timestamptz NOT NULL DEFAULT now(),
    updated_at timestamptz NOT NULL DEFAULT now(),
    FOREIGN KEY (budget_id, user_id) REFERENCES budgets(id, user_id) ON DELETE SET NULL (budget_id),
    FOREIGN KEY (category_id, user_id) REFERENCES categories(id, user_id) ON DELETE SET NULL (category_id)
);

CREATE TABLE audit_log (
    id bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    actor_user_id uuid REFERENCES app_users(id) ON DELETE SET NULL,
    table_name text NOT NULL,
    operation text NOT NULL CHECK (operation IN ('INSERT', 'UPDATE', 'DELETE')),
    row_id uuid NOT NULL,
    old_data jsonb,
    new_data jsonb,
    changed_at timestamptz NOT NULL DEFAULT now()
);
