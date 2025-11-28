create function fn_get_inventory_list(p_shop_id integer, p_search_query text DEFAULT ''::text)
    returns TABLE(product_id integer, name text, category text, stock_quantity integer, min_stock integer, max_stock integer, unit_type text, stock_value numeric, last_restocked date, status text)
    language plpgsql
as
$$
BEGIN
    RETURN QUERY
        SELECT
            p.product_id,
            p.name,
            p.category,
            p.stock_quantity,
            p.min_stock_level,
            p.max_stock_level,
            p.unit_type,
            (p.stock_quantity * p.price)::DECIMAL(10,2) AS stock_value,
            p.last_restocked_at::DATE,
            p.stock_status -- Uses the generated column we added
        FROM
            product p
        WHERE
            p.shop_id = p_shop_id
          AND p.is_active = TRUE
          AND (
            p_search_query = ''
                OR p.name ILIKE '%' || p_search_query || '%'
                OR p.category ILIKE '%' || p_search_query || '%'
            )
        ORDER BY
            -- Prioritize Low Stock items first
            (p.stock_quantity <= p.min_stock_level) DESC,
            p.name ASC;
END;
$$;

alter function fn_get_inventory_list(integer, text) owner to root;


