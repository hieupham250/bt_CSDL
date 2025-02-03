create database film_management;

create table Categorys(
	category_id int primary key auto_increment,
    category_name varchar(50) not null,
    category_description text,
    status bit not null check (status in (0, 1))
);

create table Films(
	film_id int primary key auto_increment,
    film_name varchar(50) not null,
    content text not null,
    duration time not null,
    director varchar(50),
    release_date date not null
);

create table Category_Films(
	category_id int,
    film_id int,
    primary key (category_id, film_id)
);

-- 4
alter table Category_Films
add constraint fk_category foreign key (category_id) references Categorys(category_id),
add constraint fk_film foreign key (film_id) references Films(film_id);

-- 5
alter table Films add status tinyint default 1;

-- 6
alter table Categorys drop column status;

-- 7
alter table Category_Films 
drop foreign key fk_category,
drop foreign key fk_film;

