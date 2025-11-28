create function fn_get_order_items(p_order_id integer)
    returns TABLE(product_name text, quantity integer, notes text, price numeric)
    language plpgsql
as
$$
BEGIN
    RETURN QUERY
        SELECT
            oi.product_name,
            oi.quantity,
            oi.notes,
            oi.price
        FROM
            order_item oi
        WHERE
            oi.order_id = p_order_id;
END;
$$;

alter function fn_get_order_items(integer) owner to root;


