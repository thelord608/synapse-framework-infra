/****** Object:  StoredProcedure [dbo].[uspPopulateADLSPaths] ******/
CREATE PROCEDURE [dbo].[uspPopulateADLSPaths] AS
BEGIN
	DECLARE @Count INT
	SET @Count = (SELECT COUNT(1) FROM [dbo].[ADLSPaths] WITH (NOLOCK))
	IF @Count = 0
	BEGIN		
		INSERT INTO [dbo].[ADLSPaths]
		SELECT * FROM [dbo].[temp_ADLSPaths]
	END
	ELSE
	BEGIN
		MERGE INTO [dbo].[ADLSPaths] AS TARGET
		USING [dbo].[temp_ADLSPaths] AS SOURCE
		ON (TARGET.FileName = SOURCE.FileName
		    AND TARGET.FilePath = SOURCE.FilePath
		    AND TARGET.ContainerName = SOURCE.ContainerName
			AND TARGET.CopyActivityExecutionGroupName = SOURCE.CopyActivityExecutionGroupName
			AND TARGET.CopyActivityOrder = SOURCE.CopyActivityOrder
			AND TARGET.CopyActivityDataFileSystemContainerName = SOURCE.CopyActivityDataFileSystemContainerName)
		WHEN NOT MATCHED BY TARGET
		THEN INSERT (FileName,FilePath,ContainerName,CopyActivityExecutionGroupName,
		             IsProcessed,CopyActivityOrder,CopyActivityDataFileSystemContainerName)
		     VALUES (SOURCE.FileName,SOURCE.FilePath,SOURCE.ContainerName,
			         SOURCE.CopyActivityExecutionGroupName,SOURCE.IsProcessed,
					 SOURCE.CopyActivityOrder,SOURCE.CopyActivityDataFileSystemContainerName)
		WHEN NOT MATCHED BY SOURCE
		THEN DELETE;

	END
END
