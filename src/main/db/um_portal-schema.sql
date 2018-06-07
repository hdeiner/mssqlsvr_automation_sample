--liquibase formatted sql

CREATE TABLE [UM_Portal].[ProviderType] (
    [ProviderTypeId]   INT          IDENTITY (1, 1) NOT NULL,
    [CustomerName]     VARCHAR (20)                 NOT NULL,
    [Active]           BIT                          NOT NULL,
    [CreatedBy]        VARCHAR (32),
    [CreateTime]       DATETIME,
    [ModifieddBy]      VARCHAR (32),
    [ModifyTime]       DATETIME,
    CONSTRAINT [ProviderTypeId] PRIMARY KEY ([ProviderTypeId])
);

CREATE TABLE [UM_Portal].[State] (
    [StateId]          INT          IDENTITY (1, 1) NOT NULL,
    [Code]             VARCHAR (2)                  NOT NULL,
    [Active]           BIT                          NOT NULL,
    [Description]      VARCHAR (64)                 NOT NULL,
    [CreatedBy]        VARCHAR (32),
    [CreateTime]       DATETIME,
    [ModifieddBy]      VARCHAR (32),
    [ModifyTime]       DATETIME,
    CONSTRAINT [StateId] PRIMARY KEY ([StateId])
);

CREATE TABLE [UM_Portal].[EDIRequestor] (
    [EDIRequestorId]              INT          IDENTITY (1, 1) NOT NULL,
    [FKProviderTypeId]            INT                          NOT NULL,
    [NPI]                         VARCHAR (15),
    [Suffix]                      VARCHAR (10),
    [FirstName]                   VARCHAR (30),
    [LastName]                    VARCHAR (50)                 NOT NULL,
    [MiddleName]                  VARCHAR (50),
    [FKEDIProviderInvitationId]   INT,
    [Active]                      BIT                          NOT NULL,
    [CreatedBy]                   VARCHAR (32),
    [CreateTime]                  DATETIME,
    [ModifieddBy]                 VARCHAR (32),
    [ModifyTime]                  DATETIME,
    CONSTRAINT [EDIRequestorId]   PRIMARY KEY ([EDIRequestorId]),
    CONSTRAINT [FKProviderTypeId] FOREIGN KEY ([FKProviderTypeId])
                                  REFERENCES [UM_Portal].[ProviderType] ([ProviderTypeId])
);

CREATE TABLE [UM_Portal].[EDIProviderInvitation] (
    [EDIProviderInvitationId]   INT          IDENTITY (1, 1) NOT NULL,
    [FirstName]                 VARCHAR (30),
    [LastName]                  VARCHAR (50)                 NOT NULL,
    [RegistrationNumber]        VARCHAR (20)                 NOT NULL,
    [CreateTime]       DATETIME,
    [ModifieddBy]      VARCHAR (32),
    [ModifyTime]       DATETIME,
    CONSTRAINT [EDIProviderInvitationId] PRIMARY KEY ([EDIProviderInvitationId]),
);