create function fn_get_customer_profile(p_customer_id integer)
    returns TABLE(first_name text, last_name text, email text, phone_number text, street_address text, city text, zip_code text, customer_since date, total_orders bigint, active_orders bigint)
    language plpgsql
as
$$
BEGIN
    RETURN QUERY
        SELECT
            cu.first_name::TEXT,
            cu.last_name::TEXT,
            cu.email::TEXT,
            cu.phone_number::TEXT,
            cu.address::TEXT AS street_address,
            cu.city::TEXT,
            cu.zip_code::TEXT,
            cu.created_at::DATE AS customer_since,

            -- Calculate Total Orders
            (SELECT COUNT(*) FROM "order" o WHERE o.customer_id = cu.customer_id)::BIGINT,

            -- Calculate Active Orders (Not Finished/Cancelled)
            (SELECT COUNT(*) FROM "order" o
             WHERE o.customer_id = cu.customer_id
               AND o.status NOT IN ('Finished', 'Cancelled'))::BIGINT
        FROM
            customer_user cu
        WHERE
            cu.customer_id = p_customer_id;
END;
$$;

alter function fn_get_customer_profile(integer) owner to root;


