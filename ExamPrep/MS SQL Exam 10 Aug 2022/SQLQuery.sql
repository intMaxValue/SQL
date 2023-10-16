CREATE DATABASE NationalTouristSitesOfBulgaria

USE NationalTouristSitesOfBulgaria


CREATE TABLE Categories (
	Id INT PRIMARY KEY IDENTITY,
	Name VARCHAR(50) NOT NULL
);

CREATE TABLE Locations (
	Id INT PRIMARY KEY IDENTITY,
	Name VARCHAR(50) NOT NULL,
	Municipality VARCHAR(50),
	Province VARCHAR(50)
);

CREATE TABLE Sites (
	Id INT PRIMARY KEY IDENTITY,
	Name VARCHAR(100) NOT NULL,
	LocationId INT NOT NULL FOREIGN KEY REFERENCES Locations(Id),
	CategoryId INT NOT NULL FOREIGN KEY REFERENCES Categories(Id),
	Establishment VARCHAR(15)
);

CREATE TABLE Tourists (
	Id INT PRIMARY KEY IDENTITY,
	Name VARCHAR(50) NOT NULL,
	Age INT NOT NULL
	CHECK (Age >= 0 AND Age <= 120),
	PhoneNumber VARCHAR(20) NOT NULL,
	Nationality VARCHAR(30) NOT NULL,
	Reward VARCHAR(20)
);

CREATE TABLE SitesTourists (
	TouristId INT FOREIGN KEY REFERENCES Tourists(Id) NOT NULL,
	SiteId INT FOREIGN KEY REFERENCES Sites(Id) NOT NULL,
	PRIMARY KEY(TouristId, SiteId)
);

CREATE TABLE BonusPrizes (
	Id INT PRIMARY KEY IDENTITY,
	Name VARCHAR(50) NOT NULL
);

CREATE TABLE TouristsBonusPrizes (
	TouristId INT FOREIGN KEY REFERENCES Tourists(Id) NOT NULL,
	BonusPrizeId INT FOREIGN KEY REFERENCES BonusPrizes(Id) NOT NULL,
	PRIMARY KEY(TouristId, BonusPrizeId)
);




INSERT INTO Tourists(Name,Age,PhoneNumber,Nationality,Reward) VALUES
('Borislava Kazakova', 52, '+359896354244', 'Bulgaria', NULL),
('Peter Bosh', 48, '+447911844141', 'UK', NULL),
('Martin Smith', 29, '+353863818592', 'Ireland', 'Bronze badge'),
('Svilen Dobrev', 49, '+359986584786', 'Bulgaria', 'Silver badge'),
('Kremena Popova', 38, '+359893298604', 'Bulgaria', NULL)

INSERT INTO Sites (Name, LocationId, CategoryId, Establishment)
VALUES
('Ustra fortress', 90, 7, 'X'),
('Karlanovo Pyramids', 65, 7, NULL),
('The Tomb of Tsar Sevt', 63, 8, 'V BC'),
('Sinite Kamani Natural Park', 17, 1, NULL),
('St. Petka of Bulgaria – Rupite', 92, 6, '1994');


UPDATE Sites
SET Establishment = 'not defined' WHERE Establishment IS NULL


DELETE FROM TouristsBonusPrizes WHERE BonusPrizeId = 5;
DELETE FROM BonusPrizes WHERE Id = 5;


SELECT Name,
	   Age,
	   PhoneNumber,
	   Nationality
FROM Tourists
ORDER BY Nationality, Age DESC, Name


SELECT s.Name AS Site,
	   l.Name AS Location,
	   s.Establishment,
	   c.Name AS Category
FROM Sites AS s
	 LEFT JOIN Locations AS l ON s.LocationId = l.Id
	 LEFT JOIN Categories AS c ON s.CategoryId = c.Id
ORDER BY c.Name DESC, l.Name, s.Name


SELECT
    l.Province,
    l.Municipality,
    l.Name AS Location,
    COUNT(s.Id) AS CountOfSites
FROM Locations AS l
JOIN Sites AS s ON l.Id = s.LocationId
WHERE l.Province = 'Sofia' 
GROUP BY l.Name, l.Municipality, l.Province
ORDER BY CountOfSites DESC, l.Name ASC;


SELECT s.Name AS Site,
	   l.Name AS Location,
	   l.Municipality,
	   l.Province,
	   s.Establishment
  FROM Sites AS s
       LEFT JOIN Locations AS l ON s.LocationId = l.Id
 WHERE (LEFT(l.Name, 1) NOT IN ('B', 'M', 'D')) AND RIGHT(s.Establishment, 2) = 'BC'
 ORDER BY s.Name


SELECT t.Name,
	   Age,
	   PhoneNumber,
	   Nationality,
	   CASE
		    WHEN bp.Name IS NULL THEN '(no bonus prize)'
			ELSE bp.Name 
	   END AS Reward
  FROM Tourists AS t
       LEFT JOIN TouristsBonusPrizes AS tbp ON t.Id = tbp.TouristId
	   LEFT JOIN BonusPrizes AS bp ON tbp.BonusPrizeId = bp.Id
ORDER BY t.Name


SELECT
    SUBSTRING(Name, CHARINDEX(' ', Name) + 1, LEN(Name) - CHARINDEX(' ', Name)) AS LastName,
    Nationality,
    Age,
    PhoneNumber
FROM Tourists
WHERE Id IN (
    SELECT DISTINCT TouristId
    FROM SitesTourists
    WHERE SiteId IN (
        SELECT Id
        FROM Sites
        WHERE CategoryId IN (
            SELECT Id
            FROM Categories
            WHERE Name = 'History and archaeology'
        )
    )
)
ORDER BY LastName ASC;


GO

CREATE FUNCTION udf_GetTouristsCountOnATouristSite (@Site VARCHAR(100))
RETURNS INT
AS
BEGIN
		DECLARE @result INT = (
								SELECT COUNT(*)
								  FROM Tourists AS t
								  JOIN SitesTourists AS st 
									ON t.Id = st.TouristId
								  JOIN Sites AS s 
									ON st.SiteId = s.Id
								 WHERE s.Name = @Site)
		RETURN @result
END

GO

SELECT dbo.udf_GetTouristsCountOnATouristSite ('Regional History Museum – Vratsa')

GO

CREATE OR ALTER PROCEDURE usp_AnnualRewardLottery
    @TouristName VARCHAR(50)
AS
BEGIN
    DECLARE @Reward NVARCHAR(20);

    DECLARE @SitesVisited INT;
    SELECT @SitesVisited = COUNT(*) 
    FROM SitesTourists st
    INNER JOIN Tourists t ON st.TouristId = t.Id
    WHERE t.Name = @TouristName;

    IF @SitesVisited >= 100
        SET @Reward = 'Gold badge';
    ELSE IF @SitesVisited >= 50
        SET @Reward = 'Silver badge';
    ELSE IF @SitesVisited >= 25
        SET @Reward = 'Bronze badge';
    ELSE
        SET @Reward = NULL;

    --UPDATE Tourists
    --SET Reward = @Reward
    --WHERE Name = @TouristName;

    SELECT Name, @Reward AS Reward
	  FROM Tourists
	  WHERE Name = @TouristName;
END

EXEC usp_AnnualRewardLottery 'Teodor Petrov'

