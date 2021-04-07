USE AdventureWorks2019
GO

--Task 1.1
SELECT t1.*
FROM (
    SELECT Name
        , LineTotal
        , PERCENT_RANK() OVER (ORDER BY LineTotal) AS pr
    FROM Production.Product AS pp
    JOIN Sales.SalesOrderDetail AS sod
        ON pp.ProductID = sod.ProductID
    JOIN Sales.SalesOrderHeader AS soh
        ON sod.SalesOrderID = soh.SalesOrderID
    WHERE OrderDate BETWEEN '2013-01-01' AND '2013-01-31'
    ) AS t1
WHERE pr BETWEEN .1 AND .9
GO

--Task 1.2
SELECT ProductSubcategoryID
    , Name
    , ListPrice
    , MIN(ListPrice) OVER (PARTITION BY ProductSubcategoryID ORDER BY ListPrice) AS MinPriceProductSub
FROM Production.Product
WHERE ProductSubcategoryID IS NOT NULL

--Task 1.3
SELECT TOP 1 t2.*
FROM (
    SELECT Name
        , ListPrice
        , DENSE_RANK() OVER (ORDER BY ListPrice DESC) AS PriceRank
    FROM Production.Product
    WHERE Name LIKE '%Mountain Frame%'
    ) AS t2
WHERE t2.PriceRank = 2

--Task 1.4 not end. zZz
SELECT t7.* FROM (SELECT UnitPrice
    , OrderDate
FROM Sales.SalesOrderHeader AS sh
    JOIN Sales.SalesOrderDetail AS sod
        ON sh.SalesOrderID = sod.SalesOrderID
    JOIN Production.Product AS pp
        ON sod.ProductID = pp.ProductID
    JOIN Production.ProductSubcategory AS ps
        ON pp.ProductSubcategoryID = ps.ProductSubcategoryID
    JOIN Production.ProductCategory AS pc
        ON ps.ProductCategoryID = pc.ProductCategoryID
    WHERE YEAR(OrderDate) = '2013') AS t7


SELECT * FROM Sales.SalesOrderHeader

SELECT * FROM Sales.SalesOrderDetail

SELECT * FROM Production.Product

SELECT * FROM Production.ProductSubcategory

SELECT * FROM Production.ProductCategory


--Task 1.5
SELECT t3.*
    , MAX(SumDay) OVER () AS MaxSumDay
FROM (
    SELECT UnitPrice
        , OrderDate
        , SUM(UnitPrice) OVER (PARTITION BY OrderDate) AS SumDay
    FROM Sales.SalesOrderDetail AS sod
    JOIN Sales.SalesOrderHeader AS soh
        ON sod.SalesOrderID = soh.SalesOrderID
    WHERE OrderDate BETWEEN '2013-01-01' AND '2013-01-31'
    ) AS t3

--Task 1.6
SELECT DISTINCT t4.*
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
    ) AS t4
WHERE MaxAmountProductInSubcategory = OrderQty
