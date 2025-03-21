/****** Object:  Table [dbo].[NotebookParameter] ******/
CREATE TABLE [dbo].[NotebookParameter](
	[NotebookKey] [int] NOT NULL,
	[NotebookParameterName] [varchar](255) NOT NULL,
	[NotebookParameterValue] [varchar](255) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[ModifiedDate] [datetime] NULL,
 CONSTRAINT [PK_NotebookParameter] PRIMARY KEY CLUSTERED 
(
	[NotebookKey] ASC,
	[NotebookParameterName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[NotebookParameter]  WITH CHECK ADD  CONSTRAINT [FK_NotebookParameter_Notebookkey] FOREIGN KEY([NotebookKey])
REFERENCES [dbo].[Notebook] ([NotebookKey])
GO
ALTER TABLE [dbo].[NotebookParameter] CHECK CONSTRAINT [FK_NotebookParameter_Notebookkey]
GO
