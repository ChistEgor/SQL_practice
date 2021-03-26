USE AdventureWorks2019
GO

-- Task 3.1 
CREATE VIEW Person.vPerson
AS
SELECT pp.Title
    , pp.FirstName
    , pp.LastName
    , pea.EmailAddress
FROM Person.Person AS pp
JOIN Person.EmailAddress AS pea
    ON pp.BusinessEntityID = pea.BusinessEntityID;
GO

-- Task 3.2
WITH Person_CTE (
    BusinessEntityId
    , FirstName
    , LastName
    )
AS (
    SELECT BusinessEntityId
        , FirstName
        , LastName
    FROM Person.Person
    )
    , Phone_CTE (
    BusinessEntityID
    , PhoneNumber
    )
AS (
    SELECT BusinessEntityID
        , PhoneNumber
    FROM Person.PersonPhone
    )
SELECT hre.BusinessEntityID
    , hre.NationalIdNumber
    , Person_CTE.FirstName
    , Person_CTE.LastName
    , hre.JobTitle
    , Phone_CTE.PhoneNumber
FROM HumanResources.Employee AS hre
JOIN Person_CTE
    ON hre.BusinessEntityID = Person_CTE.BusinessEntityID
JOIN Phone_CTE
    ON hre.BusinessEntityID = Phone_CTE.BusinessEntityID;
GO
