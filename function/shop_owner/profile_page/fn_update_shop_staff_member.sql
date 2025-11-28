create function fn_update_shop_staff_member(p_staff_id integer, p_shop_id integer, p_first_name text, p_last_name text, p_email text, p_phone_number text, p_job_title text, p_status text, p_hired_at date) returns boolean
    language plpgsql
as
$$
DECLARE
BEGIN
    UPDATE shop_staff
    SET
        first_name = p_first_name,
        last_name = p_last_name,
        email = p_email,
        phone_number = p_phone_number,
        job_title = p_job_title,
        status = p_status,
        hired_at = p_hired_at
    WHERE
        staff_id = p_staff_id
      AND shop_id = p_shop_id;

    IF FOUND THEN
        RETURN 1;
    ELSE
        RETURN 0;
    END IF;
END;
$$;

alter function fn_update_shop_staff_member(integer, integer, text, text, text, text, text, text, date) owner to root;


