create function fn_get_inventory_stats(p_shop_id integer)
    returns TABLE(total_items bigint, low_stock_items bigint, total_value numeric)
    language plpgsql
as
$$
BEGIN
    RETURN QUERY
        SELECT
            COUNT(*)::BIGINT AS total_items,
            COUNT(*) FILTER (WHERE stock_quantity <= min_stock_level)::BIGINT AS low_stock_items,
            COALESCE(SUM(stock_quantity * price), 0.00)::DECIMAL(10,2) AS total_value
        FROM
            product
        WHERE
            shop_id = p_shop_id
          AND is_active = TRUE;
END;
$$;

alter function fn_get_inventory_stats(integer) owner to root;


