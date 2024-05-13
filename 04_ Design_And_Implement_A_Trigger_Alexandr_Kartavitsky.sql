-- Create a new table to store the log of price updates
CREATE TABLE price_update_log (
    log_id SERIAL PRIMARY KEY,
    product_id INT,
    old_price NUMERIC,
    new_price NUMERIC,
    update_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create the trigger function
CREATE OR REPLACE FUNCTION log_price_update()
RETURNS TRIGGER AS $$
BEGIN
    -- Insert a record into the price_update_log table whenever the UnitPrice of a product is updated
    IF NEW.unit_price <> OLD.unit_price THEN
        INSERT INTO price_update_log (product_id, old_price, new_price)
        VALUES (NEW.product_id, OLD.unit_price, NEW.unit_price);
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Create the trigger
CREATE TRIGGER price_update_trigger
AFTER UPDATE OF unit_price ON products
FOR EACH ROW
EXECUTE FUNCTION log_price_update();



-- Trigger testing
-- Update the UnitPrice for product ID 11
UPDATE products
SET unit_price = 15.99
WHERE product_id = 11;

-- Verify the log in the price_update_log table
SELECT * FROM price_update_log;