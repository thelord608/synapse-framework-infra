/****** Object:  Table [dbo].[CopyActivityExecutionPlan] ******/
CREATE TABLE [dbo].[CopyActivityExecutionPlan](
	[CopyActivitySinkKey] [int] NOT NULL,
	[CopyActivityExecutionGroupKey] [int] NOT NULL,
	[ContainerKey] [int] NOT NULL,
	[CopyActivityOrder] [int] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[IsEmailEnabled] [bit] NOT NULL,
	[IsRestart] [bit] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[ModifiedDate] [datetime] NULL,
 CONSTRAINT [PKca] PRIMARY KEY CLUSTERED 
(
	[CopyActivitySinkKey] ASC,
	[CopyActivityExecutionGroupKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CopyActivityExecutionPlan]  WITH CHECK ADD  CONSTRAINT [RefCopyActivityExecutionGroup29] FOREIGN KEY([CopyActivityExecutionGroupKey])
REFERENCES [dbo].[CopyActivityExecutionGroup] ([CopyActivityExecutionGroupKey])
GO
ALTER TABLE [dbo].[CopyActivityExecutionPlan] CHECK CONSTRAINT [RefCopyActivityExecutionGroup29]
GO
ALTER TABLE [dbo].[CopyActivityExecutionPlan]  WITH CHECK ADD  CONSTRAINT [RefCopyActivitypt] FOREIGN KEY([ContainerKey])
REFERENCES [dbo].[Container] ([ContainerKey])
GO
ALTER TABLE [dbo].[CopyActivityExecutionPlan] CHECK CONSTRAINT [RefCopyActivitypt]
GO
ALTER TABLE [dbo].[CopyActivityExecutionPlan]  WITH CHECK ADD  CONSTRAINT [RefCopyActivitySink28] FOREIGN KEY([CopyActivitySinkKey])
REFERENCES [dbo].[CopyActivitySink] ([CopyActivitySinkKey])
GO
ALTER TABLE [dbo].[CopyActivityExecutionPlan] CHECK CONSTRAINT [RefCopyActivitySink28]
GO
