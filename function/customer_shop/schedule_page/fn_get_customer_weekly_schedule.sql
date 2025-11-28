create function fn_delete_shop_special_date(p_special_date_id integer, p_shop_id integer) returns boolean
    language plpgsql
as
$$
BEGIN
    DELETE FROM shop_special_date
    WHERE
        special_date_id = p_special_date_id
      AND shop_id = p_shop_id;

    RETURN FOUND;
END;
$$;

alter function fn_delete_shop_special_date(integer, integer) owner to root;


