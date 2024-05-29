USE AdventureWorks2022
--1
BEGIN TRANSACTION;
UPDATE Production.Product
SET ListPrice = ListPrice *1.10
WHERE ProductID = 680
COMMIT TRANSACTION;
--2
BEGIN TRANSACTION;
DELETE FROM Production.Product
WHERE ProductID = 707
ROLLBACK TRANSACTION;
--3
BEGIN TRANSACTION;
INSERT INTO Production.Product (Name, ProductNumber, MakeFlag, FinishedGoodsFlag, Color, SafetyStockLevel, ReorderPoint, StandardCost, ListPrice, Size, SizeUnitMeasureCode, WeightUnitMeasureCode, Weight, DaysToManufacture, ProductLine, Class, Style, SellStartDate, SellEndDate, DiscontinuedDate, rowguid, ModifiedDate)
VALUES ('New Product', 'NP-001', 1, 1, 'Black', 100, 50, 500.00, 1000.00, NULL, NULL, NULL, NULL, 0, 'T', NULL, NULL, GETDATE(), NULL, NULL, NEWID(), GETDATE());
COMMIT TRANSACTION;
--4
BEGIN TRANSACTION;

UPDATE Production.Product
SET StandardCost = StandardCost * 1.10;
IF (SELECT SUM(StandardCost) FROM Production.Product) <= 50000
BEGIN
    COMMIT TRANSACTION;
END
ELSE
BEGIN
    ROLLBACK TRANSACTION;
END
--5
BEGIN TRANSACTION;

DECLARE @ProductNumber NVARCHAR(25) = 'NP-002';

IF EXISTS (SELECT 1 FROM Production.Product WHERE ProductNumber = @ProductNumber)
BEGIN
    ROLLBACK TRANSACTION;
END
ELSE
BEGIN
    INSERT INTO Production.Product (Name, ProductNumber, MakeFlag, FinishedGoodsFlag, Color, SafetyStockLevel, ReorderPoint, StandardCost, ListPrice, Size, SizeUnitMeasureCode, WeightUnitMeasureCode, Weight, DaysToManufacture, ProductLine, Class, Style, SellStartDate, SellEndDate, DiscontinuedDate, rowguid, ModifiedDate)
    VALUES ('Another New Product', @ProductNumber, 1, 1, 'Red', 100, 50, 600.00, 1200.00, NULL, NULL, NULL, NULL, 0, 'T', NULL, NULL, GETDATE(), NULL, NULL, NEWID(), GETDATE());
    COMMIT TRANSACTION;
END
--6
BEGIN TRANSACTION;

UPDATE Sales.SalesOrderDetail
SET OrderQty = OrderQty + 1; -- Na przyk³ad zwiêkszenie o 1

IF EXISTS (SELECT 1 FROM Sales.SalesOrderDetail WHERE OrderQty = 0)
BEGIN
    ROLLBACK TRANSACTION;
END
ELSE
BEGIN
    COMMIT TRANSACTION;
END
--7
BEGIN TRANSACTION;

DECLARE @AvgCost DECIMAL(10, 2);
DECLARE @ProductsToDelete INT;

SELECT @AvgCost = AVG(StandardCost) FROM Production.Product;

DELETE FROM Production.Product
WHERE StandardCost > @AvgCost;

SET @ProductsToDelete = @@ROWCOUNT;

IF @ProductsToDelete > 10
BEGIN
    ROLLBACK TRANSACTION;
END
ELSE
BEGIN
    COMMIT TRANSACTION;
END
