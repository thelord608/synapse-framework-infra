/****** Object:  Table [dbo].[Notebook] ******/
CREATE TABLE [dbo].[Notebook](
	[NotebookKey] [int] IDENTITY(1,1) NOT NULL,
	[NotebookName] [varchar](255) NOT NULL,
	[NotebookCreationDate] [datetime] NULL,
	[NotebookCreatedBy] [varchar](255) NULL,
	[CreatedDate] [datetime] NOT NULL,
	[ModifiedDate] [datetime] NULL,
 CONSTRAINT [PKnb] PRIMARY KEY CLUSTERED 
(
	[NotebookKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
