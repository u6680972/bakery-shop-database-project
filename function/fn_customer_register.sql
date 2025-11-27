create function fn_customer_register(
    p_shop_identifier text,
    p_email text,
    p_password text,
    p_first_name text,
    p_last_name text)

    returns integer
    language plpgsql
as
$$
DECLARE
    v_shop_id INT;
    v_new_user_id INT;
    v_new_customer_id INT;
BEGIN
    SELECT shop_id INTO v_shop_id
    FROM client
    WHERE shop_name = p_shop_identifier
    LIMIT 1;

    INSERT INTO "user" (username, password_hash, email, first_name, last_name)
    VALUES (p_email, p_password, p_email, p_first_name, p_last_name)
    RETURNING user_id INTO v_new_user_id;

    INSERT INTO shop_customer (shop_id, first_name, last_name, email, password_hash)
    VALUES (v_shop_id, p_first_name, p_last_name, p_email, p_password)
    RETURNING customer_id INTO v_new_customer_id;

    RETURN v_new_customer_id;

EXCEPTION
    WHEN unique_violation THEN
        RAISE EXCEPTION 'Registration failed: An account with this email already exists for shop %.', p_shop_identifier;
END;
$$;

alter function fn_customer_register(text, text, text, text, text) owner to root;