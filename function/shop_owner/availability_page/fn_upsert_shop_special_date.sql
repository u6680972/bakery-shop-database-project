create function fn_upsert_shop_special_date(p_shop_id integer, p_date date, p_status text, p_note text) returns boolean
    language plpgsql
as
$$
BEGIN
    UPDATE shop_special_date
    SET
        status = p_status,
        note = p_note,
        updated_at = NOW()
    WHERE
        shop_id = p_shop_id
      AND date = p_date;

    IF NOT FOUND THEN
        INSERT INTO shop_special_date (shop_id, date, status, note)
        VALUES (p_shop_id, p_date, p_status, p_note);
    END IF;

    RETURN TRUE;
END;
$$;

alter function fn_upsert_shop_special_date(integer, date, text, text) owner to root;


