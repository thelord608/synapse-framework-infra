/*********************************************************************************************************************
	File: 	Script.PostDeploymentScript.sql

	Desc: 	Post Deployment script.		
**********************************************************************************************************************/

-- Hydrate Metadata

:r ..\Data\DataSourceType.data.sql
:r ..\Data\DataSource.data.sql
 
:r ..\Data\System.data.sql
:r ..\Data\SystemActivityType.data.sql
:r ..\Data\SystemParameter.data.sql
:r ..\Data\CopyActivitySpreadSheetData.data.sql
 
:r ..\Data\CopyActivityDataType.data.sql
:r ..\Data\CopyActivityExecutionGroup.data.sql
 
:r ..\Data\Container.data.sql
:r ..\Data\ContainerType.data.sql
:r ..\Data\ContainerParameter.data.sql
:r ..\Data\ContainerActivityType.data.sql
:r ..\Data\NotebooksExcelSpreadSheets.data.sql