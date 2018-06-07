--liquibase formatted sql

CREATE SCHEMA [UM_Portal] AUTHORIZATION [dbo];

CREATE TABLE [UM_Portal].[Customer] (
    [CustomerID]   INT           IDENTITY (1, 1) NOT NULL,
    [CustomerName] NVARCHAR (40) NOT NULL,
    [YTDOrders]    INT           NOT NULL,
    [YTDSales]     INT           NOT NULL
);

CREATE TABLE [UM_Portal].[Orders] (
    [CustomerID] INT      NOT NULL,
    [OrderID]    INT      IDENTITY (1, 1) NOT NULL,
    [OrderDate]  DATETIME NOT NULL,
    [FilledDate] DATETIME NULL,
    [Status]     CHAR (1) NOT NULL,
    [Amount]     INT      NOT NULL
);

ALTER TABLE [UM_Portal].[Customer]
    ADD CONSTRAINT [Def_Customer_YTDOrders] DEFAULT 0 FOR [YTDOrders];

ALTER TABLE [UM_Portal].[Customer]
    ADD CONSTRAINT [Def_Customer_YTDSales] DEFAULT 0 FOR [YTDSales];

ALTER TABLE [UM_Portal].[Orders]
    ADD CONSTRAINT [Def_Orders_OrderDate] DEFAULT GetDate() FOR [OrderDate];

ALTER TABLE [UM_Portal].[Orders]
    ADD CONSTRAINT [Def_Orders_Status] DEFAULT 'O' FOR [Status];

ALTER TABLE [UM_Portal].[Customer]
    ADD CONSTRAINT [PK_Customer_CustID] PRIMARY KEY CLUSTERED ([CustomerID] ASC) WITH (ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, PAD_INDEX = OFF, IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF);

ALTER TABLE [UM_Portal].[Orders]
    ADD CONSTRAINT [PK_Orders_OrderID] PRIMARY KEY CLUSTERED ([OrderID] ASC) WITH (ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, PAD_INDEX = OFF, IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF);

ALTER TABLE [UM_Portal].[Orders]
    ADD CONSTRAINT [FK_Orders_Customer_CustID] FOREIGN KEY ([CustomerID]) REFERENCES [UM_Portal].[Customer] ([CustomerID]) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE [UM_Portal].[Orders]
    ADD CONSTRAINT [CK_Orders_FilledDate] CHECK ((FilledDate >= OrderDate) AND (FilledDate < '01/01/2020'));

ALTER TABLE [UM_Portal].[Orders]
    ADD CONSTRAINT [CK_Orders_OrderDate] CHECK ((OrderDate > '01/01/2005') and (OrderDate < '01/01/2020'));