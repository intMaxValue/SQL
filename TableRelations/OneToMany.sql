create table Manufacturers(
	ManufacturerID int primary key,
	[Name] nvarchar(50) not null,
	EstablishedOn datetime2
)

create table Models(
	ModelID int primary key identity(101,1),
	[Name] nvarchar(50) not null,
	ManufacturerID int foreign key references Manufacturers(ManufacturerID)
)


insert into Manufacturers
values
		(1, 'BMW', '07-03-1916'),
		(2, 'Tesla', '01-01-2003'),
		(3, 'Lada', '01-05-1966')

insert into Models
values
		('X1', 1),
		('i6', 1),
		('Model S', 2),
		('Model X', 2),
		('Model 3', 2),
		('Nova', 3)

