--liquibase formatted sql
CREATE PROCEDURE [UM_Portal].[placeNewOrder]
@CustomerID INT, @Amount INT, @OrderDate DATETIME, @Status CHAR (1)='O'
AS
BEGIN
DECLARE @RC INT
--BEGIN TRANSACTION
INSERT INTO [UM_Portal].[Orders] (CustomerID, OrderDate, FilledDate, Status, Amount)
VALUES (@CustomerID, @OrderDate, NULL, @Status, @Amount)
SELECT @RC = SCOPE_IDENTITY();
UPDATE [UM_Portal].[Customer]
SET
YTDOrders = YTDOrders + @Amount
WHERE [CustomerID] = @CustomerID
--COMMIT TRANSACTION
RETURN @RC
END
--GO