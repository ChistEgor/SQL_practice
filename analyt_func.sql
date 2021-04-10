USE AdventureWorks2019
GO

--Task 1.1
SELECT Product
    ,ProductTotalSum
FROM (
    SELECT pp.Name AS Product
        , SUM(sod.LineTotal) AS ProductTotalSum
        , NTILE(10) OVER (ORDER BY SUM(sod.LineTotal)) AS Tile
    FROM Production.Product AS pp
    JOIN Sales.SalesOrderDetail AS sod
        ON pp.ProductID = sod.ProductID
    JOIN Sales.SalesOrderHeader AS soh
        ON sod.SalesOrderID = soh.SalesOrderID
    WHERE soh.OrderDate BETWEEN '2013-01-01' AND '2013-01-31'
    GROUP BY pp.Name
    ) AS t1
WHERE Tile BETWEEN 2 AND 9;
GO

--Task 1.2
SELECT Name
    ,ListPrice
FROM (
    SELECT Name
        ,ListPrice
        ,RANK() OVER (PARTITION BY ProductSubcategoryID ORDER BY ListPrice) AS RankPrice
    FROM Production.Product
    WHERE ProductSubcategoryID IS NOT NULL
    ) AS t2
WHERE RankPrice = 1;
GO

--Task 1.3
SELECT DISTINCT ListPrice
FROM (
    SELECT ListPrice
        ,DENSE_RANK() OVER (PARTITION BY ProductSubcategoryID ORDER BY ListPrice DESC) AS RankPrice
    FROM Production.Product
    WHERE ProductSubcategoryID = 1
    ) AS t3
WHERE RankPrice = 2;
GO

--Task 1.4
SELECT Category
    ,Sales
    ,((Sales - PreviousSales) / Sales) * 100 AS YoY
FROM (
    SELECT pc.Name AS Category
        ,YEAR(soh.OrderDate) AS OrderYear
        ,SUM(sod.LineTotal) AS Sales
        ,LAG(SUM(sod.LineTotal)) OVER (ORDER BY pc.Name, YEAR(soh.OrderDate)) AS PreviousSales
    FROM Sales.SalesOrderHeader AS soh
    JOIN Sales.SalesOrderDetail AS sod
        ON soh.SalesOrderID = sod.SalesOrderID
    JOIN Production.Product AS pp
        ON sod.ProductID = pp.ProductID
    JOIN Production.ProductSubcategory AS ps
        ON pp.ProductSubcategoryID = ps.ProductSubcategoryID
    JOIN Production.ProductCategory AS pc
        ON ps.ProductCategoryID = pc.ProductCategoryID
    WHERE soh.OrderDate BETWEEN '2012-01-01' AND '2013-12-31'
    GROUP BY YEAR(soh.OrderDate)
        ,pc.Name
    ) AS t4
WHERE OrderYear = 2013;
GO

--Task 1.5
SELECT DISTINCT soh.OrderDate
    ,MAX(SUM(sod.LineTotal)) OVER (PARTITION BY soh.OrderDate) AS OrderMax
FROM Sales.SalesOrderDetail AS sod
JOIN Sales.SalesOrderHeader AS soh
    ON sod.SalesOrderID = soh.SalesOrderID
WHERE soh.OrderDate BETWEEN '2013-01-01' AND '2013-01-31'
GROUP BY soh.OrderDate
    ,soh.SalesOrderID;
GO

--Task 1.6
SELECT DISTINCT ps.Name AS NameSubcategory
    ,FIRST_VALUE(pp.Name) OVER(PARTITION BY ps.Name ORDER BY count(*) DESC) MostAmount
FROM Sales.SalesOrderHeader AS sh
JOIN Sales.SalesOrderDetail AS sod
    ON sh.SalesOrderID = sod.SalesOrderID
JOIN Production.Product AS pp
    ON sod.ProductID = pp.ProductID
JOIN Production.ProductSubcategory AS ps
    ON pp.ProductSubcategoryID = ps.ProductSubcategoryID
WHERE OrderDate BETWEEN '2013-01-01' AND '2013-01-31'
GROUP BY ps.Name
    ,pp.Name;
GO
