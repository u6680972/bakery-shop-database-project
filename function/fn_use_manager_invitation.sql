create function fn_use_manager_invitation(p_invitation_code text, p_username text, p_email text, p_password text, p_first_name text, p_last_name text) returns integer
    language plpgsql
as
$$
DECLARE
    v_new_user_id INT;
    v_invite_record shop_invitation;
BEGIN
    SELECT * INTO v_invite_record
    FROM shop_invitation
    WHERE invitation_code = p_invitation_code
        FOR UPDATE;


    INSERT INTO "user" (username, password_hash, email, first_name, last_name)
    VALUES (p_username, p_password, p_email, p_first_name, p_last_name)
    RETURNING user_id INTO v_new_user_id;

    INSERT INTO shop_manager_access (manager_user_id, shop_id)
    VALUES (v_new_user_id, v_invite_record.shop_id);

    UPDATE shop_invitation
    SET used_by_user_id = v_new_user_id
    WHERE invitation_code = p_invitation_code;

    RETURN v_new_user_id;

EXCEPTION
    WHEN unique_violation THEN
        RAISE EXCEPTION 'Registration failed: Username or email already in use.';
END;
$$;

alter function fn_use_manager_invitation(text, text, text, text, text, text) owner to root;

