/****** Object:  Table [dbo].[ADLSPaths] ******/
CREATE TABLE [dbo].[ADLSPaths] (
    FileName varchar(255),
    FilePath varchar(512),
    CopyActivityExecutionGroupName varchar(255),
    ContainerName varchar(255),
    CopyActivityOrder int,
    IsProcessed int,
    CopyActivityDataFileSystemContainerName VARCHAR(255)
)