use classicmodels;

-- 2
create index idx_customerNumber on payments(customerNumber);

-- 3
create view view_customer_payments as
select
	customerNumber,
    sum(amount) as total_payments,
    count(*) as payment_count
from payments
group by customerNumber;

-- 4
select * from view_customer_payments;

-- 5
select
	c.customerNumber,
    c.customerName,
    vcp.total_payments,
    vcp.payment_count
from view_customer_payments vcp
join customers c on vcp.customerNumber = c.customerNumber
where vcp.total_payments > 150000 and vcp.payment_count > 3
order by vcp.total_payments desc
limit 5;