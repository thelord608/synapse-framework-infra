/*********************************************************************************************************************
	File: 	ContainerParameter.data.sql

	Desc: 	Data hydration script.
**********************************************************************************************************************/

SET IDENTITY_INSERT dbo.ContainerParameter ON;

MERGE dbo.ContainerParameter AS t
  USING (
  VALUES 
  		 (1,'ADLSBasePath','idw',1,GetDate(),NULL),
		 (2,'LoadDate','1/1/2014',1,GetDate(),NULL),
		 (3,'LoadFrequency','Daily',1,GetDate(),NULL)
--         (2,'am-da-dev-adf-01_rundate','9999/99/99',GetDate(),NULL)
		
		) as s
		(
			 ContainerParameterKey
			,ContainerParameterName
			,ContainerParameterValue
			,ContainerKey
			,CreatedDate
			,ModifiedDate
		)
ON ( t.ContainerParameterKey = s.ContainerParameterKey )
WHEN MATCHED THEN 
	UPDATE SET   ContainerParameterName = s.ContainerParameterName
			    ,ContainerParameterValue = s.ContainerParameterValue
				,ContainerKey = s.ContainerKey
				,CreatedDate = s.CreatedDate
				,ModifiedDate = s.ModifiedDate
WHEN NOT MATCHED BY TARGET THEN
    INSERT(
			 ContainerParameterKey
			,ContainerParameterName
			,ContainerParameterValue
			,ContainerKey
			,CreatedDate
			,ModifiedDate
		  )	
    VALUES(
			 s.ContainerParameterKey
			,s.ContainerParameterName
			,s.ContainerParameterValue
			,s.ContainerKey
			,s.CreatedDate
			,s.ModifiedDate
		  );
GO

SET IDENTITY_INSERT dbo.ContainerParameter OFF;