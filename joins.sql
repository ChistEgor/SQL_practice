USE AdventureWorks2019
GO

-- Task 1.1
SELECT pp.FirstName
    , pp.LastName
    , he.JobTitle
    , he.BirthDate
FROM Person.Person AS pp
INNER JOIN HumanResources.Employee AS he
    ON (pp.BusinessEntityID = he.BusinessEntityID);
GO

-- Task 1.2
SELECT pp.FirstName
    , pp.LastName
    , (
        SELECT JobTitle
        FROM HumanResources.Employee AS he
        WHERE pp.BusinessEntityID = he.BusinessEntityID
        ) AS JobTitle
FROM Person.Person AS pp
GO

-- Task 1.3
SELECT Temp.*
FROM (
    SELECT pp.FirstName
        , pp.LastName
        , (
            SELECT JobTitle
            FROM HumanResources.Employee AS he
            WHERE pp.BusinessEntityID = he.BusinessEntityID
            ) AS JobTitle
    FROM Person.Person AS pp
    ) AS Temp
WHERE JobTitle IS NOT NULL
GO

--Task 1.4
SELECT pp.FirstName
    , pp.LastName
    , he.JobTitle
FROM Person.Person AS pp
CROSS JOIN HumanResources.Employee AS he
GO

--Task 1.5
SELECT COUNT(*) AS NumberOfLines
FROM (
    SELECT pp.FirstName
        , pp.LastName
        , he.JobTitle
    FROM Person.Person AS pp
    CROSS JOIN HumanResources.Employee AS he
    ) AS TemporaryTable
