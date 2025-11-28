create function fn_get_customer_orders(p_customer_id integer, p_status_filter text DEFAULT 'All'::text, p_search_query text DEFAULT ''::text)
    returns TABLE(order_id integer, product_summary text, status text, total_amount numeric, deposit_amount numeric, deposit_status text, deadline timestamp with time zone, created_at timestamp with time zone, is_ready boolean)
    language plpgsql
as
$$
BEGIN
    RETURN QUERY
        SELECT
            o.order_id,
            COALESCE(
                    (SELECT string_agg(quantity || 'x ' || product_name, ', ')
                     FROM order_item oi WHERE oi.order_id = o.order_id),
                    'Custom Order'
            )::TEXT AS product_summary,
            o.status,
            o.total_amount,
            o.deposit_amount,
            o.deposit_status,
            o.deadline,
            o.created_at,
            (o.status = 'Ready for Pickup' OR o.status = 'Ready for Delivery') AS is_ready
        FROM
            "order" o
        WHERE
            o.customer_id = p_customer_id
          AND (p_status_filter = 'All' OR o.status = p_status_filter)
          AND (
            p_search_query = ''
                OR o.order_id::TEXT ILIKE '%' || p_search_query || '%'
                OR EXISTS (
                SELECT 1 FROM order_item oi
                WHERE oi.order_id = o.order_id
                  AND oi.product_name ILIKE '%' || p_search_query || '%'
            )
            )
        ORDER BY
            o.created_at DESC;
END;
$$;

alter function fn_get_customer_orders(integer, text, text) owner to root;


