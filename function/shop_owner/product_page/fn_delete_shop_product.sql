create function fn_delete_shop_product(p_product_id integer, p_shop_id integer) returns boolean
    language plpgsql
as
$$
BEGIN
    DELETE FROM product
    WHERE
        product_id = p_product_id
      AND shop_id = p_shop_id;

    RETURN FOUND;
END;
$$;

alter function fn_delete_shop_product(integer, integer) owner to root;


