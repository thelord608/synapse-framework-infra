/****** Object:  Table [dbo].[System] ******/
CREATE TABLE [dbo].[System](
	[SystemKey] INT IDENTITY(1,1) NOT NULL,
	[SystemName] [varchar](255) NOT NULL,
	[SystemTypeKey] INT NOT NULL,
	[SystemDate] datetime NULL,
	[SystemCreatedBy] [varchar](255) NULL,
	[CreatedDate] datetime NOT NULL,
	[ModifiedDate] datetime NULL,
 CONSTRAINT [PKsys] PRIMARY KEY CLUSTERED 
(
	[SystemKey] ASC
))
GO