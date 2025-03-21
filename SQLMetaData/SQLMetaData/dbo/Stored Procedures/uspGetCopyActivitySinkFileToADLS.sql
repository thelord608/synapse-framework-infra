/****** Object:  StoredProcedure [dbo].[uspGetCopyActivitySinkFileToADLS] ******/
CREATE PROCEDURE [dbo].[uspGetCopyActivitySinkFileToADLS] 
(
	@CopyActivitySinkName		varchar(100)
	--@ADLSGrain		varchar(10) NULL
)
AS
BEGIN

	SET NOCOUNT ON

	SELECT cas.[CopyActivitySinkName]
      ,cadsfs.[CopyActivityDataFileSystemName]
      ,cadsfs.[CopyActivityDataFileSystemFolderPath]
      ,cadsfs.[CopyActivityDataFileSystemFileName]
	  ,cadstn.[CopyActivityDataTypeName]
	  ,cadsadls.[CopyActivityDataADLSName]
	  --,CASE 
		 -- WHEN @ADLSGrain = 'Month'
			--THEN cadsadls.[CopyActivityDataADLSFolderPath] + '/' + substring(convert(varchar, getdate(), 111),1,7)
		 -- WHEN @ADLSGrain = 'Day'
			--THEN cadsadls.[CopyActivityDataADLSFolderPath] + '/' + convert(varchar, getdate(), 111)
		 -- ELSE 
	 ,cadsadls.[CopyActivityDataADLSFolderPath] AS CopyActivityDataADLSFolderPath
--      ,concat(convert(varchar(10),getdate(),112),'_',cadsadls.[CopyActivityDataADLSFileName]) as [CopyActivityDataADLSFileName]
	  ,cadsadls.[CopyActivityDataADLSFileName] as [CopyActivityDataADLSFileName]
	  ,cadsadls.[CopyActivityDataADLSContainerName] as CopyActivityDataADLSContainerName
	  ,cadsfs.[CopyActivityDataFileSystemContainerName] as CopyActivityDataFileSystemContainerName
      FROM CopyActivitySink cas
  INNER JOIN CopyActivityDataFileSystem cadsfs ON
  cadsfs.CopyActivityDataFileSystemKey = cas.CopyActivitySinkDataKey
  INNER JOIN [dbo].[CopyActivityDataType] cadstn ON
  cadstn.[CopyActivityDataTypeKey] = cas.CopyActivitySinkDataTypeKey
  INNER JOIN [dbo].[CopyActivityDataADLS] cadsadls ON
  cadsadls.CopyActivityDataADLSKey= cas.CopyActivitySinkDataTargetKey
  INNER JOIN [dbo].[CopyActivityDataType] cadstnt ON
  cadstnt.[CopyActivityDataTypeKey] = cas.CopyActivitySinkDataTargetTypeKey
  where cadstn.CopyActivityDataTypeName = 'File System'
  and cadstnt.CopyActivityDataTypeName = 'Azure Data Lake Store'
  and cas.CopyActivitySinkName = @CopyActivitySinkName

END
GO
