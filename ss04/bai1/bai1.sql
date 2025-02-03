create database bai1;

create table Rooms(
	room_id int primary key auto_increment,
    room_name varchar(255),
    manager_name varchar(255)
);

create table Computers(
	computer_id int primary key auto_increment,
    room_id int,
    computer_CPU varchar(255)not null,
    computer_RAM int not null,
    computer_storage int not null,
    foreign key (room_id) references Room(room_id)
);

create table Subjects(
	subject_id int primary key auto_increment,
    subject_name varchar(255) not null,
    duration int not null
);

create table Registrations(
	room_id int,
	subject_id int,
    registration_date datetime not null,
    foreign key (room_id) references Room(room_id),
    foreign key (subject_id) references Subjects(subject_id)
);