CREATE PROCEDURE [dbo].[uspLogEventStoredProcedureEnd] 
(    
	  @SProcExecutionLogKey	bigint
    , @Status				varchar(50)
	, @WorkingSet			bigint
	, @Inserts				bigint
	, @Updates				bigint
	, @Warnings				int
	, @Errors				int
)
AS
BEGIN

	SET NOCOUNT ON
    
    UPDATE [dbo].[StoredProcedureExecutionLog]
	   SET 
		   [Status]		=	@Status
		  ,[WorkingSet] =	@WorkingSet	
		  ,[Inserts]	=	@Inserts		
		  ,[Updates]	=	@Updates		
		  ,[Warnings]	=	@Warnings		
		  ,[Errors]		=	@Errors		
		  ,[EndDate]	=	GetDate()
		  ,[ModifiedDate] = GetDate()
     WHERE ExecutionLogKey = @SProcExecutionLogKey
	 
END
GO