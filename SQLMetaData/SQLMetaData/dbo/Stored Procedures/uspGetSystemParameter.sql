/****** Object:  StoredProcedure [dbo].[uspGetSystemParameter] ******/
CREATE PROCEDURE uspGetSystemParameter
	(
		@SystemParameterName		varchar(50)
	)
AS
BEGIN

	SET NOCOUNT ON

	SELECT SystemParameterValue
	  FROM SystemParameter
	 WHERE SystemParameterName = @SystemParameterName

END