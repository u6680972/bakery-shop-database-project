create function fn_send_order_quote(p_order_id integer, p_total_amount numeric, p_deposit_amount numeric) returns boolean
    language plpgsql
as
$$
BEGIN
    UPDATE "order"
    SET
        total_amount = p_total_amount,
        deposit_amount = p_deposit_amount,
        status = 'Awaiting Confirmation',
        deposit_status = 'Pending'
    WHERE
        order_id = p_order_id;

    RETURN FOUND;
END;
$$;

alter function fn_send_order_quote(integer, numeric, numeric) owner to root;


