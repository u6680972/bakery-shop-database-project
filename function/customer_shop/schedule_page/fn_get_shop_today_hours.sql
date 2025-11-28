create function fn_get_shop_today_hours(p_shop_id integer)
    returns TABLE(day_name text, is_open boolean, time_display text, status_label text)
    language plpgsql
as
$$
DECLARE
    v_today_name TEXT;
BEGIN
    SELECT TRIM(TO_CHAR(CURRENT_DATE, 'Day')) INTO v_today_name;

    RETURN QUERY
        SELECT
            sa.day_of_week::TEXT,
            sa.is_open,
            CASE
                WHEN sa.is_open THEN
                    TO_CHAR(sa.open_time, 'FMHH12:MI AM') || ' - ' || TO_CHAR(sa.close_time, 'FMHH12:MI PM')
                ELSE 'Closed'
                END::TEXT AS time_display,
            CASE
                WHEN sa.is_open = FALSE THEN 'Closed'
                WHEN sa.day_of_week IN ('Saturday', 'Sunday') THEN 'Weekend hours'
                ELSE 'Regular hours'
                END::TEXT AS status_label
        FROM
            shop_availability sa
        WHERE
            sa.shop_id = p_shop_id
          AND sa.day_of_week = v_today_name;
END;
$$;

alter function fn_get_shop_today_hours(integer) owner to root;


