/****** Object:  Table [dbo].[CopyActivityErrorLog] ******/
CREATE TABLE [dbo].[CopyActivityErrorLog](
	[CopyActivityErrorLogKey] [bigint] IDENTITY(1,1) NOT NULL,
	[CopyActivityExecutionLogKey] [bigint] NOT NULL,
	[SourceName] [varchar](255) NOT NULL,
	[ErrorCode] [int] NULL,
	[ErrorDescription] [varchar](2000) NULL,
	[CreatedDate] [datetime] NOT NULL,
	[ModifiedDate] [datetime] NULL,
 CONSTRAINT [PKcaerrorlog] PRIMARY KEY CLUSTERED 
(
	[CopyActivityErrorLogKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CopyActivityErrorLog]  WITH CHECK ADD  CONSTRAINT [RefCopyActivityExecutionLog] FOREIGN KEY([CopyActivityExecutionLogKey])
REFERENCES [dbo].[CopyActivityExecutionLog] ([CopyActivityExecutionLogKey])
GO
ALTER TABLE [dbo].[CopyActivityErrorLog] CHECK CONSTRAINT [RefCopyActivityExecutionLog]
GO
