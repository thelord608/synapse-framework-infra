/****** Object:  StoredProcedure [dbo].[uspInsertContainerExecutionGroup] ******/
CREATE PROCEDURE [dbo].[uspInsertContainerExecutionGroup]
 @ContainerExecutionGroupName VARCHAR(100)
,@ContainerName VARCHAR(100)
,@ContainerExecutionGroupKey INT OUTPUT
AS
BEGIN
	DECLARE @tblContainerExecutionGroup AS TABLE (ContainerExecutionGroupKey INT);
	DECLARE @ContainerKey INT;
	
	SELECT @Containerkey = ContainerKey 
	FROM dbo.Container 
	WHERE ContainerName = @ContainerName

	SELECT @ContainerExecutionGroupKey = ContainerExecutionGroupKey
	FROM dbo.ContainerExecutionGroup
	WHERE ContainerExecutionGroupName = @ContainerExecutionGroupName;

	IF @ContainerExecutionGroupKey IS NULL
	BEGIN
		INSERT dbo.ContainerExecutionGroup(ContainerExecutionGroupName,ContainerKey,CreatedDate,IsActive,IsEmailEnabled)
		OUTPUT INSERTED.ContainerExecutionGroupKey INTO @tblContainerExecutionGroup
		VALUES(@ContainerExecutionGroupName,@ContainerKey,SYSDATETIME(),1,0);

		SELECT TOP 1 @ContainerExecutionGroupKey = ContainerExecutionGroupKey FROM @tblContainerExecutionGroup;
	END
END
GO
