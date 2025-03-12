/****** Object:  Table [dbo].[DataSource] ******/
CREATE TABLE [dbo].[DataSource] (
    [DataSourceKey]     INT           IDENTITY (1, 1) NOT NULL,
    [DataSourceName]    VARCHAR (255) NOT NULL,
    [DataSourceTypeKey] INT           NOT NULL,
    [CreatedDate]       DATETIME      NOT NULL,
    [ModifiedDate]      DATETIME      NULL,
    CONSTRAINT [PK33] PRIMARY KEY CLUSTERED ([DataSourceKey] ASC),
    CONSTRAINT [FK_DataSource_DataSourceType] FOREIGN KEY ([DataSourceTypeKey]) REFERENCES [dbo].[DataSourceType] ([DataSourceTypeKey]),
    CONSTRAINT [FK_DataSource_DataSourceType1] FOREIGN KEY ([DataSourceTypeKey]) REFERENCES [dbo].[DataSourceType] ([DataSourceTypeKey])
);

