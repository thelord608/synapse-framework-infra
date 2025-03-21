/****** Object:  StoredProcedure [dbo].[uspInsertDataFactory] ******/
CREATE PROCEDURE [dbo].[uspInsertDataFactory]
 @DataFactoryName VARCHAR(255)
,@DataFactoryKey INT OUTPUT
AS
BEGIN
	DECLARE @tblDataFactoryKey AS TABLE (DataFactoryKey INT);

	SELECT @DataFactoryKey = DataFactoryKey
	FROM dbo.DataFactory
	WHERE DataFactoryName = @DataFactoryName;

	IF @DataFactoryKey IS NULL
	BEGIN
		INSERT dbo.DataFactory(DataFactoryName,CreatedDate)
		OUTPUT INSERTED.DataFactoryKey INTO @tblDataFactoryKey
		VALUES(@DataFactoryName,SYSDATETIME());

		SELECT TOP 1 @DataFactoryKey = DataFactoryKey FROM @tblDataFactoryKey;
	END
END
GO
