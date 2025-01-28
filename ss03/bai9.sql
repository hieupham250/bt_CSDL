create database bai9;

-- 1
create table Customers(
	customer_id int primary key auto_increment,
    customer_name varchar(255) not null,
    email varchar(255) not null unique,
    phone varchar(15) not null
);

create table Orders(
	order_id int primary key auto_increment,
    order_date date,
    total_amount decimal(10,2),
    order_status varchar(50) check (order_status in ('Pending', 'Shipped', 'Completed', 'Cancelled')) not null,
    customer_id int,
    foreign key (customer_id) references Customers(customer_id)
);

insert into Customers(
	customer_name, email, phone
) values
	('Nguyen Van A', 'nguyenvana@example.com', '1234567890'),
    ('Tran Thi B', 'tranthib@example.com', '0987654321'),
    ('Le Van C', 'levanc@example.com', '0912345678'),
    ('Pham Thi D', 'phamthid@example.com', '0898765432'),
    ('Hoang Van E', 'hoangvane@example.com', '0812345678');
    
insert into Orders(
	order_date, total_amount, order_status, customer_id
) values
	('2025-01-01', 200.00, 'Pending', 1),
    ('2025-01-02', 150.50, 'Shipped', 1),
    ('2025-01-03', 300.75, 'Completed', 2),
    ('2025-01-04', 450.00, 'Pending', 3),
    ('2025-01-05', 120.00, 'Cancelled', 2),
    ('2025-01-06', 99.99, 'Pending', 4),
    ('2025-01-07', 75.50, 'Shipped', 4),
    ('2025-01-08', 500.00, 'Completed', 3),
    ('2025-01-09', 60.00, 'Pending', 1),
    ('2025-01-10', 250.00, 'Completed', 3);
    
-- 3
set sql_safe_updates = 0;
update Customers set phone = '0000000000' where customer_name like 'Nguyen%';

-- 4
delete Customers 
from Customers
left join (
	select customer_id, sum(total_amount) as total_spent
	from Orders
    group by customer_id
) as OrderSummary
on Customers.customer_id = OrderSummary.customer_id
where OrderSummary.total_spent < 100 OR OrderSummary.total_spent is null;

-- 5
update Orders set order_status = 'Cancelled' where total_amount < 50 and order_status = 'Pending';
    