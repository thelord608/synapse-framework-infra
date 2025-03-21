/****** Object:  StoredProcedure [dbo].[uspInsertContainerExecutionPlan_ForNotebookContainer] ******/
CREATE PROCEDURE [dbo].[uspInsertContainerExecutionPlan_ForNotebookContainer]
 @ContainerName VARCHAR(255)
,@DataFactoryName VARCHAR(255)
,@ContainerExecutionGroupName VARCHAR(255)
,@NotebookExecutionGroupName VARCHAR(255)
,@ContainerActivityTypeName VARCHAR(255)
,@ContainerOrder INT
AS
BEGIN
	DECLARE @ContainerKey INT;
	DECLARE @DataFactoryKey INT;
	DECLARE @ContainerExecutionGroupKey INT;
	DECLARE @NotebookExecutionGroupKey INT;
	DECLARE @ContainerActivityTypeKey INT;	

	EXEC dbo.uspInsertContainer @ContainerName=@ContainerName,@ContainerKey=@ContainerKey OUTPUT;
	EXEC dbo.uspInsertDataFactory @DataFactoryName=@DataFactoryName,@DataFactoryKey=@DataFactoryKey OUTPUT;
	EXEC dbo.uspInsertContainerExecutionGroup @ContainerName=@ContainerName,@ContainerExecutionGroupName=@ContainerExecutionGroupName,@ContainerExecutionGroupKey=@ContainerExecutionGroupKey OUTPUT;
	EXEC dbo.uspInsertNotebookExecutionGroup @ContainerExecutionGroupName=@ContainerExecutionGroupName,@NotebookExecutionGroupName=@NotebookExecutionGroupName,@NotebookExecutionGroupKey=@NotebookExecutionGroupKey OUTPUT;
	EXEC dbo.uspInsertContainerActivityType @ContainerActivityTypeName=@ContainerActivityTypeName,@ContainerActivityTypeKey=@ContainerActivityTypeKey OUTPUT;
	
	MERGE dbo.ContainerExecutionPlan t
	USING
	(
		SELECT 
		 @ContainerKey AS ContainerKey
		,@DataFactoryKey AS DataFactoryKey
		,@ContainerExecutionGroupKey AS ContainerExecutionGroupKey
		,@NotebookExecutionGroupKey AS ExecutionGroupKey
		,@ContainerActivityTypeKey AS ContainerActivityTypeKey
		,@ContainerOrder AS ContainerOrder
	) s ON t.ContainerKey=s.ContainerKey
		AND t.DataFactoryKey=s.DataFactoryKey
		AND t.ContainerExecutionGroupKey=s.ContainerExecutionGroupKey
		AND t.ExecutionGroupKey=s.ExecutionGroupKey
		AND t.ContainerActivityTypeKey=s.ContainerActivityTypeKey
	WHEN MATCHED THEN UPDATE
	SET 
	 t.ContainerOrder=s.ContainerOrder
	,t.IsActive=1
	,t.IsEmailEnabled=0
	,t.IsRestart=1
	,t.ModifiedDate = SYSDATETIME()
	WHEN NOT MATCHED THEN INSERT
	(
	 ContainerKey
	,DataFactoryKey
	,ContainerExecutionGroupKey
	,ExecutionGroupKey
	,ContainerActivityTypeKey
	,ContainerOrder
	,IsActive
	,IsEmailEnabled
	,IsRestart
	,CreatedDate
	)
	VALUES
	(
	 s.ContainerKey
	,s.DataFactoryKey
	,s.ContainerExecutionGroupKey
	,s.ExecutionGroupKey
	,s.ContainerActivityTypeKey
	,s.ContainerOrder
	,1
	,0
	,1
	,SYSDATETIME()
	);
END
GO
