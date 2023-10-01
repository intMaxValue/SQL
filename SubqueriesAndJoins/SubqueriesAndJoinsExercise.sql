--SoftUni DB

SELECT TOP 5 EmployeeID
	   ,JobTitle
	   ,a.AddressID
	   ,a.AddressText
FROM Employees AS e
JOIN Addresses AS a 
ON e.AddressID = a.AddressID
ORDER BY e.AddressID


SELECT TOP 50 e.FirstName
			 ,e.LastName
			 ,t.[Name]
			 ,a.AddressText
FROM Employees AS e
LEFT JOIN Addresses AS a ON e.AddressID = a.AddressID
LEFT JOIN Towns AS t ON a.TownID = t.TownID
ORDER BY e.FirstName, e.LastName



SELECT e.EmployeeID
		,e.FirstName
		,e.LastName
		,d.Name
FROM Employees AS e
JOIN Departments AS d ON e.DepartmentID = d.DepartmentID
WHERE d.DepartmentID = 3



SELECT TOP 5 EmployeeID
	   ,FirstName
	   ,Salary
	   ,d.[Name]
FROM Employees AS e
JOIN Departments AS D ON e.DepartmentID = D.DepartmentID
WHERE Salary > 15000
ORDER BY d.DepartmentID



SELECT TOP 3 e.EmployeeID
			 ,e.FirstName
FROM Employees AS e
LEFT JOIN EmployeesProjects AS ep ON e.EmployeeID = ep.EmployeeID
WHERE ep.ProjectID IS NULL
ORDER BY EmployeeID



SELECT FirstName
	   ,LastName
	   ,HireDate
	   ,d.Name
FROM Employees AS e
JOIN Departments AS d ON e.DepartmentID = d.DepartmentID
WHERE HireDate > '1999-01-01' AND d.[Name] IN ('Sales', 'Finance')
ORDER BY HireDate



SELECT TOP 5 e.EmployeeID
	   ,e.FirstName
	   ,p.[Name]
FROM Employees AS e
JOIN EmployeesProjects AS ep ON e.EmployeeID = ep.EmployeeID
JOIN Projects AS p ON ep.ProjectID = p.ProjectID
WHERE p.StartDate > '2002-08-13' AND p.EndDate IS NULL


SELECT e.EmployeeID,
	   e.FirstName,
	   CASE
	   WHEN DATEPART(YEAR, p.StartDate) >= 2005 THEN NULL
	   ELSE p.[Name]
	   END AS 'ProjectName'
FROM Employees AS e
LEFT JOIN EmployeesProjects AS ep on e.EmployeeID = ep.EmployeeID
LEFT JOIN Projects AS p ON ep.ProjectID = p.ProjectID
WHERE e.EmployeeID = 24



SELECT e.EmployeeID,
	   e.FirstName,
	   e.ManagerID,
	   m.FirstName

FROM Employees AS e
LEFT JOIN Employees AS m ON e.ManagerID = m.EmployeeID
WHERE e.ManagerID IN (3, 7)
ORDER BY e.EmployeeID


SELECT TOP(50) e.EmployeeID
	   ,CONCAT_WS(' ', e.FirstName, e.LastName) AS EmployeeName
	   ,CONCAT_WS(' ',m.FirstName, m.LastName)
	   ,d.[Name]
FROM Employees AS e
LEFT JOIN Employees AS m ON e.ManagerID = m.EmployeeID
JOIN Departments AS d ON e.DepartmentID = d.DepartmentID
ORDER BY e.EmployeeID


SELECT TOP 1 AVG(Salary) AS MinAverageSalary
FROM Employees
GROUP BY DepartmentID
ORDER BY MinAverageSalary




--GEOGRAPHY DATABASE

SELECT c.CountryCode
	   ,m.MountainRange
	   ,p.PeakName
	   ,p.Elevation
FROM Countries AS c
LEFT JOIN MountainsCountries AS mc ON c.CountryCode = mc.CountryCode
LEFT JOIN Mountains AS m ON mc.MountainId = m.Id
LEFT JOIN Peaks AS p ON M.Id = p.MountainId
WHERE c.CountryName = 'Bulgaria' AND p.Elevation > 2835
ORDER BY p.Elevation DESC


SELECT c.CountryCode
	   ,COUNT(m.MountainRange) as MountainRanges
FROM Countries AS c
LEFT JOIN MountainsCountries AS mc ON c.CountryCode = mc.CountryCode
LEFT JOIN Mountains AS m ON mc.MountainId = m.Id
WHERE c.CountryName IN ('Bulgaria', 'Russia', 'United States')
GROUP BY c.CountryCode




SELECT TOP 5 c.CountryName
	   ,r.RiverName
FROM Countries AS c
LEFT JOIN Continents AS cont ON c.ContinentCode = cont.ContinentCode
LEFT JOIN CountriesRivers AS cr ON c.CountryCode = cr.CountryCode
LEFT JOIN Rivers AS r ON cr.RiverId = r.Id
WHERE cont.ContinentCode = 'AF'
ORDER BY c.CountryName