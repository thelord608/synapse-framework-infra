/****** Object:  Table [dbo].[SystemActivityType] ******/
CREATE TABLE [dbo].[SystemActivityType] (
    [SystemActivityTypeKey]  INT          IDENTITY (1, 1) NOT NULL,
    [SystemActivityTypeName] VARCHAR (20) NOT NULL,
    [CreatedDate]         DATETIME     NOT NULL,
    [ModifiedDate]        DATETIME     NULL,
    CONSTRAINT [PKsat] PRIMARY KEY CLUSTERED ([SystemActivityTypeKey] ASC)
);

