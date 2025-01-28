create database bai3;

create table Students(
	student_id int primary key auto_increment,
    student_name varchar(255) not null,
    email varchar(255) not null unique,
    age int check (age > 0)
);

-- 1
insert into Students(
	student_name, email, age
) values
	('Nguyen Van A', 'nguyenvana@example.com', 22),
    ('Le Thi B', 'lethib@example.com', 20),
    ('Tran Van C', 'tranvanc@example.com', 23),
    ('Pham Thi D', 'phamthid@example.com', 21);
    
-- 2
delete from Students where student_id = 2;