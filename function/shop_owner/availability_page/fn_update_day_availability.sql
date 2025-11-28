create function fn_update_day_availability(p_shop_id integer, p_day_of_week text, p_is_open boolean, p_open_time time without time zone, p_close_time time without time zone, p_max_orders integer) returns boolean
    language plpgsql
as
$$
BEGIN
    UPDATE shop_availability
    SET
        is_open = p_is_open,
        open_time = p_open_time,
        close_time = p_close_time,
        max_orders = p_max_orders,
        updated_at = NOW()
    WHERE
        shop_id = p_shop_id
      AND day_of_week = p_day_of_week;

    IF NOT FOUND THEN
        INSERT INTO shop_availability (
            shop_id, day_of_week, is_open, open_time, close_time, max_orders, updated_at
        )
        VALUES (
                   p_shop_id, p_day_of_week, p_is_open, p_open_time, p_close_time, p_max_orders, NOW()
               );
    END IF;

    RETURN TRUE;
END;
$$;

alter function fn_update_day_availability(integer, text, boolean, time, time, integer) owner to root;


