create function fn_validate_invitation_code(p_invitation_code text)
    returns TABLE(is_valid boolean, shop_id integer, shop_name text)
    language plpgsql
as
$$
BEGIN
    RETURN QUERY
        SELECT
            TRUE AS is_valid,
            si.shop_id,
            -- CAST the shop_name column to TEXT to match the function's return type
            c.shop_name::text AS shop_name
        FROM
            shop_invitation si
                JOIN
            client c ON si.shop_id = c.shop_id
        WHERE
            si.invitation_code = p_invitation_code
          AND si.used_by_user_id IS NULL;

END;
$$;

alter function fn_validate_invitation_code(text) owner to root;


