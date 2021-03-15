CREATE DATABASE TestDb
GO
USE TestDb
GO
CREATE SCHEMA TestSchema
GO
--SELECT * FROM sys.schemas
CREATE TABLE TestSchema.TestTable
(
    ID INT NOT NULL, --ID in upper case because is the abbreviation
    Name VARCHAR(20),
    IsSold BIT,
    InvoiceDate DATE
)
GO
INSERT INTO TestSchema.TestTable
VALUES
(1, 'Boat', 1, '2020-11-08'),
(2, 'Auto', 0, '2020-11-09'),
(3, 'Plane', NULL, '2020-12-09')
GO
CREATE USER TestUser WITH PASSWORD = 'pass!4Word'
GO
GRANT CONNECT ON DATABASE::TestDb TO TestUser
GO
GRANT SELECT ON OBJECT::TestSchema.TestTable TO TestUser
GO
DROP USER TestUser
