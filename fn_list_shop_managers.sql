create function fn_list_shop_managers(p_shop_id integer)
    returns TABLE(user_id integer, username character varying, full_name text)
    language plpgsql
as
$$
BEGIN
    RETURN QUERY
        SELECT
            u.user_id,
            u.username,
            (u.first_name || ' ' || u.last_name) AS full_name
        FROM "user" u
                 JOIN shop_manager_access sma ON u.user_id = sma.manager_user_id
        WHERE sma.shop_id = p_shop_id -- CRITICAL: Tenant Isolation
        ORDER BY u.last_name, u.first_name;
END;
$$;

alter function fn_list_shop_managers(integer) owner to root;

