CREATE OR REPLACE FUNCTION set_transaction_updated_at()
RETURNS trigger LANGUAGE plpgsql AS $$
BEGIN
    NEW.updated_at := now();
    RETURN NEW;
END;
$$;

CREATE TRIGGER trg_transactions_updated_at
BEFORE UPDATE ON transactions
FOR EACH ROW EXECUTE FUNCTION set_transaction_updated_at();

CREATE OR REPLACE FUNCTION audit_transaction_change()
RETURNS trigger LANGUAGE plpgsql AS $$
DECLARE
    v_old jsonb;
    v_new jsonb;
    v_row_id uuid;
    v_actor uuid;
BEGIN
    v_actor := NULLIF(current_setting('app.user_id', true), '')::uuid;
    IF TG_OP = 'INSERT' THEN
        v_new := to_jsonb(NEW);
        v_row_id := NEW.id;
    ELSIF TG_OP = 'UPDATE' THEN
        v_old := to_jsonb(OLD);
        v_new := to_jsonb(NEW);
        v_row_id := NEW.id;
    ELSE
        v_old := to_jsonb(OLD);
        v_row_id := OLD.id;
    END IF;

    INSERT INTO audit_log(actor_user_id, table_name, operation, row_id, old_data, new_data)
    VALUES (v_actor, TG_TABLE_NAME, TG_OP, v_row_id, v_old, v_new);

    IF TG_OP = 'DELETE' THEN RETURN OLD; END IF;
    RETURN NEW;
END;
$$;

CREATE TRIGGER trg_transactions_audit
AFTER INSERT OR UPDATE OR DELETE ON transactions
FOR EACH ROW EXECUTE FUNCTION audit_transaction_change();
