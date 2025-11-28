create function fn_update_shop_product(p_product_id integer, p_shop_id integer, p_name text, p_description text, p_price numeric, p_category text, p_stock_quantity integer, p_image_url text) returns boolean
    language plpgsql
as
$$
BEGIN
    UPDATE product
    SET
        name = p_name,
        description = p_description,
        price = p_price,
        category = p_category,
        stock_quantity = p_stock_quantity,
        image_url = p_image_url,
        updated_at = NOW()
    WHERE
        product_id = p_product_id
      AND shop_id = p_shop_id;

    RETURN FOUND;
END;
$$;

alter function fn_update_shop_product(integer, integer, text, text, numeric, text, integer, text) owner to root;


