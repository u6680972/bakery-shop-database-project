CREATE OR REPLACE FUNCTION fn_validate_invitation_code(
    p_invitation_code TEXT
)
    RETURNS TABLE (
      is_valid BOOLEAN,
      shop_id INT,
      shop_name TEXT
  )
    LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
        SELECT
            TRUE AS is_valid,
            si.shop_id,
            c.shop_name
        FROM
            shop_invitation si
                JOIN
            client c ON si.shop_id = c.shop_id
        WHERE
            si.invitation_code = p_invitation_code
          AND si.used_by_user_id IS NULL;

END;
$$;

ALTER FUNCTION fn_validate_invitation_code(text) OWNER TO root;