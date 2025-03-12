CREATE PROCEDURE [dbo].[uspLogEventStoredProcedureStart] 
(    	
       @StoredProcedureName					varchar(255)		
     , @StoredProcedureParams        		varchar(4000)	-- optional parameters passed to sproc - useful for debugging	
	 , @ParentActivityExecutionLogKey		bigint			-- the parent activity that initiated the sproc (CopyActivity/Notebook)			
)

AS
BEGIN

    SET NOCOUNT ON

    DECLARE @SProcExecutionLogKey		bigint
      	 
	INSERT INTO [dbo].[StoredProcedureExecutionLog]
           ([StoredProcedureName]				
		   ,[StoredProcedureParams]        	
		   ,[ParentActivityExecutionLogKey]	
		   ,[Status]
		   ,[StartDate]			
		   )
    VALUES
		(
			  @StoredProcedureName			
			 ,@StoredProcedureParams        
			 ,@ParentActivityExecutionLogKey
			 ,'Running'
			 ,GetDate()
		)

	SELECT @SProcExecutionLogKey = SCOPE_IDENTITY()
	
	SELECT @SProcExecutionLogKey as ExecutionLogKey 

END
GO