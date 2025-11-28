create function fn_get_low_stock_alerts(p_shop_id integer)
    returns TABLE(product_name text, stock_remaining integer, unit_type text)
    language plpgsql
as
$$
BEGIN
    RETURN QUERY
        SELECT
            p.name,
            p.stock_quantity,
            p.unit_type
        FROM
            product p
        WHERE
            p.shop_id = p_shop_id
          AND p.is_active = TRUE
          AND p.stock_quantity <= p.min_stock_level
        ORDER BY
            p.stock_quantity ASC;
END;
$$;

alter function fn_get_low_stock_alerts(integer) owner to root;


