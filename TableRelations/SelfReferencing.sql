create table Teachers(
		TeacherID int primary key identity(101,1),
		[Name] nvarchar(50) not null,
		ManagerID int foreign key references Teachers(TeacherID),

)

insert into Teachers
values
		('John', null),
		('Maya', 106),
		('Silvia', 106),
		('Ted', 105),
		('Mark', 101),
		('Greta', 101)