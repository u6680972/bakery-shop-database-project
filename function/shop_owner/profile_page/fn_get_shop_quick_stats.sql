create function fn_get_shop_quick_stats(p_shop_id integer)
    returns TABLE(total_orders bigint, active_products bigint, team_members bigint)
    language plpgsql
as
$$
DECLARE
    v_total_orders BIGINT;
    v_active_products BIGINT;
    v_team_members BIGINT;
BEGIN
    SELECT COUNT(*) INTO v_total_orders
    FROM "order"
    WHERE shop_id = p_shop_id;

    SELECT COUNT(*) INTO v_active_products
    FROM product
    WHERE shop_id = p_shop_id
      AND is_active = TRUE;

    SELECT COUNT(*) INTO v_team_members
    FROM shop_staff
    WHERE shop_id = p_shop_id
      AND status = 'active';

    RETURN QUERY
        SELECT
            v_total_orders,
            v_active_products,
            v_team_members;
END;
$$;

alter function fn_get_shop_quick_stats(integer) owner to root;


