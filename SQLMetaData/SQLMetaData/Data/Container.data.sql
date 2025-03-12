/*********************************************************************************************************************
	File: 	Container.data.sql

	Desc: 	Data hydration script.
**********************************************************************************************************************/

SET IDENTITY_INSERT dbo.Container ON;

MERGE dbo.Container AS t
  USING (
  VALUES 

		 (1,'sip',1,1,NULL,NULL,GetDate(),NULL)

		 ) as s
		(
			 ContainerKey
			,ContainerName
			,SystemKey
			,ContainerTypeKey
			,ContainerDate
			,ContainerCreatedBy
			,CreatedDate
			,ModifiedDate
		)
ON ( t.ContainerKey = s.ContainerKey )
WHEN MATCHED THEN 
	UPDATE SET   ContainerName = s.ContainerName
				,ContainerTypeKey = s.ContainerTypekey
				,SystemKey = s.Systemkey
				,ContainerDate = s.ContainerDate
				,ContainerCreatedBy = s.ContainerCreatedBy
				,CreatedDate = s.CreatedDate
				,ModifiedDate = s.ModifiedDate
WHEN NOT MATCHED BY TARGET THEN
    INSERT(
			 ContainerKey
			,ContainerName
			,SystemKey
			,ContainerTypeKey
			,ContainerDate
			,ContainerCreatedBy
			,CreatedDate
			,ModifiedDate
		  )	
    VALUES(
			 s.ContainerKey
			,s.ContainerName
			,s.SystemKey
			,s.ContainerTypeKey
			,s.ContainerDate
			,s.ContainerCreatedBy
			,s.CreatedDate
			,s.ModifiedDate
		  );
GO

SET IDENTITY_INSERT dbo.Container OFF;
