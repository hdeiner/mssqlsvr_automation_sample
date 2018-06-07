--liquibase formatted sql

CREATE TABLE [UM_Portal].[ProviderType] (
    [ProviderTypeId]   INT          IDENTITY (1, 1) NOT NULL,
    [CustomerName]     VARCHAR (20)                 NOT NULL,
    [Active]           BIT                          NOT NULL,
    [CreatedBy]        VARCHAR (32),
    [CreateTime]       DATETIME,
    [ModifieddBy]      VARCHAR (32),
    [ModifyTime]       DATETIME
);

CREATE TABLE [UM_Portal].[State] (
    [StateId]          INT          IDENTITY (1, 1) NOT NULL,
    [Code]             VARCHAR (2)                  NOT NULL,
    [Active]           BIT                          NOT NULL,
    [Description]      VARCHAR (64)                 NOT NULL,
    [CreatedBy]        VARCHAR (32),
    [CreateTime]       DATETIME,
    [ModifieddBy]      VARCHAR (32),
    [ModifyTime]       DATETIME
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
    [ModifyTime]                  DATETIME
);

CREATE TABLE [UM_Portal].[EDIProviderInvitation] (
    [EDIProviderInvitationId]   INT          IDENTITY (1, 1) NOT NULL,
    [FirstName]                 VARCHAR (30),
    [LastName]                  VARCHAR (50)                 NOT NULL,
    [RegistrationNumber]        VARCHAR (20)                 NOT NULL,
    [InvitationSentDate]        DATETIME                     NOT NULL,
    [FKEDIProviderStatusId]     INT                          NOT NULL,
    [CreateTime]                DATETIME,
    [ModifieddBy]               VARCHAR (32),
    [ModifyTime]                DATETIME
);

ALTER TABLE [UM_Portal].[ProviderType]
    ADD CONSTRAINT [ProviderTypeId]
    PRIMARY KEY   ([ProviderTypeId]);

ALTER TABLE [UM_Portal].[State]
    ADD CONSTRAINT [StateId]
    PRIMARY KEY   ([StateId]);

ALTER TABLE [UM_Portal].[EDIRequestor]
    ADD CONSTRAINT [EDIRequestorId]
    PRIMARY KEY   ([EDIRequestorId]);

ALTER TABLE [UM_Portal].[EDIProviderInvitation]
    ADD CONSTRAINT [EDIProviderInvitationId]
    PRIMARY KEY   ([EDIProviderInvitationId]);

ALTER TABLE [UM_Portal].[EDIRequestor]
    ADD CONSTRAINT [FKProviderTypeId]
    FOREIGN KEY   ([FKProviderTypeId])
    REFERENCES     [UM_Portal].[ProviderType] ([ProviderTypeId]);

ALTER TABLE [UM_Portal].[EDIRequestor]
    ADD CONSTRAINT [FKEDIProviderInvitationId]
    FOREIGN KEY   ([FKEDIProviderInvitationId])
    REFERENCES     [UM_Portal].[EDIProviderInvitation] ([EDIProviderInvitationId]);

