create function fn_get_available_plans(p_shop_id integer)
    returns TABLE(plan_id integer, name text, price numeric, description text, features text[], is_popular boolean, is_current_plan boolean)
    language plpgsql
as
$$
DECLARE
    v_current_plan_id INTEGER;
BEGIN
    -- Get the shop's current plan ID
    SELECT c.plan_id INTO v_current_plan_id
    FROM client c
    WHERE c.shop_id = p_shop_id;

    RETURN QUERY
        SELECT
            p.plan_id,
            p.name::TEXT,
            p.price_monthly AS price,      -- Alias to match return table 'price'
            p.description::TEXT,
            p.features,
            p.is_popular,
            -- Safe boolean comparison
            COALESCE(p.plan_id = v_current_plan_id, FALSE) AS is_current_plan
        FROM
            platform_plans p
        ORDER BY
            p.price_monthly ASC;
END;
$$;

alter function fn_get_available_plans(integer) owner to root;


