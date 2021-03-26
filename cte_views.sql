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
WITH Human_CTE (
    BusinessEntityId
    , NationalIdNumber
    , JobTitle
    )
AS (
    SELECT BusinessEntityId
        , NationalIdNumber
        , JobTitle
    FROM HumanResources.Employee
    )
    , Person_CTE (
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
SELECT Human_CTE.BusinessEntityId
    , Human_CTE.NationalIdNumber
    , Person_CTE.FirstName
    , Person_CTE.LastName
    , Human_CTE.JobTitle
    , ppp.PhoneNumber
FROM Person.PersonPhone AS ppp
JOIN Person_CTE
    ON ppp.BusinessEntityID = Person_CTE.BusinessEntityId
JOIN Human_CTE
    ON ppp.BusinessEntityID = Human_CTE.BusinessEntityId
GO