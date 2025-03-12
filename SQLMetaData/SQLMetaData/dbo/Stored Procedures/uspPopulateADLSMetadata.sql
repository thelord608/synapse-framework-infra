/****** Object:  StoredProcedure [dbo].[uspPopulateADLSMetadata] ******/
CREATE PROCEDURE [dbo].[uspPopulateADLSMetadata] 
@source_directory_name varchar(30), 
@rawzone_directory_name varchar(30),
@source_ADLS_Container_Name varchar(30),
@rawzone_ADLS_Container_Name varchar(30)
AS
BEGIN
DECLARE @FileCount INT 
DECLARE @Counter INT = 1
DECLARE @FileSystemKeySeed INT

SELECT @FileSystemKeySeed = CopyActivityExecutionGroupKey*100000
  FROM [dbo].[CopyActivityExecutionGroup] caeg INNER JOIN 
       [dbo].[temp_ADLSPaths] tap
	ON caeg.CopyActivityExecutionGroupName=CONCAT(tap.CopyActivityExecutionGroupName,' Copy Process')

DROP TABLE IF EXISTS #TEMP;
CREATE TABLE #TEMP
(
 CopyActivityDataFileSystemKey INT IDENTITY(200,1),
 CopyActivityDataFileSystemName VARCHAR(100),
 CopyActivityDataFileSystemFolderPath VARCHAR (1000),
 CopyActivityDataFileSystemFileName VARCHAR(100),
 CopyActivityExecutionGroupName VARCHAR(100),
 ContainerName VARCHAR(100),
 CopyActivityOrder INT,
 IsActive VARCHAR(100),
 LastRunDate VARCHAR(100),
 CreateDate VARCHAR(100),
 ModifiedDate VARCHAR(100),
 ModifiedUser VARCHAR(100),
 CopyActivityDataFileSystemContainerName VARCHAR(100)
)
DBCC CHECKIDENT (#TEMP,RESEED,@FileSystemKeySeed)
INSERT INTO #TEMP (
 CopyActivityDataFileSystemName ,
 CopyActivityDataFileSystemFolderPath,
 CopyActivityDataFileSystemFileName,
 CopyActivityExecutionGroupName,
 ContainerName,
 CopyActivityOrder,
 IsActive,
 LastRunDate,
 CreateDate,
 ModifiedDate,
 ModifiedUser,
 CopyActivityDataFileSystemContainerName
)
 SELECT CONCAT(CopyActivityExecutionGroupName,'_',FileName) AS CopyActivityDataFileSystemName,
		SUBSTRING(FilePath, CHARINDEX('.net',FilePath) + 5,LEN(FilePath)) AS CopyActivityDataFileSystemFolderPath,
		FileName  AS CopyActivityDataFileSystemFileName,
		CONCAT(CopyActivityExecutionGroupName,' Copy Process'),
		ContainerName,
		CopyActivityOrder,
		'1' AS IsActive,
		'GETDATE()' AS LastRunDate,
		'GETDATE()' AS CreateDate,
		'GETDATE()' AS ModifiedDate,
		'Current_user' AS ModifiedUser,
		CopyActivityDataFileSystemContainerName
 FROM [dbo].[ADLSPaths] where IsProcessed = 0

 
TRUNCATE TABLE dbo.CopyActivityDataFileSystem_Staging
TRUNCATE TABLE dbo.CopyActivityDataADLS_Staging
TRUNCATE TABLE dbo.CopyActivitySink_Staging
TRUNCATE TABLE dbo.CopyActivityParameter_Staging
TRUNCATE TABLE dbo.CopyActivityExecutionPlan_Staging

DROP TABLE IF EXISTS #TEMP1;
 SELECT CONCAT('(',CopyActivityDataFileSystemKey,',''',CopyActivityDataFileSystemName,''',','''/',CopyActivityDataFileSystemFolderPath,''',','''',CopyActivityDataFileSystemFileName,''',','1,GETDATE(),GETDATE(),GETDATE(),Current_user,','''',CopyActivityDataFileSystemContainerName,'''','),') AS [SQL DATA SCRIPT]
 INTO #TEMP1
 FROM #temp

INSERT INTO [dbo].[CopyActivityDataFileSystem_Staging] ([SQL DATA SCRIPT])
SELECT [SQL DATA SCRIPT] FROM #temp1


INSERT INTO [dbo].[CopyActivityDataADLS_Staging] ([SQL Script to Merge])
select REPLACE(REPLACE([SQL DATA SCRIPT], @source_directory_name,@rawzone_directory_name),@source_ADLS_Container_Name,@rawzone_ADLS_Container_Name)
FROM dbo.CopyActivityDataFileSystem_Staging (NOLOCK)

INSERT INTO [dbo].[CopyActivitySink_Staging] ([SQL Script to Merge])
select CONCAT('SELECT ',CopyActivityDataFileSystemKey,',''',CopyActivityDataFileSystemName,''',','cadf.[CopyActivityDataFileSystemKey],cadsts.[CopyActivityDataTypeKey],cadsadls.[CopyActivityDataADLSKey],cadstadls.[CopyActivityDataTypeKey],1,getdate(),getdate(),getdate(),CURRENT_USER FROM [dbo].[CopyActivityDataFileSystem] cadf, [dbo].[CopyActivityDataType] cadsts,[dbo].[CopyActivityDataADLS] cadsadls,[dbo].[CopyActivityDataType] cadstadls where cadf.[CopyActivityDataFileSystemName] = ''',CopyActivityDataFileSystemName,'''','and cadf.[IsActive] = 1  and cadsts.[CopyActivityDataTypeName] = ''File System'' and cadsadls.[CopyActivityDataADLSName] =','''',CopyActivityDataFileSystemName,''' and cadsadls.[IsActive] = 1 and cadstadls.[CopyActivityDataTypeName] = ''Azure Data Lake Store'' UNION ALL') AS [SQL Script to Merge]
FROM #TEMP (NOLOCK) 

INSERT INTO [dbo].[CopyActivityParameter_Staging] ([SQL Script to Merge])
select CONCAT('(',CopyActivityDataFileSystemKey,',''dbConnectionSecret'',''MicrosoftConnectionString'',GetDate(),NULL),') AS [SQL Script to Merge]
FROM #TEMP (NOLOCK) 

INSERT INTO [dbo].[CopyActivityExecutionPlan_Staging] ([SQL Script to Merge])
select CONCAT('SELECT sk.CopyActivitySinkKey, pr.ContainerKey, peg.CopyActivityExecutionGroupKey,',CopyActivityOrder,',1,0,1,GetDate(),NULL FROM dbo.CopyActivityExecutionGroup peg, dbo.Container pr, dbo.CopyActivitySink sk WHERE peg.CopyActivityExecutionGroupName = ''',CopyActivityExecutionGroupName,''' and pr.ContainerName = ''',ContainerName,''' and sk.CopyActivitySinkName = ''',CopyActivityDataFileSystemName,''' UNION ALL ' ) AS [SQL Script to Merge]
FROM #TEMP (NOLOCK) 

EXEC dbo.uspCopyActivityDataFileSystem;
EXEC dbo.uspCopyActivityDataADLS;
EXEC dbo.uspCopyActivitySink;
EXEC dbo.uspCopyActivityParameter;
EXEC dbo.uspCopyActivityExecutionPlan;

END