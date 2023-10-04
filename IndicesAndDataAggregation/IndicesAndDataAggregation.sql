--Gringotts Database

SELECT COUNT(Id) AS [Count]
FROM WizzardDeposits


SELECT TOP 1 MAX(MagicWandSize) AS LongestMagicWand
FROM WizzardDeposits
GROUP BY DepositGroup



SELECT DepositGroup
		,MAX(MagicWandSize) AS LongestMagicWand
FROM WizzardDeposits
GROUP BY DepositGroup



SELECT TOP 2 DepositGroup
FROM WizzardDeposits
GROUP BY DepositGroup
ORDER BY AVG(MagicWandSize)



SELECT DepositGroup
	   ,SUM(DepositAmount)
FROM WizzardDeposits
GROUP BY DepositGroup



SELECT DepositGroup
	   ,SUM(DepositAmount) AS TotalSum
FROM WizzardDeposits
WHERE MagicWandCreator = 'Ollivander family'
GROUP BY DepositGroup


SELECT *
FROM
		(SELECT DepositGroup
			   ,SUM(DepositAmount) AS TotalSum
		FROM WizzardDeposits
		WHERE MagicWandCreator = 'Ollivander family'
		GROUP BY DepositGroup
		) AS E
WHERE TotalSum < 150000
ORDER BY TotalSum DESC



SELECT DepositGroup
	   ,MagicWandCreator
	   ,MIN(DepositCharge)
FROM WizzardDeposits
GROUP BY DepositGroup, MagicWandCreator



SELECT AgeGroup, COUNT(FirstName) AS WizardCount
FROM (
    SELECT 
        CASE
            WHEN Age BETWEEN 0 AND 10 THEN '[0-10]'
            WHEN Age BETWEEN 11 AND 20 THEN '[11-20]'
            WHEN Age BETWEEN 21 AND 30 THEN '[21-30]'
            WHEN Age BETWEEN 31 AND 40 THEN '[31-40]'
            WHEN Age BETWEEN 41 AND 50 THEN '[41-50]'
            WHEN Age BETWEEN 51 AND 60 THEN '[51-60]'
            WHEN Age >= 61 THEN '[61+]'
        END AS AgeGroup,
        FirstName
    FROM WizzardDeposits
) AS Subquery
GROUP BY AgeGroup
ORDER BY AgeGroup;



SELECT DISTINCT LEFT(FirstName, 1)
FROM WizzardDeposits
WHERE DepositGroup = 'Troll Chest'


SELECT DepositGroup
	   ,IsDepositExpired
	   ,AVG(DepositInterest)
FROM WizzardDeposits
WHERE DepositStartDate > '1985-01-01'
GROUP BY DepositGroup, IsDepositExpired
ORDER BY DepositGroup DESC, IsDepositExpired


WITH RankedWizards AS (
    SELECT
        FirstName AS [Host Wizard],
        DepositAmount AS [Host Wizard Deposit],
        LEAD(FirstName) OVER (ORDER BY Id) AS [Guest Wizard],
        LEAD(DepositAmount) OVER (ORDER BY Id) AS [Guest Wizard Deposit]
    FROM WizzardDeposits
)
SELECT SUM([Host Wizard Deposit] - [Guest Wizard Deposit]) AS SumDifference
FROM RankedWizards
WHERE [Guest Wizard] IS NOT NULL










