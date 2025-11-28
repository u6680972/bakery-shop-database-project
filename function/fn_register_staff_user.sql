CREATE OR REPLACE FUNCTION fn_register_staff_user(
    p_invitation_code TEXT,
    p_username TEXT,
    p_email TEXT,
    p_password TEXT,
    p_first_name TEXT,
    p_last_name TEXT,
    p_phone_number TEXT
)
    RETURNS INTEGER
    LANGUAGE plpgsql
AS $$
DECLARE
    v_new_user_id INT;
    v_shop_id INT;
BEGIN
    SELECT shop_id INTO v_shop_id
    FROM shop_invitation
    WHERE invitation_code = p_invitation_code
      AND used_by_user_id IS NULL
        FOR UPDATE;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Invalid or already used invitation code.';
    END IF;

    INSERT INTO manager_user (
        username,
        password_hash,
        email,
        first_name,
        last_name,
        phone_number
    )
    VALUES (
       p_username,
       p_password,
       p_email,
       p_first_name,
       p_last_name,
       p_phone_number
   )
    RETURNING user_id INTO v_new_user_id;

    INSERT INTO shop_manager_access (manager_user_id, shop_id)
    VALUES (v_new_user_id, v_shop_id);

    UPDATE shop_invitation
    SET used_by_user_id = v_new_user_id
    WHERE invitation_code = p_invitation_code;

    RETURN v_new_user_id;

EXCEPTION
    WHEN unique_violation THEN
        RAISE EXCEPTION 'Registration failed: Username or email already in use.';
END;
$$;
ALTER FUNCTION fn_register_staff_user(text, text, text, text, text, text, text) OWNER TO root;