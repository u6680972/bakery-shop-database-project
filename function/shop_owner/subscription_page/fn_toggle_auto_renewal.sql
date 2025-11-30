create function fn_toggle_auto_renewal(p_shop_id integer, p_is_enabled boolean) returns boolean
    language plpgsql
as
$$
BEGIN
    UPDATE client
    SET is_auto_renewal_enabled = p_is_enabled
    WHERE shop_id = p_shop_id;

    RETURN FOUND;
END;
$$;

alter function fn_toggle_auto_renewal(integer, boolean) owner to root;


