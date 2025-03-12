/****** Object:  StoredProcedure [dbo].[uspGetSystemParameterADF] ******/
CREATE PROCEDURE [dbo].[uspGetSystemParameterADF]  
	(
		@AzureDataFactoryName		varchar(50)

	)
AS
BEGIN

	SET NOCOUNT ON

	SELECT CASE WHEN SystemParameterValue = '9999/99/99' THEN CAST(DATEPART(yyyy,GETDATE()) AS VARCHAR(4)) +'/'+ CAST(DATEPART(MM,GETDATE()) AS VARCHAR(2)) + '/'+CAST(DATEPART(DD,GETDATE()) AS VARCHAR(2)) END as SystemParameterValue
	  FROM SystemParameter
	 WHERE SystemParameterName like @AzureDataFactoryName+'%'

END
GO