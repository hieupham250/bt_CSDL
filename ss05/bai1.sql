CREATE DATABASE bai1;

USE bai1;

CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY, -- Khóa chính
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(15),
    address VARCHAR(255)
);

CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY, -- Khóa chính
    customer_id INT, -- Khóa ngoại
    order_date DATE NOT NULL,
    total_amount DECIMAL(10, 2) NOT NULL,
    status VARCHAR(50),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id) -- Liên kết với bảng customers
);

INSERT INTO customers (name, email, phone, address)
VALUES
('Nguyen Van An', 'nguyenvanan@example.com', '0901234567', '123 Le Loi, TP.HCM'),
('Tran Thi Bich', 'tranthibich@example.com', '0912345678', '456 Nguyen Hue, TP.HCM'),
('Le Van Cuong', 'levancuong@example.com', '0923456789', '789 Dien Bien Phu, Ha Noi');

INSERT INTO orders (customer_id, order_date, total_amount, status)
VALUES
(1, '2025-01-10', 500000, 'Pending'),
(1, '2025-01-12', 325000, 'Completed'),
(NULL, '2025-01-13', 450000, 'Cancelled'),
(3, '2025-01-14', 270000, 'Pending'),
(2, '2025-01-16', 850000, NULL);

-- 2
SELECT 
    orders.order_id, 
    orders.order_date, 
    orders.total_amount, 
    customers.name, 
    customers.email
FROM orders
LEFT JOIN customers ON orders.customer_id = customers.customer_id;

-- 3
SELECT 
    customers.customer_id, 
    customers.name, 
    customers.phone, 
    orders.order_id, 
    orders.status,
    orders.order_date
FROM customers
LEFT JOIN orders ON customers.customer_id = orders.customer_id;

-- 4
SELECT 
    customers.customer_id, 
    customers.name, 
    orders.order_id, 
    orders.total_amount, 
    orders.order_date
FROM customers
INNER JOIN orders ON customers.customer_id = orders.customer_id;