select * from Departments

select [Name] from Departments

select FirstName, LastName, Salary
from Employees

select FirstName, MiddleName, LastName
from Employees


select FirstName + '.' + LastName + '@softuni.bg' as 'Full Email Address'
from Employees


select distinct Salary as Salary
from Employees


select *
from Employees
where JobTitle = 'Sales Representative'


select FirstName, LastName, JobTitle
from Employees
where Salary between 20000 and 30000


select CONCAT_WS (' ', FirstName, MiddleName, LastName) as 'Full Name'
from Employees
where Salary in (25000, 14000, 12500, 23600)


select FirstName, LastName
from Employees
where ManagerID is null



select FirstName, LastName, Salary
from Employees
where Salary > 50000
order by Salary desc


select top(5) FirstName, LastName
from Employees
order by Salary desc


select FirstName, LastName
from Employees
where DepartmentId <> 4


select *
from Employees
order by Salary desc, FirstName, LastName desc, MiddleName


create view [V_EmployeesSalaries] as 
select FirstName, LastName, Salary
from Employees


create view [V_EmployeeNameJobTitle] as 
select concat(FirstName,' ', MiddleName,' ', LastName) as 'Full Name', JobTitle
from Employees


select distinct JobTitle
from Employees


select top(10) *
from Projects
order by StartDate, Name


select top(7) FirstName, LastName, HireDate
from Employees
order by HireDate desc

update Employees
set Salary *= 1.12
where DepartmentId in(1, 2, 4, 11)
select Salary
from Employees


