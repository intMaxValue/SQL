-- AGGREGATE FUNCTIONS

SELECT 
	DepartmentID, 
	COUNT(*) 
FROM Employees 
GROUP BY DepartmentID
ORDER BY COUNT(*) DESC


SELECT
	DepartmentID,
	COUNT(*) AS Cnt
FROM Employees
GROUP BY DepartmentID  -- HAVING AFTER GROUP BY
HAVING COUNT(*) > 8
ORDER BY COUNT(*) DESC


SELECT 
	DepartmentID,
	AVG(Salary) AS AVRG
FROM Employees
GROUP BY DepartmentID
HAVING AVG(Salary) > 24000
 


--ANALYTIC FUNCTIONS

SELECT PERCENTILE_CONT(0.5) 
WITHIN GROUP (ORDER BY Salary DESC) 
OVER (PARTITION BY DepartmentID)
FROM Employees

--RANKING FUNCTIONS

SELECT ROW_NUMBER() OVER(ORDER BY Salary DESC) AS RowNumber
,* 
FROM Employees
WHERE DepartmentID = 5


SELECT ROW_NUMBER() OVER(ORDER BY Salary DESC) AS RowNumber
,FirstName
,LastName
,DENSE_RANK() OVER(ORDER BY Salary DESC) AS [DenseRank]
,RANK() OVER(ORDER BY Salary DESC) AS [Rank]
,NTILE(5) OVER(ORDER BY Salary DESC) AS FiveTile 
FROM Employees
WHERE DepartmentID = 5


SELECT
	DepartmentID
	,Salary
	,COUNT(*)
FROM Employees
GROUP BY DepartmentID, Salary
ORDER BY DepartmentID




SELECT * FROM OPENJSON('{"FirstName": "Kolyo", "LastName": "Kolev", "Age": 33, "Hobby": { "Name": "Running" }}');

DECLARE @SEPARATOR CHAR = ' ';

SELECT CONCAT(FirstName, @SEPARATOR, LastName)
FROM Employees

SELECT CONCAT_WS(' ', FirstName, LastName) AS [Full Name]
FROM Employees

SELECT SUBSTRING(FirstName, 1, 1)
FROM Employees

SELECT TRIM(' ' + FirstName + ' ') FROM Employees

SELECT RIGHT(FirstName, 3) FROM Employees

SELECT UPPER(REVERSE('pESHO'))

SELECT REPLICATE('*', LEN(FirstName))
FROM Employees

CREATE VIEW v_Employees AS
SELECT [EmployeeID]
      ,[FirstName]
      ,[LastName]
      ,[MiddleName]
      ,[JobTitle]
      ,[DepartmentID]
      ,[ManagerID]
      ,[HireDate]
      ,[Salary]
      ,[AddressID]
  FROM [SoftUni].[dbo].[Employees]

  SELECT * FROM v_Employees


  SELECT STUFF('Pesho', 4, 0, 'Gosho')


  --MATH FUNCTIONS

  SELECT PI()
  
  SELECT ABS(-55)

  SELECT SQRT(36)

  SELECT FORMAT(PI(), 'F2', 'BG-bg')
  SELECT FORMAT(PI(), 'C2', 'BG-bg') --CURRENCY
  
  SELECT ROUND(23.455335, 3)

  SELECT FLOOR(23.455335)
  SELECT CEILING(23.455335)


