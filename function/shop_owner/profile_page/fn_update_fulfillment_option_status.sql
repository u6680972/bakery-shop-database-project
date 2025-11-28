create function fn_update_fulfillment_option_status(p_shop_id integer, p_type text, p_is_active boolean) returns boolean
    language plpgsql
as
$$
BEGIN
    UPDATE fulfillment_option
    SET is_active = p_is_active
    WHERE shop_id = p_shop_id AND type = p_type;

    IF NOT FOUND THEN
        INSERT INTO fulfillment_option (shop_id, type, is_active)
        VALUES (p_shop_id, p_type, p_is_active);
    END IF;

    RETURN TRUE;
END;
$$;

alter function fn_update_fulfillment_option_status(integer, text, boolean) owner to root;


