CREATE OR REPLACE FUNCTION fn_customer_register(
    p_shop_identifier text,
    p_email text,
    p_password text,
    p_first_name text,
    p_last_name text,
    p_phone_number text
)
    RETURNS integer
    LANGUAGE plpgsql
AS
$$
DECLARE
    v_shop_id INT;
    v_new_customer_id INT;
BEGIN
    SELECT shop_id INTO v_shop_id
    FROM client
    WHERE shop_name = p_shop_identifier
    LIMIT 1;

    INSERT INTO customer_user (shop_id, first_name, last_name, email, password_hash, phone_number)
    VALUES (v_shop_id, p_first_name, p_last_name, p_email, p_password, p_phone_number)
    RETURNING customer_id INTO v_new_customer_id;

    RETURN v_new_customer_id;

EXCEPTION
    WHEN unique_violation THEN
        RAISE EXCEPTION 'Registration failed: An account with this email or phone number already exists for shop %.', p_shop_identifier;
END;
$$;

ALTER FUNCTION fn_customer_register(text, text, text, text, text, text) OWNER TO root;