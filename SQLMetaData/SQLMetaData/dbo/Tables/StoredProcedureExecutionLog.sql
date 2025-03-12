CREATE TABLE [dbo].[StoredProcedureExecutionLog](
	[ExecutionLogKey]					[bigint] IDENTITY(1,1)	NOT NULL,
	[ParentActivityExecutionLogKey]		[bigint]				NULL,			-- either pipeline or notebook
	[ParentActivityType]				[varchar](50)			NULL,			-- either pipeline or notebook
	[StoredProcedureName]				[varchar](255)			NOT NULL,		-- fully qualified name of the sproc
	[StoredProcedureParams]				[varchar](4000)			NULL,			-- optional list of params passed into the sproc

	[StartDate]							[datetime]				NOT NULL,
	[EndDate]							[datetime]				NULL,
	[Status]							[varchar](50)			NOT NULL,

	[WorkingSet]						[bigint]				NULL,			-- no of records the sproc worked on
	[Inserts]							[bigint]				NULL,			-- no of records the sproc inserted
	[Updates]							[bigint]				NULL,			-- no of records the sproc updated
	[Warnings]							[int]					NULL,			-- no of warnings raised by the sproc
	[Errors]							[int]					NULL,			-- no of errors raised by the sproc
	
	[CreatedDate]						[datetime]				NOT NULL,
	[ModifiedDate]						[datetime]				NULL,
 CONSTRAINT [PKspel] PRIMARY KEY CLUSTERED 
(
	[ExecutionLogKey] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO