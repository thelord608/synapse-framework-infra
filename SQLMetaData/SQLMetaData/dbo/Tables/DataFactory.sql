/****** Object:  Table [dbo].[DataFactory] ******/
CREATE TABLE [dbo].[DataFactory](
	[DataFactoryKey] [int] IDENTITY(1,1) NOT NULL,
	[DataFactoryName] [varchar](255) NOT NULL,
	[DataFactoryDate] [datetime] NULL,
	[DataFactoryCreatedBy] [varchar](255) NULL,
	[CreatedDate] [datetime] NOT NULL,
	[ModifiedDate] [datetime] NULL,
 CONSTRAINT [PKdf] PRIMARY KEY CLUSTERED 
(
	[DataFactoryKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
