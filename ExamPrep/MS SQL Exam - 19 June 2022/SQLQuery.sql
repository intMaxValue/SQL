CREATE DATABASE Zoo;

USE Zoo;

CREATE TABLE Owners (
    Id INT IDENTITY PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    PhoneNumber VARCHAR(15) NOT NULL,
    Address VARCHAR(50)
);

CREATE TABLE AnimalTypes (
    Id INT IDENTITY PRIMARY KEY,
    AnimalType VARCHAR(30) NOT NULL
);

CREATE TABLE Cages (
    Id INT IDENTITY PRIMARY KEY,
    AnimalTypeId INT NOT NULL FOREIGN KEY REFERENCES AnimalTypes(Id)
);

CREATE TABLE Animals (
    Id INT IDENTITY PRIMARY KEY,
    Name VARCHAR(30) NOT NULL,
    BirthDate DATE NOT NULL,
    OwnerId INT FOREIGN KEY REFERENCES Owners(Id),
    AnimalTypeId INT NOT NULL FOREIGN KEY REFERENCES AnimalTypes(Id)
);

CREATE TABLE AnimalsCages (
    CageId INT FOREIGN KEY REFERENCES Cages(Id) NOT NULL,
    AnimalId INT FOREIGN KEY REFERENCES Animals(Id) NOT NULL,
    PRIMARY KEY (CageId, AnimalId),
);

CREATE TABLE VolunteersDepartments (
    Id INT IDENTITY PRIMARY KEY,
    DepartmentName VARCHAR(30) NOT NULL
);

CREATE TABLE Volunteers (
    Id INT IDENTITY PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    PhoneNumber VARCHAR(15) NOT NULL,
    Address VARCHAR(50),
    AnimalId INT FOREIGN KEY REFERENCES Animals(Id),
    DepartmentId INT NOT NULL FOREIGN KEY REFERENCES VolunteersDepartments(Id)
);

GO


INSERT INTO Volunteers (Name, PhoneNumber, Address, AnimalId, DepartmentId)
VALUES
('Anita Kostova', '0896365412', 'Sofia, 5 Rosa str.', 15, 1),
('Dimitur Stoev', '0877564223', NULL, 42, 4),
('Kalina Evtimova', '0896321112', 'Silistra, 21 Breza str.', 9, 7),
('Stoyan Tomov', '0898564100', 'Montana, 1 Bor str.', 18, 8),
('Boryana Mileva', '0888112233', NULL, 31, 5);



INSERT INTO Animals (Name, BirthDate, OwnerId, AnimalTypeId)
VALUES
('Giraffe', '2018-09-21', 21, 1),
('Harpy Eagle', '2015-04-17', 15, 3),
('Hamadryas Baboon', '2017-11-02', NULL, 1),
('Tuatara', '2021-06-30', 2, 4);


UPDATE Animals
   SET OwnerId = 4
 WHERE OwnerId IS NULL

 DELETE FROM Volunteers
	   WHERE DepartmentId = 2
 DELETE FROM VolunteersDepartments
	   WHERE Id = 2




SELECT Name,
	   PhoneNumber,
	   Address,
	   AnimalId,
	   DepartmentId
  FROM Volunteers
ORDER BY Name, AnimalId, DepartmentId


SELECT
		a.Name AS Name,
		at.AnimalType AS AnimalType,
		CONVERT(NVARCHAR(10), a.BirthDate, 104) AS BirthDate
FROM Animals a
INNER JOIN AnimalTypes at ON a.AnimalTypeId = at.Id
ORDER BY a.Name ASC;


SELECT TOP 5 o.Name,
	   COUNT(*) AS CountOfAnimals
  FROM Owners AS o
  JOIN Animals AS a ON o.Id = a.OwnerId
GROUP BY o.Name
ORDER BY CountOfAnimals DESC


SELECT
    CONCAT(o.Name, '-', a.Name) AS OwnersAnimals,
    o.PhoneNumber,
    ac.CageId
FROM Owners o
JOIN Animals a ON o.Id = a.OwnerId
JOIN AnimalTypes AS [at] ON a.AnimalTypeId = at.Id
JOIN AnimalsCages ac ON a.Id = ac.AnimalId
WHERE a.AnimalTypeId = 1
ORDER BY o.Name ASC, a.Name DESC;


SELECT
		Name,
		PhoneNumber,
		SUBSTRING(Address, CHARINDEX(',', Address) + 2, LEN(Address)) AS Address
  FROM Volunteers
 WHERE DepartmentId = 2
       AND CHARINDEX('Sofia', Address) > 0
ORDER BY Name ASC;


SELECT
    a.Name AS Name,
    YEAR(a.BirthDate) AS BirthYear,
    at.AnimalType AS AnimalType
FROM Animals a
INNER JOIN AnimalTypes at ON a.AnimalTypeId = at.Id
WHERE a.OwnerId IS NULL
    AND at.AnimalType <> 'Birds'
    AND DATEDIFF(YEAR, a.BirthDate, '2022-01-01') < 5
ORDER BY a.Name;

GO

CREATE FUNCTION udf_GetVolunteersCountFromADepartment 
				(@VolunteersDepartment VARCHAR(30))
    RETURNS INT
	         AS
		  BEGIN
				DECLARE @result INT =
								(SELECT COUNT(*)
								  FROM VolunteersDepartments AS vd
								  JOIN Volunteers AS v 
									ON vd.Id = v.DepartmentId
								 WHERE DepartmentName = @VolunteersDepartment)
				RETURN @result
		    END


