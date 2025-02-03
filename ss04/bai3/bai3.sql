-- 1
create database customer_mangement;

-- 2
create table Customers(
	customer_id int primary key auto_increment,
    customer_name varchar(50) not null,
    birthday date not null,
    sex bit not null check (sex in (0, 1)),
    job varchar(50),
    phone_number char(11) not null unique,
    email varchar(100) not null unique,
    address varchar(255) not null
);

-- 3
insert into Customers(
	customer_name, birthday, sex, job, phone_number, email, address
) values
	('Nguyen Van A', '1990-05-12', 1, 'Kỹ sư', '0912345678', 'a.nguyen@example.com', 'Hà Nội'),
    ('Tran Thi B', '1995-03-18', 0, 'Giáo viên', '0919876543', 'b.tran@example.com', 'Hồ Chí Minh'),
    ('Le Van C', '1988-07-22', 1, 'Lập trình viên', '0923456789', 'c.le@example.com', 'Đà Nẵng'),
    ('Pham Thi D', '1993-09-15', 0, 'Nhân viên kinh doanh', '0934567890', 'd.pham@example.com', 'Cần Thơ'),
    ('Hoang Van E', '1985-01-05', 1, 'Kiến trúc sư', '0945678901', 'e.hoang@example.com', 'Hải Phòng'),
    ('Do Thi F', '1998-11-25', 0, 'Nhân viên văn phòng', '0956789012', 'f.do@example.com', 'Vũng Tàu'),
    ('Nguyen Van G', '1991-04-30', 1, 'Quản lý dự án', '0967890123', 'g.nguyen@example.com', 'Huế'),
    ('Pham Thi H', '1996-08-10', 0, 'Kế toán', '0978901234', 'h.pham@example.com', 'Đồng Nai'),
    ('Bui Van I', '1992-12-20', 1, 'Nhà báo', '0989012345', 'i.bui@example.com', 'Bắc Ninh'),
    ('Tran Thi K', '1999-06-08', 0, 'Designer', '0990123456', 'k.tran@example.com', 'Quảng Ninh');

-- 4
update Customers set customer_name = 'Nguyễn Quang Nhật', birthday = '2004-01-11' where customer_id = 1;

-- 5
set sql_safe_updates = 0;
delete from Customers where month(birthday) = 8;

-- 6
select c.customer_id, c.customer_name, c.birthday, c.sex, c.phone_number from Customers c where c.birthday = '2000-01-01';

-- 7
select c.customer_id, c.customer_name, c.birthday, c.sex, c.phone_number from Customers c where c.job is null;