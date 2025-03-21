/****** Object:  StoredProcedure [dbo].[uspCopyActivityDataSQLScript] ******/
CREATE PROCEDURE [dbo].[uspCopyActivityDataSQLScript]
AS
BEGIN
DECLARE @Counter INT = 1
DECLARE @RowCount INT
DECLARE @SQLData NVARCHAR(MAX)
DECLARE @SQLQuery VARCHAR (MAX)
SET @RowCount = (SELECT COUNT(1) FROM [dbo].[CopyActivityDataSQLScript_Staging])

DROP TABLE IF EXISTS #CopyActivityDataSQLScript_Staging
SELECT ROW_NUMBER() OVER(ORDER BY [SQL DATA SCRIPT] ASC) AS ID
,[SQL DATA SCRIPT]
INTO #CopyActivityDataSQLScript_Staging
FROM 
[dbo].[CopyActivityDataSQLScript_Staging]

WHILE (@Counter <= @RowCount)
BEGIN
SET @SQLData = (SELECT STUFF([SQL DATA SCRIPT],LEN([SQL DATA SCRIPT]),1,'') FROM #CopyActivityDataSQLScript_Staging WHERE ID = @Counter)
SET @SQLQuery = N'
SET IDENTITY_INSERT dbo.CopyActivityDataSQLScript ON;

MERGE dbo.CopyActivityDataSQLScript AS t
  USING (
  VALUES 
  '+@SQLData+'
  ) as  s
		(   [CopyActivityDataSQLScriptKey],
			[CopyActivityDataSQLScriptName],
			[CopyActivityDataSqlScript],
			[CopyActivityDataIncrementalSqlScript],
			[IsIncrementalLoad],
			[IsActive],
			[LastRunDate],
			[CreateDate],
			[ModifiedDate],
			[ModifiedUser]  )
ON ( t.[CopyActivityDataSQLScriptKey] = s.[CopyActivityDataSQLScriptKey] )
WHEN MATCHED THEN 
	UPDATE SET   
		   [CopyActivityDataSQLScriptName] =s.[CopyActivityDataSQLScriptName],
			[CopyActivityDataSqlScript] = s.[CopyActivityDataSqlScript],
			[CopyActivityDataIncrementalSqlScript] = s.[CopyActivityDataIncrementalSqlScript],
			[IsIncrementalLoad] = s.[IsIncrementalLoad],
			[IsActive] = s.[IsActive],
			[LastRunDate] = s.[LastRunDate],
			[CreateDate] = s.[CreateDate],
			[ModifiedDate] = s.[ModifiedDate],
			[ModifiedUser] = s.[ModifiedUser]
WHEN NOT MATCHED BY TARGET THEN
    INSERT(
			[CopyActivityDataSQLScriptKey],
			[CopyActivityDataSQLScriptName],
			[CopyActivityDataSqlScript],
			[CopyActivityDataIncrementalSqlScript],
			[IsIncrementalLoad],			
			[IsActive],
			[LastRunDate],
			[CreateDate],
			[ModifiedDate],
			[ModifiedUser]
		  )	
    VALUES(
			 s.[CopyActivityDataSQLScriptKey],
			s.[CopyActivityDataSQLScriptName],
			s.[CopyActivityDataSqlScript],
			s.[CopyActivityDataIncrementalSqlScript],
			s.[IsIncrementalLoad],
			s.[IsActive],
			s.[LastRunDate],
			s.[CreateDate],
			s.[ModifiedDate],
			s.[ModifiedUser]
		  );
SET IDENTITY_INSERT dbo.CopyActivityDataSQLScript OFF;'
PRINT @SQLQUery
EXEC (@SQLQuery)
SET @Counter = @Counter + 1
END

END
GO
