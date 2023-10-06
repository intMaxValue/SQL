CREATE PROCEDURE usp_GetEmployeesSalaryAbove35000 
			  AS
		   BEGIN
					SELECT FirstName
						   ,LastName
					FROM Employees
					WHERE Salary > 35000
		     END

EXEC [dbo].usp_GetEmployeesSalaryAbove35000

GO

CREATE PROCEDURE usp_GetEmployeesSalaryAboveNumber @number DECIMAL(18, 4)
			  AS
		   BEGIN
				 SELECT FirstName AS [First Name]
					    ,LastName AS [Last Name]
				   FROM Employees
				  WHERE Salary >= @number
		     END

EXEC usp_GetEmployeesSalaryAboveNumber 48100

GO


CREATE PROCEDURE usp_GetTownsStartingWith  @input NVARCHAR(50)
			  AS
		   BEGIN
				 SELECT t.Name AS Town
				   FROM Towns AS t
				  WHERE t.Name LIKE @inpuT + '%'
		     END

			EXEC usp_GetTownsStartingWith b

GO



CREATE PROCEDURE usp_GetEmployeesFromTown @townName NVARCHAR(50)
			  AS
		   BEGIN
		  SELECT FirstName AS [First Name]
				 ,LastName AS [Last Name]
		    FROM Employees AS e
		    JOIN Addresses AS a
			  ON e.AddressID = a.AddressID
		    JOIN Towns AS t
			  ON t.TownID = a.TownID
		   WHERE t.[Name] = @townName
		     END

			EXEC usp_GetEmployeesFromTown Sofia	

GO



CREATE FUNCTION ufn_GetSalaryLevel(@Salary DECIMAL(18,4)) 
RETURNS VARCHAR(10) AS 
BEGIN 
	DECLARE @SalaryLevel VARCHAR(10)
	IF(@Salary < 30000)
	BEGIN 
	 SET @SalaryLevel = 'Low'
	END
	ELSE IF(@Salary >= 30000 AND @Salary <= 50000)
	BEGIN
	 SET @SalaryLevel = 'Average'
	END
	ELSE 
	BEGIN 
	 SET @SalaryLevel = 'High'
	END
RETURN @SalaryLevel
END

SELECT * FROM ufn_GetSalaryLevel (13500.00)

GO



CREATE PROCEDURE usp_EmployeesBySalaryLevel
    @SalaryLevel VARCHAR(10)
AS
BEGIN
    DECLARE @NumericSalary DECIMAL(18, 4)

    IF @SalaryLevel = 'Low'
        SET @NumericSalary = 29999.9999 
    ELSE IF @SalaryLevel = 'Average'
        SET @NumericSalary = 50000.0001
    ELSE IF @SalaryLevel = 'High'
        SET @NumericSalary = 9999999999.9999

    SELECT
        FirstName,
        LastName
    FROM
        Employees
    WHERE
        [dbo].ufn_GetSalaryLevel(Salary) = @SalaryLevel;

END


GO


CREATE FUNCTION ufn_IsWordComprised
(
    @setOfLetters VARCHAR(255),
    @word VARCHAR(255)
)
RETURNS BIT
AS
BEGIN
    DECLARE @result BIT = 1;

    DECLARE @letter CHAR(1);
    DECLARE @pos INT = 1;

    WHILE @pos <= LEN(@word)
    BEGIN
        SET @letter = SUBSTRING(@word, @pos, 1);

        IF CHARINDEX(@letter, @setOfLetters) = 0
        BEGIN
            SET @result = 0;
            BREAK;
        END

        SET @pos = @pos + 1;
    END

    RETURN @result;
END

GO



--Bank Database

CREATE PROCEDURE usp_GetHoldersFullName
			  AS
		   BEGIN
				 SELECT CONCAT_WS(' ', FirstName, LastName) AS [Full Name]
				 FROM AccountHolders
		     END

GO


CREATE OR ALTER PROCEDURE usp_GetHoldersWithBalanceHigherThan
    @Number DECIMAL(18, 4)
AS
BEGIN
SELECT *
  FROM
    (SELECT ac.FirstName, ac.LastName
    FROM Accounts AS a
    LEFT JOIN AccountHolders AS ac ON a.AccountHolderId = ac.Id
    GROUP BY ac.FirstName, ac.LastName
    HAVING SUM(a.Balance) > @Number) AS a
ORDER BY FirstName, LastName
END

EXEC usp_GetHoldersWithBalanceHigherThan 18000.00

GO


CREATE FUNCTION ufn_CalculateFutureValue


