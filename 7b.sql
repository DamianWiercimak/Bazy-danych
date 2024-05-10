USE AdventureWorks2022
CREATE PROCEDURE GenerateFibonacci
    @n INT
AS
BEGIN
    DECLARE @counter INT = 1;
    DECLARE @fib1 INT = 0;
    DECLARE @fib2 INT = 1;
    DECLARE @fib INT;

    WHILE @counter <= @n
    BEGIN
        SET @fib = @fib1 + @fib2;
        PRINT @fib;
        SET @fib1 = @fib2;
        SET @fib2 = @fib;
        SET @counter = @counter + 1;
    END;
END;

EXEC GenerateFibonacci @n = 10




CREATE OR ALTER TRIGGER BIGLETTERS 
ON Person.Person
AFTER INSERT
AS
BEGIN
	UPDATE Person.Person
	SET LastName = UPPER(LastName)
	FROM Person.Person;
END;

INSERT INTO Person.Person (BusinessEntityID, PersonType, FirstName, LastName)
VALUES (380, 'EM', 'Jan', 'Kowal');

SELECT * FROM Person.Person
WHERE BusinessEntityID = 380;




CREATE OR ALTER TRIGGER TaxRateMonitor ON Sales.SalesTaxRate
AFTER UPDATE
AS
BEGIN
	IF EXISTS(
		SELECT 1
		FROM inserted
		JOIN deleted ON inserted.TaxRate > deleted.TaxRate * 1.3
		)
	BEGIN
		PRINT 'Zmiana wartosci w polu TaxRate o wiecej niz 30%'
	END;
END;

	
UPDATE Sales.SalesTaxRate
SET TaxRate = TaxRate * 1.5
WHERE TaxRate = 6.75;

SELECT * FROM Sales.SalesTaxRate
