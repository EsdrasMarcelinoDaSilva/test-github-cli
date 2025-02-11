create database Ecommerce

CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    name_product VARCHAR(100)
);

INSERT INTO products (name_product)
VALUES 
('Produto A'),
('Produto B'),
('Produto C'),
('Produto D'),
('Produto E'),
('Produto F')

select * from products

CREATE TABLE sales (
    id SERIAL PRIMARY KEY,
    product_id INT,
    quantity INT,
    data_product DATE,
    FOREIGN KEY (product_id) REFERENCES products(id)
);

INSERT INTO sales (product_id, quantity, data_product)
VALUES
(1, 10, '2025-02-01'),
(1, 5, '2025-02-01'),
(2, 8, '2025-02-01'),
(2, 3, '2025-02-02'),
(3, 7, '2025-02-02');

select * from sales

DROP FUNCTION IF EXISTS generate_daily_report();

CREATE OR REPLACE FUNCTION generate_daily_report()
RETURNS TABLE(data_product DATE, product_id INT, avg_quantity NUMERIC) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        sales.data_product,
        sales.product_id,
        AVG(sales.quantity) AS avg_quantity
    FROM 
        sales
    GROUP BY 
        sales.data_product, sales.product_id
    ORDER BY 
        sales.data_product, sales.product_id;
END;
$$ LANGUAGE plpgsql;


SELECT * FROM generate_daily_report();

