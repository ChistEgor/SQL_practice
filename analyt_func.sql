USE AdventureWorks2019
GO

--Task 1.1
SELECT t1.Name
    , t1.ProductTotalSumSale
FROM (
    SELECT pp.Name
        , SUM(LineTotal) AS ProductTotalSumSale
        , NTILE(10) OVER (ORDER BY SUM(LineTotal)) AS NtRange
    FROM Production.Product AS pp
    JOIN Sales.SalesOrderDetail AS sod
        ON pp.ProductID = sod.ProductID
    JOIN Sales.SalesOrderHeader AS soh
        ON sod.SalesOrderID = soh.SalesOrderID
    WHERE soh.OrderDate BETWEEN '2013-01-01' AND '2013-01-31'
    GROUP BY pp.Name
    ) AS t1
WHERE NtRange BETWEEN 2 AND 9
GO

--Task 1.2
SELECT t2.*
FROM (
    SELECT Name
        , ListPrice
        , MIN(ListPrice) OVER (PARTITION BY ProductSubcategoryID ORDER BY ListPrice) AS MinPriceProductSub
    FROM Production.Product
    WHERE ProductSubcategoryID IS NOT NULL
    ) AS t2
WHERE t2.ListPrice = t2.MinPriceProductSub
GO

--Task 1.3
SELECT TOP 1 t3.*
FROM (
    SELECT Name
        , ListPrice
        , DENSE_RANK() OVER (ORDER BY ListPrice DESC) AS PriceRank
    FROM Production.Product
    WHERE Name LIKE '%Mountain Frame%'
    ) AS t3
WHERE t3.PriceRank = 2
GO

--Task 1.4 not end.
SELECT t4.*
FROM (
    SELECT LineTotal
        , OrderDate
    FROM Sales.SalesOrderHeader AS soh
    JOIN Sales.SalesOrderDetail AS sod
        ON soh.SalesOrderID = sod.SalesOrderID
    JOIN Production.Product AS pp
        ON sod.ProductID = pp.ProductID
    JOIN Production.ProductSubcategory AS ps
        ON pp.ProductSubcategoryID = ps.ProductSubcategoryID
    JOIN Production.ProductCategory AS pc
        ON ps.ProductCategoryID = pc.ProductCategoryID
    ) AS t4

--
SELECT * FROM Sales.SalesOrderHeader

SELECT * FROM Sales.SalesOrderDetail

SELECT * FROM Production.Product

SELECT * FROM Production.ProductSubcategory

SELECT * FROM Production.ProductCategory

--Task 1.5
SELECT DISTINCT CONVERT(nvarchar(10), OrderDate, 104) AS OrderDate
    , MAX(SumDay) OVER (PARTITION BY OrderDate) AS MaxSumDay
FROM (
    SELECT OrderDate
        , SUM(UnitPrice) OVER (PARTITION BY OrderDate) AS SumDay
    FROM Sales.SalesOrderDetail AS sod
    JOIN Sales.SalesOrderHeader AS soh
        ON sod.SalesOrderID = soh.SalesOrderID
    WHERE OrderDate BETWEEN '2013-01-01' AND '2013-01-31'
    ) AS t5
GO

--Task 1.6
SELECT DISTINCT t6.NameSubcategory
    , t6.ProductName
FROM (
    SELECT ps.Name AS NameSubcategory
        , pp.Name AS ProductName
        , sod.OrderQty
        , MAX(OrderQty) OVER (PARTITION BY ps.Name) AS MaxAmountProductInSubcategory
    FROM Sales.SalesOrderHeader AS sh
    JOIN Sales.SalesOrderDetail AS sod
        ON sh.SalesOrderID = sod.SalesOrderID
    JOIN Production.Product AS pp
        ON sod.ProductID = pp.ProductID
    JOIN Production.ProductSubcategory AS ps
        ON pp.ProductSubcategoryID = ps.ProductSubcategoryID
    WHERE OrderDate BETWEEN '2013-01-01' AND '2013-01-31'
    ) AS t6
WHERE t6.MaxAmountProductInSubcategory = t6.OrderQty
GO
