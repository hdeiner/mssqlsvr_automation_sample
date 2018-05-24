-- SQL Server unit test for Sales.uspFillOrder
--
-- uspFillOrder - For the customer who has a CustomerID of 1, place an order for $50. Fill that order. Verify that YTDOrders and YTDSales amounts are both 50.

CREATE PROCEDURE [testSales].[test that filling an order works] AS
  BEGIN

    DECLARE @RC AS INT, @CustomerID AS INT, @Amount AS INT, @OrderDate AS DATETIME, @FilledDate AS DATETIME, @Status AS CHAR (1);
    DECLARE @CustomerName AS NVARCHAR(40), @OrderID AS INT;

    DECLARE @expectedYTDSales AS INT, @actualYTDSales AS INT;
    SET @expectedYTDSales = 100;

    SELECT @RC = 0,
           @CustomerID = 0,
           @OrderID = 0,
           @CustomerName = N'Fictitious Customer',
           @Amount = 100,
           @OrderDate = getdate(),
           @FilledDate = getdate(),
           @Status = 'O';

    EXECUTE @RC = [Sales].[newCustomer] @CustomerName;
    -- NOTE: Assumes that you inserted a Customer record with CustomerName='Fictitious Customer' in the pre-test script.
    SELECT @CustomerID = [CustomerID] FROM [Sales].[Customer] WHERE [CustomerName] = @CustomerName;

    EXECUTE @RC = [Sales].[placeNewOrder] @CustomerID, @Amount, @OrderDate, @Status;
    -- Get the most recently added order.
    SELECT @OrderID = MAX([OrderID]) FROM [Sales].[Orders] WHERE [CustomerID] = @CustomerID;

    -- fill an order for that customer
    EXECUTE @RC = [Sales].[fillOrder] @OrderID, @FilledDate;

    -- verify that the YTDOrders value is correct.
    SELECT @actualYTDSales = [YTDSales] FROM [Sales].[Customer] WHERE [CustomerID] = @CustomerID

    EXEC tSQLt.AssertEquals @Expected = @expectedYTDSales, @Actual = @actualYTDSales,
          @Message = N'fillOrder did not get YTDSales updated correctly';

  END
    --SELECT @RC AS RC;