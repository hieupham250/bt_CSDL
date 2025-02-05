CREATE DATABASE bai4;

USE bai4;

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
SELECT p.product_name, p.category, p.price, p.stock_quantity
FROM products p
WHERE p.price = (
    SELECT MAX(price) 
    FROM products 
    WHERE category = p.category
);

-- 3
SELECT product_name, category, price, stock_quantity
FROM products
LIMIT 2 OFFSET 2;

-- 4
SELECT product_name, category, price, stock_quantity
FROM products
WHERE category = 'Electronics'
ORDER BY price DESC;

-- 5
SELECT product_name, category, price, stock_quantity
FROM products
WHERE category = 'Clothing'
ORDER BY price ASC
LIMIT 1;
