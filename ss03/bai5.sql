create database bai5;

-- 1
create table Employees(
	employee_id int primary key auto_increment,
    employee_name varchar(255) not null,
    email varchar(255) not null unique,
    department varchar(100) not null,
    salary decimal(10,2) check (salary > 0)
);

-- 2
insert into Employees(
	employee_name, email, department, salary
) values
	('Nguyen Van A', 'nguyenvana@example.com', 'Sales', 50000.00),
    ('Le Thi B', 'lethib@example.com', 'IT', 60000.00),
    ('Tran Van C', 'tranvanc@example.com', 'HR', 45000.00),
    ('Pham Thi D', 'phamthid@example.com', 'Marketing', 55000.00);
    
-- 3
select * from Employees where department = 'Sales';

select * from Employees;

-- 4
update Employees set salary = salary * 1.10 where department = 'Marketing';