use classicmodels;

-- 2
create index idx_productLine on products(productLine);

-- 3
create view view_total_sales as
select
	p.productLine,
    sum(od.quantityOrdered * od.priceEach) as total_sales,
    sum(od.quantityOrdered) as total_quantity
from orderdetails od
join products p on od.productCode = p.productCode
group by p.productLine;

-- 4
select * from view_total_sales;

-- 5
select
	pl.productLine,
    pl.textDescription,
    vts.total_sales,
    vts.total_quantity,
    -- tạo mô tả rút gọn
    case
		when length(pl.textDescription) > 30 then concat(left(pl.textDescription, 30), '...')
        else pl.textDescription
	end as description_snippet,
    -- tính doanh thu mỗi sản phẩm
    case
		when vts.total_quantity > 1000 then (vts.total_sales / vts.total_quantity) * 1.1
        when vts.total_quantity between 500 and 1000 then vts.total_sales / vts.total_quantity
        else (vts.total_sales / vts.total_quantity) * 0.9
	end as sales_per_product
from view_total_sales vts
join productlines pl on vts.productLine = pl.productLine
where vts.total_sales > 2000000
order by vts.total_sales desc;