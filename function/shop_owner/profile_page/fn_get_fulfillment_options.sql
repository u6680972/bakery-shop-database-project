create function fn_get_fulfillment_options(p_shop_id integer)
    returns TABLE(option_type text, is_active boolean)
    language plpgsql
as
$$
DECLARE
BEGIN
    RETURN QUERY
        SELECT
            fo.type AS option_type,
            fo.is_active
        FROM
            fulfillment_option fo
        WHERE
            fo.shop_id = p_shop_id
        ORDER BY
            fo.type;
END;
$$;

alter function fn_get_fulfillment_options(integer) owner to root;

