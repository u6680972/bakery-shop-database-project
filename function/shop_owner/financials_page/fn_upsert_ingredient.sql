create function fn_upsert_ingredient(p_shop_id integer, p_ingredient_id integer, p_name text, p_cost numeric, p_unit text, p_purchase_date date) returns integer
    language plpgsql
as
$$
DECLARE
    v_id INT;
BEGIN
    IF p_ingredient_id IS NULL THEN
        -- Create
        INSERT INTO shop_ingredient (shop_id, name, cost, unit, last_purchased_date)
        VALUES (p_shop_id, p_name, p_cost, p_unit, p_purchase_date)
        RETURNING ingredient_id INTO v_id;
    ELSE
        -- Update
        UPDATE shop_ingredient
        SET
            name = p_name,
            cost = p_cost,
            unit = p_unit,
            last_purchased_date = p_purchase_date
        WHERE
            ingredient_id = p_ingredient_id
          AND shop_id = p_shop_id;
        v_id := p_ingredient_id;
    END IF;

    RETURN v_id;
END;
$$;

alter function fn_upsert_ingredient(integer, integer, text, numeric, text, date) owner to root;


