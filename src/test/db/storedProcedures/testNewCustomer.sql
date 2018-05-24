-- SQL Server unit test for Sales.uspNewCustomer
--
-- testNewCustomer - Verify that the Customer table contains one row after you run the stored procedure.
CREATE PROCEDURE [testSales].[test that if we call newCustomer and add someone that they persist] AS
  BEGIN
    DECLARE @RC AS INT, @CustomerName AS NVARCHAR (40);
    DECLARE @expected AS INT, @actual AS INT;

    SET @expected = 1;

    SELECT @RC = 0,
           @CustomerName = 'Fictitious Customer';

    EXECUTE @RC = [Sales].[newCustomer] @CustomerName;

    SET @actual = (SELECT COUNT(*) FROM [Sales].[Customer]);

    EXEC tSQLt.AssertEquals @Expected = @expected, @Actual = @actual,
          @Message = N'[Sales].[newCustomer] did not insert the customer';

  END