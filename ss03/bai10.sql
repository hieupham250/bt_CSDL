create database bai10;

-- 1
create table Students(
	student_id int primary key auto_increment,
    name varchar(255) not null,
    email varchar(255) not null unique,
    date_of_birth date not null
);

create table Enrollments(
	enrollment_id int primary key auto_increment,
    student_id int,
    course_name varchar(255) not null,
    enrollment_date date not null,
    foreign key (student_id) references Students(student_id)
);

-- 2
insert into Students(
	name, email, date_of_birth
) values
	('Nguyen Van A', 'nguyenvana@example.com', '2000-05-15'),
	('Tran Thi B', 'tranthib@example.com', '1999-08-22'),
	('Le Van C', 'levanc@example.com', '2001-01-10'),
	('Pham Thi D', 'phamthid@example.com', '1998-12-05'),
    ('Hoang Van E', 'hoangvane@example.com', '2002-03-18');

insert into Enrollments(
	student_id, course_name, enrollment_date
) values
	(1, 'Math 101', '2025-01-10'),
    (1, 'Physics 101', '2025-01-15'),
    (2, 'Chemistry 101', '2025-01-12'),
    (2, 'Biology 101', '2025-01-20'),
    (3, 'History 101', '2025-02-01'),
    (3, 'Geography 101', '2025-02-05'),
    (4, 'Computer Science 101', '2025-03-01'),
    (4, 'Programming Basics', '2025-03-10'),
    (5, 'English Literature', '2025-04-01'),
    (5, 'Creative Writing', '2025-04-05');
    
-- 3
select s.student_id, s.name, s.email, s.date_of_birth from Students s where name like '%Nguyen%' and date_of_birth >= '2000-01-01';

-- 4
set sql_safe_updates = 0;
update Students set email = 'updated_email@example.com' where name = 'Nguyen Van A';

-- 5
select e.enrollment_id, e.student_id, e.course_name, e.enrollment_date from Enrollments e where course_name like '%101%';

-- 6
delete from Enrollments where enrollment_date < '2025-02-01';