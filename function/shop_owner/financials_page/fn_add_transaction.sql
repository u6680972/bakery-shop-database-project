create function fn_add_transaction(p_shop_id integer, p_type text, p_amount numeric, p_category text, p_description text, p_date date DEFAULT CURRENT_DATE) returns integer
    language plpgsql
as
$$
DECLARE
    v_new_id INT;
BEGIN
    INSERT INTO shop_transaction (
        shop_id, type, amount, category, description, transaction_date
    )
    VALUES (
               p_shop_id, p_type, p_amount, p_category, p_description, p_date
           )
    RETURNING transaction_id INTO v_new_id;

    RETURN v_new_id;
END;
$$;

alter function fn_add_transaction(integer, text, numeric, text, text, date) owner to root;


