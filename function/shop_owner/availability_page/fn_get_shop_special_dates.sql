create function fn_get_shop_special_dates(p_shop_id integer)
    returns TABLE(special_date_id integer, date date, status text, note text)
    language plpgsql
as
$$
BEGIN
    RETURN QUERY
        SELECT
            sd.special_date_id,
            sd.date,
            sd.status,
            sd.note
        FROM
            shop_special_date sd
        WHERE
            sd.shop_id = p_shop_id
        ORDER BY
            sd.date ASC;
END;
$$;

alter function fn_get_shop_special_dates(integer) owner to root;


