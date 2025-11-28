create function fn_register_staff_user(p_invitation_code text, p_username text, p_email text, p_password text, p_first_name text, p_last_name text, p_phone_number text) returns integer
    language plpgsql
as
$$
DECLARE
    v_new_user_id INT;
    v_shop_id INT;
BEGIN
    -- 1. Verify Invitation Code
    SELECT shop_id INTO v_shop_id
    FROM shop_invitation
    WHERE invitation_code = p_invitation_code
      AND used_by_user_id IS NULL
        FOR UPDATE;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Invalid or already used invitation code.';
    END IF;

    -- 2. Create the User (Password is now ENCRYPTED)
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
               crypt(p_password, gen_salt('bf')), -- <--- ENCRYPTION HERE
               p_email,
               p_first_name,
               p_last_name,
               p_phone_number
           )
    RETURNING user_id INTO v_new_user_id;

    -- 3. Grant Access
    INSERT INTO shop_manager_access (manager_user_id, shop_id)
    VALUES (v_new_user_id, v_shop_id);

    -- 4. Mark Invitation Used
    UPDATE shop_invitation
    SET used_by_user_id = v_new_user_id
    WHERE invitation_code = p_invitation_code;

    RETURN v_new_user_id;

EXCEPTION
    WHEN unique_violation THEN
        RAISE EXCEPTION 'Registration failed: Username or email already in use.';
END;
$$;

alter function fn_register_staff_user(text, text, text, text, text, text, text) owner to root;


