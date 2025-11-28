create function fn_get_shop_availability(p_shop_id integer)
    returns TABLE(day_of_week text, is_open boolean, open_time time without time zone, close_time time without time zone, max_orders integer)
    language plpgsql
as
$$
BEGIN
    RETURN QUERY
        SELECT
            sa.day_of_week,
            sa.is_open,
            sa.open_time,
            sa.close_time,
            sa.max_orders
        FROM
            shop_availability sa
        WHERE
            sa.shop_id = p_shop_id
        ORDER BY
            CASE
                WHEN sa.day_of_week = 'Monday' THEN 1
                WHEN sa.day_of_week = 'Tuesday' THEN 2
                WHEN sa.day_of_week = 'Wednesday' THEN 3
                WHEN sa.day_of_week = 'Thursday' THEN 4
                WHEN sa.day_of_week = 'Friday' THEN 5
                WHEN sa.day_of_week = 'Saturday' THEN 6
                WHEN sa.day_of_week = 'Sunday' THEN 7
                END;
END;
$$;

alter function fn_get_shop_availability(integer) owner to root;


