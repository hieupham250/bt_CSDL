CREATE DATABASE bai2;

USE bai2;

CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY, 
    product_name VARCHAR(100) NOT NULL,        
    category VARCHAR(50) NOT NULL,            
    price DECIMAL(10, 2) NOT NULL,            
    stock_quantity INT NOT NULL               
);

INSERT INTO products (product_name, category, price, stock_quantity)
VALUES
('Laptop Dell XPS 13', 'Electronics', 25999.99, 10),
('Nike Air Max 270', 'Footwear', 4999.00, 50),
('Samsung Galaxy S22', 'Electronics', 19999.99, 25),
('T-Shirt Uniqlo', 'Clothing', 299.99, 100),
('Apple AirPods Pro', 'Accessories', 5999.00, 15),
('T-Shirt Apolo', 'Clothing', 199.99, 100);

-- 2
SELECT 
    product_id, 
    product_name, 
    price, 
    price * 1.10 AS new_price
FROM products;

-- 3
SELECT 
    product_id, 
    product_name, 
    price, 
    stock_quantity
FROM products
WHERE price < 10000 
AND stock_quantity > 20;

-- 4
SELECT 
    product_id, 
    product_name, 
    price, 
    stock_quantity, 
    price * stock_quantity AS total_stock_value
FROM products;

-- 5
SELECT 
    product_id, 
    product_name, 
    category, 
    price
FROM products
WHERE category = 'Electronics' 
OR price > 20000;
