create function fn_add_shop_staff_member(p_shop_id integer, p_first_name text, p_last_name text, p_email text, p_phone_number text, p_job_title text, p_hired_at date DEFAULT CURRENT_DATE) returns integer
    language plpgsql
as
$$
DECLARE
    v_new_staff_id INT;
BEGIN
    INSERT INTO shop_staff (
        shop_id,
        first_name,
        last_name,
        email,
        phone_number,
        job_title,
        status,
        hired_at
    )
    VALUES (
               p_shop_id,
               p_first_name,
               p_last_name,
               p_email,
               p_phone_number,
               p_job_title,
               'active',
               p_hired_at
           )
    RETURNING staff_id INTO v_new_staff_id;

    RETURN v_new_staff_id;
END;
$$;

alter function fn_add_shop_staff_member(integer, text, text, text, text, text, date) owner to root;


