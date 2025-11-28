create function fn_get_shop_profile_info(p_shop_id integer)
    returns TABLE(shop_name text, email text, phone_number text, shop_address text, employee_count bigint)
    language plpgsql
as
$$
DECLARE
    v_employee_count BIGINT;
BEGIN
    SELECT COUNT(DISTINCT sma.manager_user_id) INTO v_employee_count
    FROM shop_manager_access sma
    WHERE sma.shop_id = p_shop_id;

    RETURN QUERY
        SELECT
            c.shop_name::TEXT,
            c.email::TEXT,
            c.phone_number::TEXT,
            c.address::TEXT AS shop_address,
            v_employee_count
        FROM
            client c
        WHERE
            c.shop_id = p_shop_id;
END;
$$;

alter function fn_get_shop_profile_info(integer) owner to root;

