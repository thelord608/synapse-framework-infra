CREATE TABLE [dbo].[StoredProcedureErrorLog](
	[ErrorLogKey] [bigint] IDENTITY(1,1) NOT NULL,
	[ExecutionLogKey] [bigint] NOT NULL,
	[ErrorLevel] [varchar](10) NULL,
	[ErrorCode] [int] NULL,
	[ErrorDescription] [varchar](2000) NULL,
	[CreatedDate] [datetime] NOT NULL,
 CONSTRAINT [PKsperrorlog] PRIMARY KEY CLUSTERED 
(
	[ErrorLogKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[StoredProcedureErrorLog]  WITH CHECK ADD  CONSTRAINT [RefStoredProcedureExecutionLog] FOREIGN KEY([ExecutionLogKey])
REFERENCES [dbo].[StoredProcedureExecutionLog] ([ExecutionLogKey])
GO
ALTER TABLE [dbo].[StoredProcedureErrorLog] CHECK CONSTRAINT [RefStoredProcedureExecutionLog]
GO