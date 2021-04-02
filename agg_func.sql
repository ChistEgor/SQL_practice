USE AdventureWorks2019
GO

-- Task 1.1
SELECT COUNT(DISTINCT GroupName) AS NumbersOfGroup
FROM HumanResources.Department

-- Task 1.2
SELECT MAX(Rate) AS MaxRate
FROM HumanResources.EmployeePayHistory
GROUP BY BusinessEntityID
GO

-- Task 1.3 Without table Sales.SalesOrderHeader 
SELECT pp.ProductSubcategoryID
    , MIN(sd.UnitPrice) AS MinUnitPrice
FROM Sales.SalesOrderDetail AS sd
JOIN Production.Product AS pp
    ON sd.ProductID = pp.ProductID
JOIN Production.ProductSubcategory AS ps
    ON pp.ProductSubcategoryID = ps.ProductSubcategoryID
GROUP BY pp.ProductSubcategoryID
GO

-- Task 1.3 Without tables Sales.SalesOrderHeader and Production.ProductSubcategory
SELECT pp.ProductSubcategoryID
    , MIN(sd.UnitPrice) AS MinUnitPrice
FROM Sales.SalesOrderDetail AS sd
JOIN Production.Product AS pp
    ON sd.ProductID = pp.ProductID
GROUP BY pp.ProductSubcategoryID
GO

-- CTE experiments for 1.3 
WITH MinUnitPrices_CTE (
	ProductSubcategoryID
	, MinUnitPrice
	)
AS (
	SELECT p.ProductSubcategoryID
		, MIN(sd.UnitPrice) AS MinUnitPrice
	FROM Sales.SalesOrderDetail AS sd
	JOIN Production.Product AS p
		ON p.ProductID = sd.ProductID
	GROUP BY p.ProductSubcategoryID
	)
SELECT ps.ProductSubcategoryID
	, CTE.MinUnitPrice
FROM Production.ProductSubcategory AS ps
JOIN MinUnitPrices_CTE AS CTE
	ON ps.ProductSubcategoryID = CTE.ProductSubcategoryID;
GO

-- Task 1.4
--Can't understand difference between

SELECT pc.ProductCategoryID
    , COUNT(ps.ProductSubcategoryID) AS AmountSubCategory
FROM Production.ProductCategory AS pc
LEFT JOIN Production.ProductSubcategory AS ps
    ON pc.ProductCategoryID = ps.ProductCategoryID
GROUP BY pc.ProductCategoryID
GO


SELECT pc.ProductCategoryID
    , (
        SELECT COUNT(*)
        FROM Production.ProductSubcategory
        WHERE ProductCategoryID = pc.ProductCategoryID
        GROUP BY ProductCategoryID
        ) AS NumOfSubcategories
FROM Production.ProductCategory AS pc;
GO

-- Task 1.5 Without table Sales.SalesOrderHeader 
SELECT pp.ProductSubcategoryID
    , AVG(sd.LineTotal) AS AvgLineTotal
FROM Sales.SalesOrderDetail AS sd
JOIN Production.Product AS pp
    ON sd.ProductID = pp.ProductID
JOIN Production.ProductSubcategory AS ps
    ON pp.ProductSubcategoryID = ps.ProductSubcategoryID
GROUP BY pp.ProductSubcategoryID
GO

-- Task 1.5 Without tables Sales.SalesOrderHeader and Production.ProductSubcategory
SELECT pp.ProductSubcategoryID
    , AVG(sd.LineTotal) AS AvgLineTotal
FROM Sales.SalesOrderDetail AS sd
JOIN Production.Product AS pp
    ON sd.ProductID = pp.ProductID
GROUP BY pp.ProductSubcategoryID
GO

-- Task 1.6
SELECT BusinessEntityID
    , RateChangeDate
FROM HumanResources.EmployeePayHistory
WHERE Rate = (
        SELECT MAX(Rate)
        FROM HumanResources.EmployeePayHistory
        )