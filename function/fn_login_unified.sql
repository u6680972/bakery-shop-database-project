create function fn_customer_register(p_shop_identifier text, p_email text, p_password text, p_first_name text, p_last_name text, p_phone_number text, p_address text DEFAULT NULL::text, p_city text DEFAULT NULL::text, p_zip_code text DEFAULT NULL::text) returns integer
    language plpgsql
as
$$
DECLARE
    v_shop_id INT;
    v_new_customer_id INT;
BEGIN
    -- 1. Get the shop ID based on the identifier
    SELECT shop_id INTO v_shop_id
    FROM client
    WHERE shop_name = p_shop_identifier
    LIMIT 1;

    IF v_shop_id IS NULL THEN
        RAISE EXCEPTION 'Shop not found: %', p_shop_identifier;
    END IF;

    -- 2. Create the customer record (Password is now ENCRYPTED)
    INSERT INTO customer_user (
        shop_id,
        first_name,
        last_name,
        email,
        password_hash,
        phone_number,
        address,
        city,
        zip_code
    )
    VALUES (
               v_shop_id,
               p_first_name,
               p_last_name,
               p_email,
               crypt(p_password, gen_salt('bf')), -- <--- ENCRYPTION HERE
               p_phone_number,
               p_address,
               p_city,
               p_zip_code
           )
    RETURNING customer_id INTO v_new_customer_id;

    RETURN v_new_customer_id;

EXCEPTION
    WHEN unique_violation THEN
        RAISE EXCEPTION 'Registration failed: An account with this email already exists for this shop.';
END;
$$;

alter function fn_customer_register(text, text, text, text, text, text, text, text, text) owner to root;


