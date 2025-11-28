CREATE OR REPLACE FUNCTION fn_login_unified(
    p_username_or_email TEXT,
    p_password TEXT,
    p_shop_identifier TEXT
)
    RETURNS TABLE (
      auth_id INT,
      user_type TEXT,
      shop_id INT,
      first_name TEXT
  )
    LANGUAGE plpgsql
AS $$
DECLARE
    v_target_shop_id INT;
BEGIN
    SELECT client.shop_id INTO v_target_shop_id
    FROM client
    WHERE shop_name = p_shop_identifier
    LIMIT 1;

    RETURN QUERY
        SELECT
            mu.user_id AS auth_id,
            'manager'::TEXT AS user_type,
            sma.shop_id,
            mu.first_name::TEXT
        FROM manager_user mu
                 JOIN shop_manager_access sma ON mu.user_id = sma.manager_user_id
        WHERE (mu.username = p_username_or_email OR mu.email = p_username_or_email)
          AND mu.password_hash = p_password
          AND sma.shop_id = v_target_shop_id
        LIMIT 1;

    IF FOUND THEN
        RETURN;
    END IF;

    RETURN QUERY
        SELECT
            cu.customer_id AS auth_id,
            'customer'::TEXT AS user_type,
            cu.shop_id,
            cu.first_name::TEXT
        FROM customer_user cu
        WHERE cu.email = p_username_or_email
          AND cu.password_hash = p_password
          AND cu.shop_id = v_target_shop_id
        LIMIT 1;

    RETURN;
END;
$$;

ALTER FUNCTION fn_login_unified(text, text, text) OWNER TO root;