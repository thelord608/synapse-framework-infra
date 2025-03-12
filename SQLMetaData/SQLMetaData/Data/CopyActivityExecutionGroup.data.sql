/*********************************************************************************************************************
	File: 	CopyActivityExecutionGroup.data.sql

	Desc: 	Data hydration script.	
**********************************************************************************************************************/

SET IDENTITY_INSERT dbo.CopyActivityExecutionGroup ON;

MERGE dbo.CopyActivityExecutionGroup AS t
  USING (
  VALUES 
		(1,'SIP Copy Process',1,0,getdate(),NULL)
		
		) as s
		(
			 CopyActivityExecutionGroupKey
			,CopyActivityExecutionGroupName
			,IsActive
			,IsEmailEnabled
			,CreatedDate
			,ModifiedDate
		)
ON ( t.CopyActivityExecutionGroupKey = s.CopyActivityExecutionGroupKey )
WHEN MATCHED THEN 
	UPDATE SET   CopyActivityExecutionGroupName = s.CopyActivityExecutionGroupName
				,IsActive = s.IsActive
				,IsEmailEnabled = s.IsEmailEnabled
				,CreatedDate = s.CreatedDate
				,ModifiedDate = s.ModifiedDate
WHEN NOT MATCHED BY TARGET THEN
    INSERT(
			 CopyActivityExecutionGroupKey
			,CopyActivityExecutionGroupName
			,IsActive
			,IsEmailEnabled
			,CreatedDate
			,ModifiedDate
		  )	
    VALUES(
			 s.CopyActivityExecutionGroupKey
			,s.CopyActivityExecutionGroupName
			,s.IsActive
			,s.IsEmailEnabled
			,s.CreatedDate
			,s.ModifiedDate
		  );
GO

SET IDENTITY_INSERT dbo.CopyActivityExecutionGroup OFF;