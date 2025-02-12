use classicmodels;

-- 2
create index idx_orderDate_status on orders(orderDate, status);

select orderNumber, orderDate, status
from orders
where year(orderDate) = 2023 and status = 'Shipped';

explain analyze
select orderNumber, orderDate, status
from orders
where year(orderDate) = 2023 and status = 'Shipped';

-- 3
create unique index idx_customerNumber on customers(customerNumber);

create unique index idx_phone on customers(phone);

select customerNumber, customerName, phone
from customers
where phone = '2035552570';

explain analyze
select customerNumber, customerName, phone
from customers
where phone = '2035552570';

-- 4
drop index idx_orderDate_status on orders;

drop index idx_customerNumber on customers;

drop index idx_phone on customers;


