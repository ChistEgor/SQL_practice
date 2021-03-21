USE TestDB
GO
INSERT INTO TestSchema.TestTable
VALUES
    (4, 'Bicycle', 0, '2020-08-23'),
    (5, 'Rocket', 1, '2020-01-01'),
    (6, 'Motorcycle', NULL, '2020-08-26'),
    (7, 'Submarine', 0, '1999-05-16')
GO
INSERT INTO TestSchema.TestTable
VALUES
    (8, DEFAULT, DEFAULT, '2020-08-25'),
    (9, 'Scooter', DEFAULT, DEFAULT)
GO
UPDATE TestSchema.TestTable
SET IsSold = 0
WHERE IsSold IS NULL
GO
DELETE FROM TestSchema.TestTable
WHERE Name IS NULL OR InvoiceDate IS NULL
GO
CREATE TABLE TestSchema.TestTable2
(
    ID INT NOT NULL,
    Name VARCHAR(20),
    IsSold BIT,
    InvoiceDate DATE
)
GO
INSERT INTO TestSchema.TestTable2
VALUES
    (1, 'Speed Boat', 1, '2020-11-08'),
    (7, 'Submarine', 0, '1999-05-16'),
    (8, 'Segway', 1, '2021-01-01')
GO
MERGE INTO TestSchema.TestTable AS t
USING TestSchema.TestTable2 AS s
ON t.ID = s.ID
WHEN MATCHED AND t.Name != s.Name THEN
    UPDATE SET Name = s.Name
WHEN NOT MATCHED THEN 
    INSERT (ID, Name, IsSold, InvoiceDate) 
    VALUES (s.ID, s.Name, s.IsSold, s.InvoiceDate)
OUTPUT $action AS Operation, Inserted.ID, Inserted.Name NameNew,
Inserted.IsSold IsSoldNew, Inserted.InvoiceDate InvoiceDateNew,
Deleted.Name NameOld, Deleted.IsSold IsSoldOld, Deleted.InvoiceDate InvoiceDateOld;
