USE AdventureWorks2019
GO

-- Task 1.1
SELECT GroupName, COUNT(*) AS AmountDeps
FROM HumanResources.Department
GROUP BY GroupName

-- Task 1.2
SELECT eh.BusinessEntityID
    , he.JobTitle
    , MAX(eh.Rate) AS MaxRate
FROM HumanResources.EmployeePayHistory AS eh
JOIN HumanResources.Employee AS he
    ON eh.BusinessEntityID = he.BusinessEntityID
GROUP BY eh.BusinessEntityID
    , he.JobTitle
GO

-- Task 1.3 
SELECT MIN(sd.UnitPrice) AS MinUnitPrice
    , ps.Name AS NameSubCategory
FROM Sales.SalesOrderHeader AS sh
JOIN Sales.SalesOrderDetail AS sd
    ON sh.SalesOrderID = sd.SalesOrderID
JOIN Production.Product AS pp
    ON sd.ProductID = pp.ProductID
JOIN Production.ProductSubcategory AS ps
    ON pp.ProductSubcategoryID = ps.ProductSubcategoryID
GROUP BY ps.Name
GO

-- Task 1.4
SELECT pc.Name AS NameCategory
    , COUNT(ps.ProductSubcategoryID) AS AmountSubCategory
FROM Production.ProductCategory AS pc
JOIN Production.ProductSubcategory AS ps
    ON pc.ProductCategoryID = ps.ProductCategoryID
GROUP BY pc.Name
GO

-- Task 1.5
SELECT AVG(sd.LineTotal) AS AvgLineTotal
    , ps.Name AS NameSubCategory
FROM Sales.SalesOrderHeader AS sh
JOIN Sales.SalesOrderDetail AS sd
    ON sh.SalesOrderID = sd.SalesOrderID
JOIN Production.Product AS pp
    ON sd.ProductID = pp.ProductID
JOIN Production.ProductSubcategory AS ps
    ON pp.ProductSubcategoryID = ps.ProductSubcategoryID
GROUP BY ps.Name
GO

-- Task 1.6
SELECT eh.BusinessEntityID
    , eh.Rate
    , MAX(RateChangeDate) AS SetDay
FROM HumanResources.EmployeePayHistory AS eh
GROUP BY eh.BusinessEntityID
    , eh.Rate
HAVING eh.Rate = (
        SELECT MAX(Rate)
        FROM HumanResources.EmployeePayHistory
        )
GO
