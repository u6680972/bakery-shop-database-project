create function fn_update_order_status(p_order_id integer, p_new_status text) returns boolean
    language plpgsql
as
$$
BEGIN
    UPDATE "order"
    SET status = p_new_status
    WHERE order_id = p_order_id;

    RETURN FOUND;
END;
$$;

alter function fn_update_order_status(integer, text) owner to root;


