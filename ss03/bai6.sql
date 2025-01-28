create database bai6;

-- 1
create table Books(
	book_id int primary key auto_increment,
    title varchar(255) not null,
    price decimal(10,2) not null,
    stock int not null
);

-- 2
insert into Books(
	title, price, stock
) values
	('To Kill a Mockingbird', 120.00, 10),
    ('1984', 90.00, 3),
    ('The Great Gatsby', 150.00, 20),
    ('Moby Dick', 200.00, 5),
    ('Pride and Prejudice', 50.00, 8);
    
-- 3
select * from Books where price > 100;

-- 4
set sql_safe_updates = 0; -- tắt chế độ an toàn trước khi xóa
delete from Books where title like '%Pride%';