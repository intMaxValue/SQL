create table Majors(
		MajorID int primary key,
		[Name] varchar(50)
)

create table Subjects(
		SubjectID int primary key,
		SubjectName nvarchar(50)
)

create table Students(
		StudentID int primary key,
		StudentNumber int,
		StudentName nvarchar(100),
		MajorID int
)
create table Payments(
		PaymentID int primary key,
		PaymentDate date,
		PaymentAmount decimal(8,2),
		StudentID int foreign key references Students(StudentID)
)



create table Agenda(
		StudentID int foreign key references Students(StudentID),
		SubjectID int foreign key references Subjects(SubjectID),
		primary key(StudentID, SubjectID)

)

ALTER TABLE Students
ADD FOREIGN KEY (MajorID) REFERENCES Majors(MajorID);

