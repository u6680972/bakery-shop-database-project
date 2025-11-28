create function fn_delete_ingredient(p_ingredient_id integer, p_shop_id integer) returns boolean
    language plpgsql
as
$$
BEGIN
    DELETE FROM shop_ingredient
    WHERE
        ingredient_id = p_ingredient_id
      AND shop_id = p_shop_id;

    RETURN FOUND;
END;
$$;

alter function fn_delete_ingredient(integer, integer) owner to root;


