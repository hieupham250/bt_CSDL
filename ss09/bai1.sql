create database bai1;

use bai1;

CREATE TABLE employees (
    employee_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    department VARCHAR(50),
    salary DECIMAL(10, 2) NOT NULL,
    manager_id INT NULL
);

INSERT INTO employees (name, department, salary, manager_id) VALUES
('Alice', 'Sales', 6000, NULL),         
('Bob', 'Marketing', 7000, NULL),     
('Charlie', 'Sales', 5500, 1),         
('David', 'Marketing', 5800, 2),       
('Eva', 'HR', 5000, 3),                
('Frank', 'IT', 4500, 1),              
('Grace', 'Sales', 7000, 3),           
('Hannah', 'Marketing', 5200, 2),     
('Ian', 'IT', 6800, 3),               
('Jack', 'Finance', 3000, 1);  

-- 2
create view view_high_salary_employees as
select employee_id, name, salary
from employees;

-- 3
select * from view_high_salary_employees;

-- 4
INSERT INTO employees (name, department, salary, manager_id) VALUES
('Kenvin', 'Sales', 5000, NULL);
select * from view_high_salary_employees;

-- 5
delete from view_high_salary_employees where employee_id = 11;
select * from view_high_salary_employees;