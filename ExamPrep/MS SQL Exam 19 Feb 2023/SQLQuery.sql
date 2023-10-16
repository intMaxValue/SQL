CREATE DATABASE Boardgames;

USE Boardgames;

CREATE TABLE Categories (
    Id INT PRIMARY KEY IDENTITY,
    Name NVARCHAR(50) NOT NULL
);

CREATE TABLE Addresses (
    Id INT PRIMARY KEY IDENTITY,
    StreetName NVARCHAR(100) NOT NULL,
    StreetNumber INT NOT NULL,
    Town NVARCHAR(30) NOT NULL,
    Country NVARCHAR(50) NOT NULL,
    ZIP INT NOT NULL
);

CREATE TABLE Publishers (
    Id INT PRIMARY KEY IDENTITY,
    Name NVARCHAR(30) UNIQUE NOT NULL,
    AddressId INT NOT NULL FOREIGN KEY REFERENCES Addresses(Id),
    Website NVARCHAR(40) NULL,
    Phone NVARCHAR(20) NULL
);

CREATE TABLE PlayersRanges (
    Id INT PRIMARY KEY IDENTITY,
    PlayersMin INT NOT NULL,
    PlayersMax INT NOT NULL
);

CREATE TABLE Boardgames (
    Id INT PRIMARY KEY IDENTITY,
    Name NVARCHAR(30) NOT NULL,
    YearPublished INT NOT NULL,
    Rating DECIMAL(10, 2) NOT NULL,
    CategoryId INT NOT NULL FOREIGN KEY REFERENCES Categories(Id),
    PublisherId INT NOT NULL FOREIGN KEY REFERENCES Publishers(Id),
    PlayersRangeId INT NOT NULL FOREIGN KEY REFERENCES PlayersRanges(Id)
);

CREATE TABLE Creators (
    Id INT PRIMARY KEY IDENTITY,
    FirstName NVARCHAR(30) NOT NULL,
    LastName NVARCHAR(30) NOT NULL,
    Email NVARCHAR(30) NOT NULL
);

CREATE TABLE CreatorsBoardgames (
    CreatorId INT NOT NULL FOREIGN KEY REFERENCES Creators(Id),
    BoardgameId INT NOT NULL FOREIGN KEY REFERENCES Boardgames(Id),
    PRIMARY KEY (CreatorId, BoardgameId)
);

GO

INSERT INTO Publishers (Name, AddressId, Website, Phone)
VALUES
    ('Agman Games', 5, 'www.agmangames.com', '+16546135542'),
    ('Amethyst Games', 7, 'www.amethystgames.com', '+15558889992'),
    ('BattleBooks', 13, 'www.battlebooks.com', '+12345678907');

INSERT INTO Boardgames (Name, YearPublished, Rating, CategoryId, PublisherId, PlayersRangeId)
VALUES
    ('Deep Blue', 2019, 5.67, 1, 15, 7),
    ('Paris', 2016, 9.78, 7, 1, 5),
    ('Catan: Starfarers', 2021, 9.87, 7, 13, 6),
    ('Bleeding Kansas', 2020, 3.25, 3, 7, 4),
    ('One Small Step', 2019, 5.75, 5, 9, 2);


UPDATE PlayersRanges
   SET PlayersMax += 1
 WHERE PlayersMin = 2 AND PlayersMax = 2

UPDATE Boardgames
   SET Name += 'V2'
 WHERE YearPublished >= 2020



DELETE 
  FROM CreatorsBoardgames
WHERE BoardgameId IN (1, 16, 31, 47)

DELETE 
  FROM Boardgames
 WHERE PublisherId IN (1, 16)

DELETE
  FROM Publishers
 WHERE AddressId = 5

DELETE
  FROM Addresses
 WHERE Id = 5;


SELECT Name,
	   Rating
  FROM Boardgames
ORDER BY YearPublished, Name DESC

SELECT b.Id,
	   b.Name,
	   b.YearPublished,
	   c.Name
  FROM Boardgames AS b
  JOIN Categories AS c
    ON b.CategoryId = c.Id
 WHERE c.Id IN (8, 6)
ORDER BY YearPublished DESC


SELECT
    C.Id,
    CONCAT(C.FirstName, ' ', C.LastName) AS CreatorName,
    C.Email
FROM Creators C
WHERE C.Id NOT IN (
    SELECT DISTINCT CB.CreatorId
    FROM CreatorsBoardgames CB
)
ORDER BY CreatorName ASC;


SELECT TOP 5
    B.Name,
    B.Rating,
    C.Name AS CategoryName
FROM Boardgames B
JOIN Categories C ON B.CategoryId = C.Id
WHERE
    (B.Name LIKE '%a%' OR B.Rating > 7.50)
    AND B.Rating > 7.00
    AND B.PlayersRangeId IN (
        SELECT Id
        FROM PlayersRanges
        WHERE PlayersMin >= 2 AND PlayersMax <= 5
    )
ORDER BY
    B.Name ASC,
    B.Rating DESC;


SELECT CONCAT(c.FirstName, ' ', c.LastName) AS 'FullName',
	   c.Email,
	   MAX(b.Rating)
  FROM Creators AS c
  JOIN CreatorsBoardgames AS cb ON c.Id = cb.CreatorId
  JOIN Boardgames AS b ON cb.BoardgameId = b.Id
WHERE c.Email LIKE '%.COM'
GROUP BY CONCAT(c.FirstName, ' ', c.LastName), c.Email


SELECT
    C.LastName,
    CEILING(AVG(B.Rating)) AS AverageRating,
    P.Name AS PublisherName
FROM Creators AS C
JOIN CreatorsBoardgames AS CB ON C.Id = CB.CreatorId
JOIN Boardgames AS B ON CB.BoardgameId = B.Id
JOIN Publishers AS P ON B.PublisherId = P.Id
WHERE P.Name = 'Stonemaier Games'
GROUP BY C.LastName, P.Name
ORDER BY AVG(B.Rating) DESC;

GO

CREATE FUNCTION udf_CreatorWithBoardgames(@name NVARCHAR(30))
	    RETURNS INT
		     AS
		  BEGIN
				DECLARE @result INT =
				(SELECT COUNT(*)
				  FROM Creators AS c
				  JOIN CreatorsBoardgames AS cb ON c.Id = cb.CreatorId
				  JOIN Boardgames AS b ON cb.BoardgameId = b.Id
				 WHERE c.FirstName = @name
				 )
				RETURN @result
		    END

GO

CREATE PROCEDURE usp_SearchByCategory
				 @category NVARCHAR(50)
			  AS
		   BEGIN
				 SELECT b.Name,
						b.YearPublished,
						b.Rating,
						c.Name AS CategoryName,
						p.Name AS PublisherName,
						CONCAT(pr.PlayersMin, ' ', 'people') as MinPlayers, 
						CONCAT(pr.PlayersMax, ' ', 'people') as MaxPlayers 
				   FROM Boardgames AS b
				   JOIN Categories AS c
				     ON b.CategoryId = c.Id
				   JOIN Publishers AS p
				     ON b.PublisherId = p.Id
				   JOIN PlayersRanges AS pr
				     ON b.PlayersRangeId = pr.Id
				  WHERE c.Name = @category
			   ORDER BY p.Name, b.YearPublished DESC
		     END