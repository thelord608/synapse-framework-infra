/****** Object:  Table [dbo].[SystemParameter] ******/
CREATE TABLE [dbo].[SystemParameter] (
    [SystemParameterKey]   INT           IDENTITY (1, 1) NOT NULL,
	[SystemKey]			  INT NOT NULL,
    [SystemParameterName]  VARCHAR (50)  NOT NULL,
    [SystemParameterValue] VARCHAR (100) NOT NULL,
    [CreatedDate]          DATETIME      NOT NULL,
    [ModifiedDate]         DATETIME      NULL,
    CONSTRAINT [PK_SystemParameter] PRIMARY KEY CLUSTERED ([SystemParameterKey] ASC)
);
