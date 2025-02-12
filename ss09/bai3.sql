use classicmodels;

-- 2
explain analyze 
select * from customers  
where country = 'Germany';

-- 3
create index idx_country  
on customers (country);

-- 4
explain analyze  
select * from customers  
where country = 'Germany';

-- 5
drop index idx_country  
on customers;


