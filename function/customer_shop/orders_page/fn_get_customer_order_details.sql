create function fn_get_customer_order_details(p_order_id integer, p_customer_id integer)
    returns TABLE(order_id integer, status text, product_name text, quantity integer, order_date date, deadline timestamp with time zone, fulfillment_method text, delivery_address text, item_notes text, total_price numeric, deposit_amount numeric, deposit_status text, payment_slip_url text)
    language plpgsql
as
$$
BEGIN
    RETURN QUERY
        SELECT
            o.order_id,
            o.status,
            oi.product_name,
            oi.quantity,
            o.created_at::DATE AS order_date,
            o.deadline,
            o.fulfillment_method,
            o.delivery_address,
            oi.notes AS item_notes,
            o.total_amount,
            o.deposit_amount,
            o.deposit_status,
            o.payment_slip_url
        FROM
            "order" o
                JOIN
            order_item oi ON o.order_id = oi.order_id
        WHERE
            o.order_id = p_order_id
          AND o.customer_id = p_customer_id
        LIMIT 1;
END;
$$;

alter function fn_get_customer_order_details(integer, integer) owner to root;


