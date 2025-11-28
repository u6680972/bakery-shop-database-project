create function fn_get_order_details(p_order_id integer)
    returns TABLE(order_id integer, status text, deadline timestamp with time zone, created_at timestamp with time zone, total_amount numeric, deposit_amount numeric, deposit_status text, customer_first_name text, customer_last_name text, customer_email text, customer_phone text)
    language plpgsql
as
$$
BEGIN
    RETURN QUERY
        SELECT
            o.order_id,
            o.status,
            o.deadline,
            o.created_at,
            o.total_amount,
            o.deposit_amount,
            o.deposit_status,
            cu.first_name::TEXT,
            cu.last_name::TEXT,
            cu.email::TEXT,
            cu.phone_number::TEXT
        FROM
            "order" o
                LEFT JOIN
            customer_user cu ON o.customer_id = cu.customer_id
        WHERE
            o.order_id = p_order_id;
END;
$$;

alter function fn_get_order_details(integer) owner to root;


