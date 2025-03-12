/****** Object:  Table [dbo].[temp_ADLSPaths] ******/
CREATE TABLE [dbo].[temp_ADLSPaths] (
    FileName varchar(255),
    FilePath varchar(512),
    CopyActivityExecutionGroupName varchar(255),
    ContainerName varchar(255),
    CopyActivityOrder int,
    IsProcessed int,
    CopyActivityDataFileSystemContainerName VARCHAR(255)
)