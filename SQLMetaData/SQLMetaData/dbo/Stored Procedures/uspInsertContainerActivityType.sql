/****** Object:  StoredProcedure [dbo].[uspInsertContainerActivityType] ******/
CREATE PROCEDURE [dbo].[uspInsertContainerActivityType]
 @ContainerActivityTypeName VARCHAR(255)
,@ContainerActivityTypeKey INT OUTPUT
AS
BEGIN
	DECLARE @tblContainerActivityTypeKey AS TABLE (ContainerActivityTypeKey INT);

	SELECT @ContainerActivityTypeKey = ContainerActivityTypeKey
	FROM dbo.ContainerActivityType
	WHERE ContainerActivityTypeName = @ContainerActivityTypeName;

	IF @ContainerActivityTypeKey IS NULL
	BEGIN
		INSERT dbo.ContainerActivityType(ContainerActivityTypeName,CreatedDate)
		OUTPUT INSERTED.ContainerActivityTypeKey INTO @tblContainerActivityTypeKey
		VALUES(@ContainerActivityTypeName,SYSDATETIME());

		SELECT TOP 1 @ContainerActivityTypeKey = ContainerActivityTypeKey FROM @tblContainerActivityTypeKey;
	END
END
GO
