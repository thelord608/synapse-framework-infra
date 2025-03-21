/****** Object:  Table [dbo].[CopyActivityDataADLS] ******/
CREATE TABLE [dbo].[CopyActivityDataADLS](
	[CopyActivityDataADLSKey] [int] IDENTITY(1,1) NOT NULL,
	[CopyActivityDataADLSName] [varchar](100) NULL,
	[CopyActivityDataADLSFolderPath] [varchar](1000) NULL,
	[CopyActivityDataADLSFileName] [varchar](100) NULL,
	[IsActive] [bit] NULL,
	[LastRunDate] [datetime2](7) NULL,
	[CreateDate] [date] NULL,
	[ModifiedDate] [date] NULL,
	[ModifiedUser] [varchar](100) NULL,
	[CopyActivityDataADLSContainerName] [varchar](100) NULL,
 CONSTRAINT [PKCopyActivityDataADLSKey] PRIMARY KEY CLUSTERED 
(
	[CopyActivityDataADLSKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
