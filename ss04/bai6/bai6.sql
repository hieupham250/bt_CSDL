create database employee_management;

-- 2
create table Department(
	department_id int primary key auto_increment,
    department_name varchar(50) not null unique,
    address varchar(50) not null
);

create table Employee(
	employee_id char(4) primary key,
    employee_name varchar(50) not null,
    date_of_birth date,
    sex bit not null check(sex in (0, 1)),
    base_salary int not null check(base_salary > 0),
    phone_number char(11) not null unique
);

-- 3
alter table Employee
add column department_id int not null,
add constraint fk_employee_department foreign key (department_id) references Department(department_id); 

-- 4
insert into Department(
	department_name, address
) values
	('Phòng Kinh Doanh', 'Hà Nội'),
	('Phòng Kế Toán', 'TP. Hồ Chí Minh'),
	('Phòng IT', 'Đà Nẵng'),
	('Phòng Nhân Sự', 'Hải Phòng'),
	('Phòng Marketing', 'Cần Thơ');

insert into Employee(
	employee_id, employee_name, date_of_birth, sex, base_salary, phone_number, department_id
) values
	('E001', 'Nguyễn Minh Nhật', '2004-12-11', 1, 4000000, '0987836473', 1),
	('E002', 'Đồ Đức Long', '2004-01-12', 1, 3500000, '0982378673', 2),
	('E003', 'Mai Tiến Linh', '2004-02-03', 1, 3500000, '0976734562', 3),
	('E004', 'Nguyễn Ngọc Ánh', '2004-10-04', 0, 5000000, '0987352772', 1),
	('E005', 'Phạm Minh Sơn', '2003-03-12', 1, 4000000, '0987236568', 4),
	('E006', 'Nguyễn Ngọc Minh', '2003-11-11', 0, 5000000, '0928864736', 5),
	('E007', 'Hoàng Văn Bình', '2002-08-22', 1, 4500000, '0987654321', 3),
	('E008', 'Trần Thị Thanh', '2001-09-15', 0, 4200000, '0912345678', 2),
	('E009', 'Lê Hữu Phước', '1999-06-30', 1, 6000000, '0976543210', 5),
	('E010', 'Phan Ngọc Huy', '2000-07-20', 1, 5500000, '0965432109', 1);

-- 5
-- cách 1:
alter table Employee drop foreign key fk_employee_department;
delete from Department where department_id = 1;

-- cách 2:
alter table Employee drop foreign key fk_employee_department;
alter table Employee add constraint fk_employee_department foreign key (department_id) 
references Department(department_id) on delete cascade;
-- 6
update Department 
set department_name = 'Phòng Kinh Doanh & Tiếp Thị'
where department_id = 1;

-- 7
select * from Employee;
select * from Department;