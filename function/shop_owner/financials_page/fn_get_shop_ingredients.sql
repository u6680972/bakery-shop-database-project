create function fn_get_shop_ingredients(p_shop_id integer)
    returns TABLE(ingredient_id integer, name text, cost numeric, unit text, last_purchased_date date)
    language plpgsql
as
$$
BEGIN
    RETURN QUERY
        SELECT
            i.ingredient_id,
            i.name,
            i.cost,
            i.unit,
            i.last_purchased_date
        FROM
            shop_ingredient i
        WHERE
            i.shop_id = p_shop_id
        ORDER BY
            i.name ASC;
END;
$$;

alter function fn_get_shop_ingredients(integer) owner to root;


