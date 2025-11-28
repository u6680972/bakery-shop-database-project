create function fn_add_shop_product(p_shop_id integer, p_name text, p_description text, p_price numeric, p_category text, p_stock_quantity integer, p_image_url text) returns integer
    language plpgsql
as
$$
DECLARE
    v_new_id INT;
BEGIN
    INSERT INTO product (
        shop_id, name, description, price, category, stock_quantity, image_url, is_active
    )
    VALUES (
               p_shop_id, p_name, p_description, p_price, p_category, p_stock_quantity, p_image_url, TRUE
           )
    RETURNING product_id INTO v_new_id;

    RETURN v_new_id;
END;
$$;

alter function fn_add_shop_product(integer, text, text, numeric, text, integer, text) owner to root;


