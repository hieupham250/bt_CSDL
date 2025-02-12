use classicmodels;

-- 2
create view view_orders_summary as
select
	c.customerNumber,
    c.customerName,
    count(o.orderNumber) as 'total_orders'
from customers c
left join orders o on c.customerNumber = o.customerNumber
group by c.customerNumber, c.customerName;

-- 3
select * from view_orders_summary where total_orders > 3;