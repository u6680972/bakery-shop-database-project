create function fn_update_subscription_plan(p_shop_id integer, p_new_plan_id integer) returns boolean
    language plpgsql
as
$$
DECLARE
    v_new_price DECIMAL(10,2);
BEGIN
    -- Get current market price of the new plan
    SELECT price_monthly INTO v_new_price
    FROM platform_plans
    WHERE plan_id = p_new_plan_id;

    -- If Plan ID doesn't exist, return false
    IF NOT FOUND THEN
        RETURN FALSE;
    END IF;

    -- Update client with new plan ID and the NEW price
    UPDATE client
    SET
        plan_id = p_new_plan_id,
        plan_price = v_new_price
    WHERE
        shop_id = p_shop_id;

    RETURN FOUND;
END;
$$;

alter function fn_update_subscription_plan(integer, integer) owner to root;


