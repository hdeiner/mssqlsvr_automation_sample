-- SQL Server unit test for Sales.uspPlaceNewOrder

-- uspPlaceNewOrder - For the customer who has a CustomerID of 1, place an order for $100. Verify that the YTDOrders amount for that customer is 100 and that the YTDSales amount is zero.
CREATE PROCEDURE [testSales].[test that placing an order works] AS
  BEGIN

    DECLARE @RC AS INT, @CustomerID AS INT, @Amount AS INT, @OrderDate AS DATETIME, @Status AS CHAR (1);
    DECLARE @CustomerName AS NVARCHAR(40);

    DECLARE @expectedCustomerCount AS INT, @actualCustomerCount AS INT;
    SET @expectedCustomerCount = 1;

    DECLARE @expectedYTDOrders AS INT, @actualYTDOrders AS INT;
    SET @expectedYTDOrders = 100;

    SELECT @RC = 0,
           @CustomerID = 0,
           @CustomerName = N'Fictitious Customer',
           @Amount = 100,
           @OrderDate = getdate(),
           @Status = 'O';

    EXECUTE @RC = [Sales].[newCustomer] @CustomerName;

    SET @actualCustomerCount = (SELECT COUNT(*) FROM [Sales].[Customer]);

    EXEC tSQLt.AssertEquals @Expected = @expectedCustomerCount, @Actual = @actualCustomerCount,
          @Message = N'[Sales].[newCustomer] did not insert the customer';

    -- NOTE: Assumes that you inserted a Customer record with CustomerName='Fictitious Customer' in the pre-test script.
    SELECT @CustomerID = [CustomerID] FROM [Sales].[Customer] WHERE [CustomerName] = @CustomerName;

    -- place an order for that customer
    EXECUTE @RC = [Sales].[placeNewOrder] @CustomerID, @Amount, @OrderDate, @Status;

    -- verify that the YTDOrders value is correct.
    SELECT @actualYTDOrders = [YTDOrders] FROM [Sales].[Customer] WHERE [CustomerID] = @CustomerID

    EXEC tSQLt.AssertEquals @Expected = @expectedYTDOrders, @Actual = @actualYTDOrders,
                            @Message = N'placeNewOrder did not update YTDOrders';

    --SELECT @RC AS RC

  END