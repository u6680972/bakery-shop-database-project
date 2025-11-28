create function fn_get_recent_transactions(p_shop_id integer, p_limit integer DEFAULT 5)
    returns TABLE(transaction_id integer, type text, category text, description text, amount numeric, transaction_date date)
    language plpgsql
as
$$
BEGIN
    RETURN QUERY
        SELECT
            t.transaction_id,
            t.type,
            t.category,
            t.description,
            t.amount,
            t.transaction_date
        FROM
            shop_transaction t
        WHERE
            t.shop_id = p_shop_id
        ORDER BY
            t.transaction_date DESC, t.created_at DESC
        LIMIT p_limit;
END;
$$;

alter function fn_get_recent_transactions(integer, integer) owner to root;


