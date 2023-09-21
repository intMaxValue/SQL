CREATE TABLE [Towns](
			 [Id] INT IDENTITY PRIMARY KEY,
			 [Name] NVARCHAR(50) NOT NULL
)


CREATE TABLE [Addresses](
			 [Id] INT IDENTITY PRIMARY KEY,
			 [AddressText] NVARCHAR(255) NOT NULL,
			 [TownId] INT NOT NULL,

CONSTRAINT FK_Town FOREIGN KEY (TownId) REFERENCES Towns(Id)
)

CREATE TABLE [Departments](
			 [Id] INT IDENTITY PRIMARY KEY,
			 [Name] NVARCHAR(255) NOT NULL,
)

CREATE TABLE [Employees](
			 [Id] INT IDENTITY PRIMARY KEY,
			 [FirstName] NVARCHAR(50) NOT NULL,
			 [MiddleName] NVARCHAR(50),
			 [LastName] NVARCHAR(50) NOT NULL,
			 [JobTitle] NVARCHAR(50) NOT NULL,
			 [DepartmentId] INT NOT NULL,
			 [HireDate] DATE NOT NULL,
			 [Salary] DECIMAL(10,2) NOT NULL,
			 [AddressId] INT 

CONSTRAINT FK_DepartmentId FOREIGN KEY (DepartmentId) REFERENCES Departments(Id),
CONSTRAINT FK_AddressId FOREIGN KEY (AddressId) REFERENCES Addresses(Id)
)			 



INSERT INTO Towns(Name)
	 VALUES
			('Sofia'),
			('Plovdiv'),
			('Varna'),
			('Burgas')


INSERT INTO Departments(Name)
	 VALUES
			('Engineering'),
			('Sales'),
			('Marketing'),
			('Software Development'),
			('Quality Assurance')


INSERT INTO Employees (FirstName, MiddleName, LastName, JobTitle, DepartmentId, HireDate, Salary)
VALUES
    ('Ivan', 'Ivanov', 'Ivanov', '.NET Developer', 4, '2013-02-01', 3500.00),
    ('Petar', 'Petrov', 'Petrov', 'Senior Engineer', 1, '2004-03-02', 4000.00),
    ('Maria', 'Petrova', 'Ivanova', 'Intern', 5, '2016-08-28', 525.25),
    ('Georgi', 'Teziev', 'Ivanov', 'CEO', 2, '2007-12-09', 3000.00),
    ('Peter', 'Pan', 'Pan', 'Intern', 3, '2016-08-28', 599.88);






SELECT [Name] FROM Towns
ORDER BY [Name]


SELECT [Name] FROM Departments
ORDER BY [Name]


SELECT [FirstName], [LastName], [JobTitle], [Salary]
FROM Employees
ORDER BY [Salary] DESC



UPDATE Employees
SET Salary *= 1.10; 

SELECT Salary FROM Employees