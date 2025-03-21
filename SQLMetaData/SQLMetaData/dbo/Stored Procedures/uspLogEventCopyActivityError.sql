/****** Object:  StoredProcedure [dbo].[uspLogEventCopyActivityError] ******/
CREATE PROCEDURE [dbo].[uspLogEventCopyActivityError]
(    
	  @CopyActivityExecutionLogKey			bigint						--User::CopyActivityLogKey
    , @SourceName						varchar(255)				--User::SourceName
    , @ErrorCode						int							--System::ErrorCode
    , @ErrorDescription					varchar(2000)				--System::ErrorDescription
)
AS
BEGIN

    SET NOCOUNT ON

    INSERT INTO CopyActivityErrorLog 
		(
			 CopyActivityExecutionLogKey
			,SourceName
			,ErrorCode
			,ErrorDescription
			,CreatedDate
		)
    VALUES 
		(
			 @CopyActivityExecutionLogKey
			,@SourceName
			,@ErrorCode
			,@ErrorDescription
			,GetDate()
		)

    UPDATE CopyActivityExecutionLog
       SET CopyActivityStatus = 'Failed',
           CopyActivityEndDate = GetDate()
    WHERE  CopyActivityExecutionLogKey = @CopyActivityExecutionLogKey

END
GO
