create function fn_get_financial_overview(p_shop_id integer, p_month integer, p_year integer)
    returns TABLE(total_income numeric, total_expenses numeric, net_profit numeric)
    language plpgsql
as
$$
DECLARE
    v_income DECIMAL(10,2);
    v_expenses DECIMAL(10,2);
BEGIN
    -- Calculate Income
    SELECT COALESCE(SUM(amount), 0.00) INTO v_income
    FROM shop_transaction
    WHERE shop_id = p_shop_id
      AND type = 'Income'
      AND EXTRACT(MONTH FROM transaction_date) = p_month
      AND EXTRACT(YEAR FROM transaction_date) = p_year;

    -- Calculate Expenses
    SELECT COALESCE(SUM(amount), 0.00) INTO v_expenses
    FROM shop_transaction
    WHERE shop_id = p_shop_id
      AND type = 'Expense'
      AND EXTRACT(MONTH FROM transaction_date) = p_month
      AND EXTRACT(YEAR FROM transaction_date) = p_year;

    RETURN QUERY
        SELECT
            v_income,
            v_expenses,
            (v_income - v_expenses)::DECIMAL(10,2) AS net_profit;
END;
$$;

alter function fn_get_financial_overview(integer, integer, integer) owner to root;


