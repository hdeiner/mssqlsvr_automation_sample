--liquibase formatted sql
-- --PRINT N'Creating Sales.uspFillOrder...';
--GO
CREATE PROCEDURE [UM_Portal].[fillOrder]
@OrderID INT, @FilledDate DATETIME
AS
BEGIN
DECLARE @Delta INT, @CustomerID INT
BEGIN TRANSACTION
    SELECT @Delta = [Amount], @CustomerID = [CustomerID]
     FROM [UM_Portal].[Orders] WHERE [OrderID] = @OrderID;

UPDATE [UM_Portal].[Orders]
   SET [Status] = 'F',
       [FilledDate] = @FilledDate
WHERE [OrderID] = @OrderID;

UPDATE [UM_Portal].[Customer]
   SET
   YTDSales = YTDSales - @Delta
    WHERE [CustomerID] = @CustomerID
COMMIT TRANSACTION
END
--GO