create function fn_update_shop_profile_info(p_shop_id integer, p_shop_name text, p_email text, p_phone_number text, p_shop_address text) returns boolean
    language plpgsql
as
$$
BEGIN
    UPDATE client
    SET
        shop_name = p_shop_name,
        email = p_email,
        phone_number = p_phone_number,
        address = p_shop_address
    WHERE
        shop_id = p_shop_id;

    RETURN FOUND;
END;
$$;

alter function fn_update_shop_profile_info(integer, text, text, text, text) owner to root;

