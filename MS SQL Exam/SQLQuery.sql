CREATE DATABASE TouristAgency 

GO

USE TouristAgency 
GO


CREATE TABLE Countries (
    Id INT PRIMARY KEY IDENTITY,
    Name VARCHAR(50) NOT NULL
);

CREATE TABLE Destinations (
    Id INT PRIMARY KEY IDENTITY,
    Name VARCHAR(50) NOT NULL,
    CountryId INT NOT NULL FOREIGN KEY REFERENCES Countries(Id)
);

CREATE TABLE Rooms (
    Id INT PRIMARY KEY IDENTITY,
    Type VARCHAR(40) NOT NULL,
    Price DECIMAL(18, 2) NOT NULL,
    BedCount INT NOT NULL CHECK (BedCount > 0 AND BedCount <= 10)
);

CREATE TABLE Hotels (
    Id INT PRIMARY KEY IDENTITY,
    Name VARCHAR(50) NOT NULL,
    DestinationId INT NOT NULL FOREIGN KEY REFERENCES Destinations(Id)
);

CREATE TABLE Tourists (
    Id INT PRIMARY KEY IDENTITY,
    Name NVARCHAR(80) NOT NULL,
    PhoneNumber VARCHAR(20) NOT NULL,
    Email VARCHAR(80) NULL,
    CountryId INT NOT NULL FOREIGN KEY REFERENCES Countries(Id)
);

CREATE TABLE Bookings (
    Id INT PRIMARY KEY IDENTITY,
    ArrivalDate DATETIME2 NOT NULL,
    DepartureDate DATETIME2 NOT NULL,
    AdultsCount INT NOT NULL CHECK (AdultsCount >= 1 AND AdultsCount <= 10),
    ChildrenCount INT NOT NULL CHECK (ChildrenCount >= 0 AND ChildrenCount <= 9),
    TouristId INT NOT NULL FOREIGN KEY REFERENCES Tourists(Id),
    HotelId INT NOT NULL FOREIGN KEY REFERENCES Hotels(Id),
    RoomId INT NOT NULL FOREIGN KEY REFERENCES Rooms(Id)
);

CREATE TABLE HotelsRooms (
    HotelId INT NOT NULL FOREIGN KEY REFERENCES Hotels(Id),
    RoomId INT NOT NULL FOREIGN KEY REFERENCES Rooms(Id),
    PRIMARY KEY (HotelId, RoomId)
);


INSERT INTO Tourists (Name, PhoneNumber, Email, CountryId)
VALUES
    ('John Rivers', '653-551-1555', 'john.rivers@example.com', 6),
    ('Adeline Aglaé', '122-654-8726', 'adeline.aglae@example.com', 2),
    ('Sergio Ramirez', '233-465-2876', 's.ramirez@example.com', 3),
    ('Johan Müller', '322-876-9826', 'j.muller@example.com', 7),
    ('Eden Smith', '551-874-2234', 'eden.smith@example.com', 6);


INSERT INTO Bookings (ArrivalDate, DepartureDate, AdultsCount, ChildrenCount, TouristId, HotelId, RoomId)
VALUES
    ('2024-03-01', '2024-03-11', 1, 0, 21, 3, 5),
    ('2023-12-28', '2024-01-06', 2, 1, 22, 13, 3),
    ('2023-11-15', '2023-11-20', 1, 2, 23, 19, 7),
    ('2023-12-05', '2023-12-09', 4, 0, 24, 6, 4),
    ('2024-05-01', '2024-05-07', 6, 0, 25, 14, 6);


UPDATE Bookings
   SET DepartureDate = DATEADD(day, 1, DepartureDate)
 WHERE ArrivalDate >= '2023-12-01' AND ArrivalDate <= '2023-12-31';


UPDATE Tourists
   SET Email = NULL
 WHERE Name LIKE '%MA%';


SELECT *
  FROM Tourists
 WHERE [Name] LIKE '%Smith'

 SELECT *
 FROM Bookings
 WHERE TouristId IN (6,16,25)

DELETE
  FROM Bookings
 WHERE TouristId IN (6, 16, 25)

DELETE 
  FROM Tourists
 WHERE [Name] LIKE '%Smith'


  SELECT FORMAT(b.ArrivalDate, 'yyyy-MM-dd') AS ArrivalDate,
         b.AdultsCount,
         b.ChildrenCount
    FROM
         Bookings AS b
    JOIN
         Rooms AS r ON b.RoomId = r.Id
ORDER BY
         r.Price DESC,
         ArrivalDate ASC;



SELECT h.Id, h.Name
FROM Hotels AS h
JOIN HotelsRooms AS hr ON h.Id = hr.HotelId
JOIN Rooms AS r ON hr.RoomId = r.Id
JOIN Bookings AS b ON h.Id = b.HotelId
WHERE r.Type = 'VIP Apartment'
GROUP BY h.Id, h.Name
ORDER BY COUNT(b.Id) DESC;



SELECT t.Id, t.Name, t.PhoneNumber
FROM Tourists AS t
LEFT JOIN Bookings AS b ON t.Id = b.TouristId
WHERE b.Id IS NULL
ORDER BY t.Name;



  SELECT TOP 10
		 h.Name AS HotelName,
		 d.Name AS DestinationName,
		 c.Name AS CountryName
	FROM Bookings AS b
	JOIN Hotels AS h ON b.HotelId = h.Id
	JOIN Destinations AS d ON h.DestinationId = d.Id
	JOIN Countries AS c ON d.CountryId = c.Id
   WHERE b.ArrivalDate < '2023-12-31' AND h.Id % 2 = 1
ORDER BY c.Name, b.ArrivalDate


   SELECT h.Name AS HotelName,
          r.Price AS RoomPrice
     FROM Tourists AS t
     JOIN Bookings AS b ON t.Id = b.TouristId
     JOIN Hotels AS h ON b.HotelId = h.Id
     JOIN Rooms AS r ON b.RoomId = r.Id
    WHERE t.Name NOT LIKE '%EZ'
 ORDER BY r.Price DESC



  SELECT h.Name AS HotelName,
         SUM(DATEDIFF(DAY, b.ArrivalDate, b.DepartureDate) * r.Price) 
		 AS TotalRevenue
    FROM Bookings AS b
    JOIN Hotels AS h ON b.HotelId = h.Id
    JOIN Rooms AS r ON b.RoomId = r.Id
GROUP BY h.Name
ORDER BY TotalRevenue DESC


CREATE FUNCTION udf_RoomsWithTourists(@name NVARCHAR(40))
    RETURNS INT
             AS
		  BEGIN
				DECLARE @TotalTourists INT;

				SELECT @TotalTourists = SUM(AdultsCount + ChildrenCount)
				FROM Bookings AS b
				JOIN Rooms AS r ON b.RoomId = r.Id
				WHERE r.Type = @name

				RETURN @TotalTourists
		   END

SELECT dbo.udf_RoomsWithTourists('Double Room')





GO

CREATE PROCEDURE usp_SearchByCountry(@country NVARCHAR(50))
              AS
           BEGIN
				    SELECT t.Name,
				   	       t.PhoneNumber,
				   	       t.Email,
				 	       COUNT(b.Id) AS CountOfBookings
				      FROM Tourists AS t
				 LEFT JOIN Bookings AS b ON t.Id = b.TouristId
				     WHERE t.CountryId = (SELECT Id FROM Countries WHERE Name = @country)
				  GROUP BY t.Name, t.PhoneNumber, t.Email
				  ORDER BY t.Name, CountOfBookings DESC
             END
