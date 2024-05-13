DECLARE
    order_record RECORD;
    order_id_value INT;
    order_total NUMERIC;
BEGIN
    -- Iterate through orders and calculate totals
    FOR order_record IN
        SELECT order_id FROM orders
    LOOP
        -- Get the order ID from the current record
        order_id_value := order_record.order_id;
        
        -- Call the calculate_order_total function to calculate the total for the current order
        SELECT calculate_order_total(order_id_value) INTO order_total;
        
        -- Output the order ID and total
        RAISE NOTICE 'Order ID: %, Total: %', order_id_value, order_total;
    END LOOP;
END $$;
