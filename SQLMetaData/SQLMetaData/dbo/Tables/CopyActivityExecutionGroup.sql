/****** Object:  Table [dbo].[CopyActivityExecutionGroup] ******/
CREATE TABLE [dbo].[CopyActivityExecutionGroup](
	[CopyActivityExecutionGroupKey] [int] IDENTITY(1,1) NOT NULL,
	[CopyActivityExecutionGroupName] [varchar](100) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[IsEmailEnabled] [bit] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[ModifiedDate] [datetime] NULL,
 CONSTRAINT [PKcaeg] PRIMARY KEY CLUSTERED 
(
	[CopyActivityExecutionGroupKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
