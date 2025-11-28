create function fn_update_stock_quantity(p_product_id integer, p_delta integer) returns boolean
    language plpgsql
as
$$
DECLARE
    v_new_quantity INT;
BEGIN
    -- 1. Update the stock
    UPDATE product
    SET
        stock_quantity = GREATEST(0, stock_quantity + p_delta), -- Prevent negative stock
        last_restocked_at = CASE
                                WHEN p_delta > 0 THEN NOW() -- Update timestamp only if adding stock
                                ELSE last_restocked_at
            END
    WHERE product_id = p_product_id
    RETURNING stock_quantity INTO v_new_quantity;

    RETURN FOUND;
END;
$$;

alter function fn_update_stock_quantity(integer, integer) owner to root;


