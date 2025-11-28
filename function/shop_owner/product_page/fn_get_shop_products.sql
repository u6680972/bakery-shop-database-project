create function fn_get_shop_products(p_shop_id integer, p_category_filter text DEFAULT 'All'::text, p_search_query text DEFAULT ''::text)
    returns TABLE(product_id integer, name text, description text, price numeric, category text, stock_quantity integer, is_active boolean, image_url text)
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
            p.stock_quantity,
            p.is_active,
            p.image_url
        FROM
            product p
        WHERE
            p.shop_id = p_shop_id
          -- Filter by Category (if not 'All')
          AND (p_category_filter = 'All' OR p.category = p_category_filter)
          -- Filter by Search (Product Name)
          AND (
            p_search_query = ''
                OR p.name ILIKE '%' || p_search_query || '%'
            )
        ORDER BY
            p.name ASC;
END;
$$;

alter function fn_get_shop_products(integer, text, text) owner to root;


