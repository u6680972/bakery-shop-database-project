create function fn_update_customer_profile(p_customer_id integer, p_first_name text, p_last_name text, p_email text, p_phone_number text, p_street_address text, p_city text, p_zip_code text) returns boolean
    language plpgsql
as
$$
BEGIN
    UPDATE customer_user
    SET
        first_name = p_first_name,
        last_name = p_last_name,
        email = p_email,
        phone_number = p_phone_number,
        address = p_street_address,
        city = p_city,
        zip_code = p_zip_code
    WHERE
        customer_id = p_customer_id;

    RETURN FOUND;
END;
$$;

alter function fn_update_customer_profile(integer, text, text, text, text, text, text, text) owner to root;


