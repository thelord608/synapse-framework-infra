/****** Object:  Table [dbo].[DataSourceType] ******/
CREATE TABLE [dbo].[DataSourceType] (
    [DataSourceTypeKey]  INT          IDENTITY (1, 1) NOT NULL,
    [DataSourceTypeName] VARCHAR (20) NOT NULL,
    [CreatedDate]        DATETIME     NOT NULL,
    [ModifiedDate]       DATETIME     NULL,
    CONSTRAINT [PK34] PRIMARY KEY CLUSTERED ([DataSourceTypeKey] ASC)
);

