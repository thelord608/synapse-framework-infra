/*********************************************************************************************************************
	File: 	ContainerActivityType.data.sql

	Desc: 	Data hydration script.
**********************************************************************************************************************/

SET IDENTITY_INSERT dbo.ContainerActivityType ON;

MERGE dbo.ContainerActivityType AS t
  USING (
  VALUES 
		 (1,'CopyActivity',GetDate(),NULL)
		,(2,'PipeLine',GetDate(),NULL)
		,(3,'NoteBook',GetDate(),NULL)
		,(4,'StoredProcedure',GetDate(),NULL)
		,(5,'DataFlow',GetDate(),NULL)
		
		) as s
		(
			 ContainerActivityTypeKey
			,ContainerActivityTypeName
			,CreatedDate
			,ModifiedDate
		)
ON ( t.ContainerActivityTypeKey = s.ContainerActivityTypeKey )
WHEN MATCHED THEN 
	UPDATE SET   ContainerActivityTypeName = s.ContainerActivityTypeName
				,CreatedDate = s.CreatedDate
				,ModifiedDate = s.ModifiedDate
WHEN NOT MATCHED BY TARGET THEN
    INSERT(
			 ContainerActivityTypeKey
			,ContainerActivityTypeName
			,CreatedDate
			,ModifiedDate
		  )	
    VALUES(
			 s.ContainerActivityTypeKey
			,s.ContainerActivityTypeName
			,s.CreatedDate
			,s.ModifiedDate
		  );
GO

SET IDENTITY_INSERT dbo.ContainerActivityType OFF;


