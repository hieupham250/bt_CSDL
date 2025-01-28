create database bai7;

-- 1
create table Students(
	student_id int primary key auto_increment,
    student_name varchar(255) not null,
    email varchar(255) not null unique,
    date_of_birth date not null,
    gender varchar(10) check(gender in ('Male', 'Female', 'Other')) not null,
    gpa decimal(3,2) check (gpa >= 0 and gpa <= 4)
);

-- 2
insert into Students(
	student_name, email, date_of_birth, gender, gpa
) values
	('Nguyen Van A', 'nguyenvana@example.com', '2000-05-15', 'Male', 3.50),
    ('Tran Thi B', 'tranthib@example.com', '1999-08-22', 'Female', 3.80),
    ('Le Van C', 'levanc@example.com', '2001-01-10', 'Male', 2.70),
    ('Pham Thi D', 'phamthid@example.com', '1998-12-05', 'Female', 3.00),
    ('Hoang Van E', 'hoangvane@example.com', '2000-03-18', 'Male', 3.60),
    ('Do Thi F', 'dothif@example.com', '2001-07-25', 'Female', 4.00),
    ('Vo Van G', 'vovang@example.com', '2000-11-30', 'Male', 3.20),
    ('Nguyen Thi H', 'nguyenthih@example.com', '1999-09-15', 'Female', 2.90),
    ('Bui Van I', 'buivani@example.com', '2002-02-28', 'Male', 3.40),
    ('Tran Thi J', 'tranthij@example.com', '2001-06-12', 'Female', 3.75);

-- 3
select * from Students where gpa > 3.0 and gender = 'Female';

-- 4
select * from Students where date_of_birth > '2000-01-01' order by gpa desc limit 1;

-- 5
select * from Students where date_of_birth = (select date_of_birth from Students where student_id = 1);

-- 6
update Students set gpa = least(gpa + 0.5, 4.0) where gpa < 2.5;

-- 7
update Students set gender = 'Other' where email like 'test';

-- 8
delete from Students where student_id = (select student_id from (select student_id from Students order by date_of_birth asc limit 1) as temp);

-- 9
select student_name, floor(datediff(curdate(), date_of_birth) / 365) as age from Students;

