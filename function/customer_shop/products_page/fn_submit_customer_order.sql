create function fn_submit_customer_order(p_shop_id integer, p_customer_id integer, p_product_name text, p_quantity integer, p_deadline date, p_deadline_time time without time zone, p_fulfillment_type text, p_flavor text, p_design_notes text, p_dietary_notes text) returns integer
    language plpgsql
as
$$
DECLARE
    v_new_order_id INT;
    v_combined_notes TEXT;
    v_estimated_price DECIMAL(10,2);
BEGIN
    -- 1. Calculate a rough estimate (optional, or set to 0 until quote)
    -- Here we just fetch the base price of the product if it exists
    SELECT price * p_quantity INTO v_estimated_price
    FROM product
    WHERE shop_id = p_shop_id AND name = p_product_name
    LIMIT 1;

    -- 2. Create the Order
    INSERT INTO "order" (
        shop_id,
        customer_id,
        status,
        total_amount,
        deadline,
        notes -- Storing delivery/pickup info here for now
    )
    VALUES (
               p_shop_id,
               p_customer_id,
               'Awaiting Quote', -- Initial status
               COALESCE(v_estimated_price, 0.00), -- Placeholder price
               (p_deadline + p_deadline_time), -- Combine Date+Time
               'Fulfillment: ' || p_fulfillment_type
           )
    RETURNING order_id INTO v_new_order_id;

    -- 3. Create the Order Item with all the specific details
    -- Combine the notes into one string for the item description
    v_combined_notes := 'Flavor: ' || p_flavor ||
                        '. Design: ' || p_design_notes ||
                        '. Dietary: ' || p_dietary_notes;

    INSERT INTO order_item (
        order_id,
        product_name,
        quantity,
        price,
        notes
    )
    VALUES (
               v_new_order_id,
               p_product_name,
               p_quantity,
               COALESCE(v_estimated_price, 0.00),
               v_combined_notes
           );

    RETURN v_new_order_id;
END;
$$;

alter function fn_submit_customer_order(integer, integer, text, integer, date, time, text, text, text, text) owner to root;


