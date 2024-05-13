CREATE OR REPLACE PROCEDURE update_stock(p_product_id INT, quantity INT)
LANGUAGE plpgsql
AS $$
BEGIN
    -- Update the stock quantity for the given product ID
    UPDATE products
    SET units_in_stock = units_in_stock + quantity
    WHERE product_id = p_product_id;
    
    -- Output a message indicating the update was successful
    RAISE NOTICE 'Stock quantity updated for product ID %', p_product_id;
END;
$$;


--call
CALL update_stock(11, 50);