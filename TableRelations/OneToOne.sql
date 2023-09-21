
create table Passports(
	PassportID int primary key,
	PassportNumber nvarchar(50)
)


create table Persons(
	PersonID int primary key identity,
	FirstName nvarchar(50) not null,
	Salary decimal(8,2),
	PassportID int foreign key references Passports(PassportID)
)

insert into Passports
values
		(101, 'N34FG21B'),
		(102, 'K65LO4R7'),
		(103, 'ZE657QP2')

insert into Persons
values
		('Roberto', 43300.00, 102),
		('Tom', 56100.00, 103),
		('Roberto', 60200.00, 101)


