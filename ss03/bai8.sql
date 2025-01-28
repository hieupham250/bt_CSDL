create database bai8;

-- 1
create table Products(
	product_id int primary key auto_increment,
    product_name varchar(255) not null,
    price decimal(10,2) not null check (price > 0),
    stock int not null check (stock >= 0),
    category varchar(100)
);

-- 2
insert into Products(
	product_name, price, stock, category
) values
	('iPhone 14', 999.99, 20, 'Electronics'),
    ('Samsung Galaxy S23', 849.99, 15, 'Electronics'),
    ('Sony Headphones', 199.99, 30, 'Electronics'),
    ('Wooden Table', 120.50, 10, 'Furniture'),
    ('Office Chair', 89.99, 25, 'Furniture'),
    ('Running Shoes', 49.99, 50, 'Sports'),
    ('Basketball', 29.99, 100, 'Sports'),
    ('T-Shirt', 19.99, 200, 'Clothing'),
    ('Laptop Bag', 39.99, 40, 'Accessories'),
    ('Desk Lamp', 25.00, 35, 'Electronics');
    
-- 3
select * from Products where category = 'Electronics' and price > 200;

-- 4
select * from Products where stock < 20;

-- 5
select product_name, price from Products where category = 'Sports' or 'Accessories';

-- 6
update Products set stock = 100 where product_name like 'S%';

-- 7
update Products set category = 'Premium Electronics' where price > 500;

-- 8
delete from Products where stock = 0;

-- 9
delete from Products where category = 'Clothing' and price < 30;