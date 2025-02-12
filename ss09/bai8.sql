use classicmodels;

-- 2
create index idx_productLine on products(productLine);

-- 3
create view view_highest_priced_products as
select p1.productLine, p1.productName, p1.MSRP
from products p1
where p1.MSRP = (
	select max(p2.MSRP)
    from products p2
    where p2.productLine = p1.productLine
);

-- 4
select * from view_highest_priced_products;

-- 5
select vhp.productLine, vhp.productName, vhp.MSRP, pl.textDescription
from view_highest_priced_products vhp
join productlines pl on vhp.productLine = pl.productLine
order by vhp.MSRP desc
limit 10;