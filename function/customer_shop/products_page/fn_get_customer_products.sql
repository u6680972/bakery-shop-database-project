create function fn_get_customer_products(p_shop_id integer, p_category_filter text DEFAULT 'All'::text, p_search_query text DEFAULT ''::text)
    returns TABLE(product_id integer, name text, description text, price numeric, category text, image_url text)
    language plpgsql
as
$$
BEGIN
    RETURN QUERY
        SELECT
            p.product_id,
            p.name,
            p.description,
            p.price,
            p.category,
            p.image_url
        FROM
            product p
        WHERE
            p.shop_id = p_shop_id
          AND p.is_active = TRUE
          AND p.stock_quantity > 0 -- Only show in-stock items
          AND (p_category_filter = 'All' OR p.category = p_category_filter)
          AND (
            p_search_query = ''
                OR p.name ILIKE '%' || p_search_query || '%'
            )
        ORDER BY
            p.category, p.name;
END;
$$;

alter function fn_get_customer_products(integer, text, text) owner to root;


