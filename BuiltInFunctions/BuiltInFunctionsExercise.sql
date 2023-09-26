--SOFTUNI DATABASE

SELECT FirstName, LastName
FROM Employees
WHERE FirstName like 'Sa%'


SELECT FirstName, LastName
FROM Employees
WHERE LastName like '%ei%'


SELECT FirstName
FROM Employees
WHERE DepartmentID IN (3, 10) AND YEAR(HireDate) BETWEEN 1995 AND 2005


SELECT FirstName, LastName
FROM Employees
WHERE JobTitle NOT LIKE '%engineer%'


SELECT [Name]
FROM Towns
WHERE LEN([Name]) IN (5,6)
ORDER BY [Name]


SELECT *
FROM Towns
WHERE LEFT([Name], 1) IN ('M','K','B','E')
ORDER BY [Name]


SELECT *
FROM Towns
WHERE LEFT([Name], 1) NOT IN ('R','B','D')
ORDER BY [Name]


CREATE VIEW V_EmployeesHiredAfter2000 AS
SELECT FirstName, LastName
FROM Employees
WHERE YEAR(HireDate) > 2000


SELECT FirstName, LastName
FROM Employees
WHERE LEN(LastName) = 5


SELECT	*
FROM
	(SELECT EmployeeID
		  ,FirstName
		  ,LastName
		  ,Salary
		  ,DENSE_RANK() OVER (PARTITION BY Salary ORDER BY EmployeeID) AS [Rank]
	FROM Employees
	WHERE Salary BETWEEN 10000 AND 50000
	) AS T
WHERE [Rank] = 2
ORDER BY Salary DESC


--GEOGRAPHY DATABASE

SELECT CountryName, IsoCode
FROM Countries
WHERE CountryName LIKE '%a%a%a%'
ORDER BY IsoCode



SELECT PeakName, RiverName,
	   LOWER(CONCAT(LEFT(P.PeakName, LEN(P.PeakName) -1) , r.RiverName)) AS Mix
FROM Peaks AS P, Rivers AS R
WHERE RIGHT(P.PeakName, 1) = LEFT(R.RiverName, 1)
ORDER BY Mix


--DIABLO DATABASE

SELECT TOP(50) [Name], FORMAT([Start], 'yyyy-MM-dd') AS [Start]
FROM Games
WHERE YEAR(Start) IN (2011, 2012)
ORDER BY [Start], [Name] 


SELECT Username,
	   SUBSTRING(Email, CHARINDEX('@', Email) + 1, LEN(Email)) AS [Email Provider]
FROM Users
ORDER BY [Email Provider], Username 


SELECT Username, IpAddress
FROM Users
WHERE IpAddress LIKE '___.1%.%.___'
ORDER BY Username


SELECT [Name] AS Game,
    CASE 
        WHEN DATEPART(HOUR, [Start]) >= 0 AND DATEPART(HOUR, [Start]) < 12 THEN 'Morning'
        WHEN DATEPART(HOUR, [Start]) >= 12 AND DATEPART(HOUR, [Start]) < 18 THEN 'Afternoon'
        WHEN DATEPART(HOUR, [Start]) >= 18 AND DATEPART(HOUR, [Start]) < 24 THEN 'Evening'
    END AS [Part of the Day],

	CASE 
        WHEN Duration <= 3 THEN 'Extra Short'
        WHEN Duration >= 4 AND Duration <= 6 THEN 'Short'
		WHEN Duration > 6 THEN 'Long'
		ELSE 'Extra Long'
    END AS [Duration] 
FROM Games
ORDER BY Game, Duration


--ORDERS DATABASE

SELECT
    ProductName,
    OrderDate,
    DATEADD(DAY, 3, OrderDate) AS PaymentDueDate,
    DATEADD(MONTH, 1, OrderDate) AS DeliveryDueDate
FROM
    Orders;

