--liquibase formatted sql
--PRINT N'Creating Sales.uspCancelOrder...';
--GO
CREATE PROCEDURE [Sales].[uspCancelOrder]
@OrderID INT
AS
BEGIN
DECLARE @Delta INT, @CustomerID INT
BEGIN TRANSACTION
    SELECT @Delta = [Amount], @CustomerID = [CustomerID]
     FROM [Sales].[Orders] WHERE [OrderID] = @OrderID;

UPDATE [Sales].[Orders]
   SET [Status] = 'X'
WHERE [OrderID] = @OrderID;

UPDATE [Sales].[Customer]
   SET
   YTDOrders = YTDOrders - @Delta
    WHERE [CustomerID] = @CustomerID
COMMIT TRANSACTION
END
--GO