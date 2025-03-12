/*********************************************************************************************************************
	File: 	System.data.sql

	Desc: 	Data hydration script.
**********************************************************************************************************************/

SET IDENTITY_INSERT dbo.System ON;

MERGE dbo.System AS t
  USING (
  VALUES 

		 (1,'SynapseInnovationFramework',1,NULL,NULL,GetDate(),NULL)
		 ) as s
		(
			 SystemKey
			,SystemName
			,SystemTypeKey
			,SystemDate
			,SystemCreatedBy
			,CreatedDate
			,ModifiedDate
		)
ON ( t.SystemKey = s.SystemKey )
WHEN MATCHED THEN 
	UPDATE SET   SystemName = s.SystemName
				,SystemTypeKey = s.SystemTypekey
				,SystemDate = s.SystemDate
				,SystemCreatedBy = s.SystemCreatedBy
				,CreatedDate = s.CreatedDate
				,ModifiedDate = s.ModifiedDate
WHEN NOT MATCHED BY TARGET THEN
    INSERT(
			 SystemKey
			,SystemName
			,SystemTypeKey
			,SystemDate
			,SystemCreatedBy
			,CreatedDate
			,ModifiedDate
		  )	
    VALUES(
			 s.SystemKey
			,s.SystemName
			,s.SystemTypeKey
			,s.SystemDate
			,s.SystemCreatedBy
			,s.CreatedDate
			,s.ModifiedDate
		  );
GO

SET IDENTITY_INSERT dbo.System OFF;