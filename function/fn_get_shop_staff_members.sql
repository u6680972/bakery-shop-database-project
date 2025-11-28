create function fn_get_shop_staff_members(p_shop_id integer)
    returns TABLE(staff_id integer, first_name text, last_name text, email text, phone_number text, job_title text, status text, hired_at date)
    language plpgsql
as
$$
BEGIN
    RETURN QUERY
        SELECT
            s.staff_id,
            s.first_name,
            s.last_name,
            s.email,
            s.phone_number,
            s.job_title,
            s.status,
            s.hired_at
        FROM
            shop_staff s
        WHERE
            s.shop_id = p_shop_id
        ORDER BY
            s.first_name, s.last_name;
END;
$$;

alter function fn_get_shop_staff_members(integer) owner to root;


