create function fn_get_shop_profile_info(p_shop_id integer)
    returns TABLE(shop_name text, email text, phone_number text, employee_count integer)
    language plpgsql
as
$$
DECLARE
    v_shop_name TEXT;
    v_email TEXT;
    v_phone_number TEXT;
    v_employee_count INT;
BEGIN
    SELECT
        c.shop_name,
        c.email,
        c.phone_number
    INTO
        v_shop_name,
        v_email,
        v_phone_number
    FROM
        client c
    WHERE
        c.shop_id = p_shop_id;

    SELECT
        COUNT(DISTINCT sma.manager_user_id)
    INTO
        v_employee_count
    FROM
        shop_manager_access sma
    WHERE
        sma.shop_id = p_shop_id;

    RETURN QUERY
        SELECT
            v_shop_name::TEXT,
            v_email::TEXT,
            v_phone_number::TEXT,
            v_employee_count::INT;
END;
$$;

alter function fn_get_shop_profile_info(integer) owner to root;

