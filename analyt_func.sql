USE AdventureWorks2019
GO

-- Task 1.1
SELECT t1.*
FROM (
    SELECT Name
        , LineTotal
        , SUM(LineTotal) OVER (ORDER BY Name) AS ProductTotalSumSale
        , SUM(LineTotal) OVER () AS AllTotalSumSale
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
SELECT t2.*
FROM (
    SELECT Name
        , ListPrice
        , DENSE_RANK() OVER (ORDER BY ListPrice DESC) AS PriceRank
    FROM Production.Product
    WHERE Name LIKE '%Mountain Frame%'
    ) AS t2
WHERE t2.PriceRank = 2

--Task 1.4





SELECT * FROM Sales.SalesOrderHeader

SELECT * FROM Sales.SalesOrderDetail

SELECT * FROM Production.Product
WHERE Name LIKE '%Mountain Frame%'

SELECT * FROM Production.Product
WHERE Name LIKE '%Bike%'


SELECT Name FROM Production.Product
