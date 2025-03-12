CREATE PROCEDURE [dbo].[uspLogEventStoredProcedureError]
(    
	  @ExecutionLogKey					bigint						
    , @ErrorLevel						[varchar](10)							
    , @ErrorCode						int							
    , @ErrorDescription					varchar(2000)				
)
AS
BEGIN

    SET NOCOUNT ON

    INSERT INTO StoredProcedureErrorLog 
		(
			 ExecutionLogKey
			,ErrorLevel
			,ErrorCode
			,ErrorDescription
			,CreatedDate
		)
    VALUES 
		(
			 @ExecutionLogKey
			,@ErrorLevel
			,@ErrorCode
			,@ErrorDescription
			,GetDate()
		)
	IF (@ErrorLevel = 'Error')
	BEGIN
		UPDATE StoredProcedureExecutionLog
		   SET Status = 'Failed',
			   EndDate = GetDate()
		WHERE  ExecutionLogKey = @ExecutionLogKey
	END

END
GO