CREATE OR REPLACE FUNCTION calculate_order_total(p_order_id INT)
RETURNS NUMERIC AS $$
DECLARE
    total NUMERIC := 0;
BEGIN
    -- Calculate the total for the given order ID
    SELECT SUM(unit_price * quantity * (1 - discount))
    INTO total
    FROM order_details
    WHERE order_id = p_order_id;
    
    RETURN total;
END;
$$ LANGUAGE plpgsql;


--call
SELECT calculate_order_total(10248);