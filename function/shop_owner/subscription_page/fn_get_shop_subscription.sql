create function fn_get_shop_subscription(p_shop_id integer)
    returns TABLE(plan_name text, plan_price numeric, billing_cycle text, next_billing_date date, is_auto_renewal boolean, status text, expiry_date date, days_remaining integer)
    language plpgsql
as
$$
BEGIN
    RETURN QUERY
        SELECT
            p.name::TEXT AS plan_name,     -- Alias explicitly to match return table
            c.plan_price,
            c.billing_cycle::TEXT,
            c.next_billing_date,
            c.is_auto_renewal_enabled,
            c.subscription_status::TEXT,
            c.next_billing_date AS expiry_date,
            (c.next_billing_date - CURRENT_DATE)::INT AS days_remaining
        FROM
            client c
                LEFT JOIN
            platform_plans p ON c.plan_id = p.plan_id
        WHERE
            c.shop_id = p_shop_id;
END;
$$;

alter function fn_get_shop_subscription(integer) owner to root;


