USE AdventureWorks2019
GO
SELECT * 
FROM HumanResources.Department
WHERE GroupName LIKE ('%Research%')
ORDER BY DepartmentId DESC
GO
SELECT BusinessEntityId, JobTitle, BirthDate, Gender
FROM HumanResources.Employee
WHERE NationalIdNumber BETWEEN 500000000 AND 1000000000
GO
SELECT BusinessEntityId, JobTitle, BirthDate, Gender 
FROM HumanResources.Employee
WHERE YEAR(BirthDate) IN ('1980', '1990')
GO
SELECT BusinessEntityId, ShiftId
FROM HumanResources.EmployeeDepartmentHistory
GROUP BY BusinessEntityId, ShiftId
HAVING COUNT(*) >= 2