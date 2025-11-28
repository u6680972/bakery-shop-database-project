create function fn_delete_shop_staff_member(p_staff_id integer, p_shop_id integer) returns boolean
    language plpgsql
as
$$
DECLARE
    v_deleted_rows INT;
BEGIN
    DELETE FROM shop_staff
    WHERE
        staff_id = p_staff_id
      AND shop_id = p_shop_id; -- Security check

    GET DIAGNOSTICS v_deleted_rows = ROW_COUNT;

    RETURN FOUND;
END;
$$;

alter function fn_delete_shop_staff_member(integer, integer) owner to root;


