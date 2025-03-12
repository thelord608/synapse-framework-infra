/****** Object:  StoredProcedure [dbo].[uspInsertSystem] ******/
CREATE PROCEDURE dbo.uspInsertSystem
 @SystemName VARCHAR(255)
,@SystemKey INT OUTPUT
AS
BEGIN
	DECLARE @tblSystemKey AS TABLE (SystemKey INT);

	SELECT @SystemKey = SystemKey
	FROM dbo.System
	WHERE SystemName = @SystemName;

	IF @SystemKey IS NULL
	BEGIN
		INSERT dbo.System(SystemName,CreatedDate)
		OUTPUT INSERTED.SystemKey INTO @tblSystemKey
		VALUES(@SystemName,SYSDATETIME());

		SELECT TOP 1 @SystemKey = SystemKey FROM @tblSystemKey;
	END
END
GO