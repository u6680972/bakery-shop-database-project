create function fn_get_shop_orders(p_shop_id integer, p_status_filter text DEFAULT 'All'::text, p_search_query text DEFAULT ''::text)
    returns TABLE(order_id integer, customer_name text, product_summary text, total_amount numeric, deposit_amount numeric, deposit_status text, status text, deadline timestamp with time zone, is_urgent boolean, created_at timestamp with time zone)
    language plpgsql
as
$$
BEGIN
    RETURN QUERY
        SELECT
            o.order_id,
            (cu.first_name || ' ' || cu.last_name)::TEXT AS customer_name,
            COALESCE(
                -- FIXED: Added 'oi' alias and used 'oi.order_id' to be explicit
                    (SELECT string_agg(product_name, ', ') FROM order_item oi WHERE oi.order_id = o.order_id),
                    'No items'
            )::TEXT AS product_summary,
            o.total_amount,
            o.deposit_amount,
            o.deposit_status,
            o.status,
            o.deadline,
            (o.deadline IS NOT NULL AND o.deadline < NOW() + INTERVAL '7 days' AND o.status NOT IN ('Finished', 'Cancelled')) AS is_urgent,
            o.created_at
        FROM
            "order" o
                LEFT JOIN
            customer_user cu ON o.customer_id = cu.customer_id
        WHERE
            o.shop_id = p_shop_id
          AND (
            p_status_filter IN ('All', 'All Orders')
                OR o.status = p_status_filter
            )
          AND (
            p_search_query = ''
                OR o.order_id::TEXT ILIKE '%' || p_search_query || '%'
                OR cu.first_name ILIKE '%' || p_search_query || '%'
                OR cu.last_name ILIKE '%' || p_search_query || '%'
            )
        ORDER BY
            (o.deadline IS NOT NULL AND o.deadline < NOW() + INTERVAL '7 days' AND o.status NOT IN ('Finished', 'Cancelled')) DESC,
            o.deadline ASC,
            o.created_at DESC;
END;
$$;

alter function fn_get_shop_orders(integer, text, text) owner to root;


