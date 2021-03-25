USE AdventureWorks2019
GO

--EXEC sp_help 'Person.Person'
--EXEC sp_columns Employee
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
FROM Person.Person AS pp;
GO

-- the same action but through a join. better
SELECT pp.FirstName
    , pp.LastName
    , he.JobTitle
FROM Person.Person AS pp
FULL OUTER JOIN HumanResources.Employee AS he
    ON (pp.BusinessEntityID = he.BusinessEntityID);
GO

-- Task 1.3 *don't sure
SELECT pp.FirstName
    , pp.LastName
    , (
        SELECT he.JobTitle
        FROM HumanResources.Employee AS he
        WHERE pp.BusinessEntityID = he.BusinessEntityID
        ) AS JobTitle
FROM Person.Person AS pp
WHERE (
        SELECT he.JobTitle
        FROM HumanResources.Employee AS he
        WHERE pp.BusinessEntityID = he.BusinessEntityID
        ) IS NOT NULL;
GO

--Task 1.4
SELECT pp.FirstName
    , pp.LastName
    , he.JobTitle
FROM Person.Person AS pp
CROSS JOIN HumanResources.Employee AS he;
GO

--Task 1.5
SELECT COUNT(*) AS NumberOfLines
FROM (
    SELECT pp.FirstName
        , pp.LastName
        , he.JobTitle
    FROM Person.Person AS pp
    CROSS JOIN HumanResources.Employee AS he
    ) AS TemporaryTable;
GO

--check
SELECT (
        SELECT COUNT(FirstName)
        FROM Person.Person
        ) * (
        SELECT COUNT(JobTitle)
        FROM HumanResources.Employee
        ) AS Amount;
