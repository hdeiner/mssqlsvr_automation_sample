--liquibase formatted sql
--PRINT N'Creating Sales.uspNewCustomer...';
--GO
CREATE PROCEDURE [Sales].[newCustomer]
@CustomerName NVARCHAR (40)
AS
BEGIN
INSERT INTO [Sales].[Customer] (CustomerName) VALUES (@CustomerName);
SELECT SCOPE_IDENTITY()
END
--GO
--PRINT N'Creating Sales.uspPlaceNewOrder...';
--GO