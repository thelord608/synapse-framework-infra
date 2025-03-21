/****** Object:  StoredProcedure [dbo].[uspCopyActivitySink] ******/
CREATE PROCEDURE [dbo].[uspCopyActivitySink]
AS
BEGIN
DECLARE @Counter INT = 1
DECLARE @RowCount INT
DECLARE @SQLData NVARCHAR(MAX)
DECLARE @SQLQuery VARCHAR (MAX)
SET @RowCount = (SELECT COUNT(1) FROM [dbo].[CopyActivitySink_Staging])

DROP TABLE IF EXISTS #CopyActivitySink_Staging
SELECT ROW_NUMBER() OVER(ORDER BY [SQL Script to Merge] ASC) AS ID
,[SQL Script to Merge]
INTO #CopyActivitySink_Staging
FROM 
[dbo].[CopyActivitySink_Staging]

WHILE (@Counter <= @RowCount)
BEGIN
SET @SQLData = (SELECT STUFF ([SQL Script to Merge],CHARINDEX('UNION ALL',[SQL Script to Merge]),10,'') FROM #CopyActivitySink_Staging WHERE ID = @Counter)
SET @SQLQuery = N'
SET IDENTITY_INSERT dbo.CopyActivitySink ON;

MERGE dbo.CopyActivitySink AS t
  USING (   
  '+@SQLData+'
  ) as  s
		(   [CopyActivitySinkKey]
		   ,[CopyActivitySinkName]
           ,[CopyActivitySinkDataKey]
           ,[CopyActivitySinkDataTypeKey]
           ,[CopyActivitySinkDataTargetKey]
           ,[CopyActivitySinkDataTargetTypeKey]
           ,[IsActive]
           ,[LastRunDate]
           ,[CreateDate]
           ,[ModifiedDate]
           ,[ModifiedUser])
ON ( t.[CopyActivitySinkKey] = s.[CopyActivitySinkKey] )
WHEN MATCHED THEN 
	UPDATE SET   
			[CopyActivitySinkName] = s.[CopyActivitySinkName]
           ,[CopyActivitySinkDataKey] = s.[CopyActivitySinkDataKey]
           ,[CopyActivitySinkDataTypeKey] = s.[CopyActivitySinkDataTypeKey]
           ,[CopyActivitySinkDataTargetKey] = s.[CopyActivitySinkDataTargetKey]
           ,[CopyActivitySinkDataTargetTypeKey] = s.[CopyActivitySinkDataTargetTypeKey]
           ,[IsActive] = s.[IsActive]
           ,[LastRunDate] = s.[LastRunDate]
           ,[CreateDate] = s.[CreateDate]
           ,[ModifiedDate] = s.[ModifiedDate]
           ,[ModifiedUser] = s.[ModifiedUser]
WHEN NOT MATCHED BY TARGET THEN
    INSERT( [CopyActivitySinkKey]
		   ,[CopyActivitySinkName]
           ,[CopyActivitySinkDataKey]
           ,[CopyActivitySinkDataTypeKey]
           ,[CopyActivitySinkDataTargetKey]
           ,[CopyActivitySinkDataTargetTypeKey]
           ,[IsActive]
           ,[LastRunDate]
           ,[CreateDate]
           ,[ModifiedDate]
           ,[ModifiedUser]
		  )	
    VALUES(
		   [CopyActivitySinkKey]
		   ,[CopyActivitySinkName]
           ,[CopyActivitySinkDataKey]
           ,[CopyActivitySinkDataTypeKey]
           ,[CopyActivitySinkDataTargetKey]
           ,[CopyActivitySinkDataTargetTypeKey]
           ,[IsActive]
           ,[LastRunDate]
           ,[CreateDate]
           ,[ModifiedDate]
           ,[ModifiedUser]
		  );
SET IDENTITY_INSERT dbo.CopyActivitySink OFF;'
EXEC (@SQLQuery)
SET @Counter = @Counter + 1
END

END
GO
