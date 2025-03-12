/*********************************************************************************************************************
	File: 	SpreadSheet.data.sql

	Desc: 	Data hydration script.		
**********************************************************************************************************************/
MERGE dbo.NotebooksExcelSpreadSheets AS t
  USING (
  VALUES 
(1,'NotebookParameters_AutoFill_Framework','Ingest',1),
(2,'NotebookParameters_AutoFill_Framework','Enrich',1),
(3,'NotebookParameters_AutoFill_Framework','Sanction',1)
	
		) as s
		(
			 ID
			,ExcelName
			,ExcelSpreadSheetName
			,IsActive
		)
ON ( t.ID = s.ID )
WHEN MATCHED THEN 
	UPDATE SET   ExcelName = s.ExcelName
				,ExcelSpreadSheetName = s.ExcelSpreadSheetName
				,IsActive = s.IsActive
WHEN NOT MATCHED BY TARGET THEN
    INSERT(
			 ID
			,ExcelName
			,ExcelSpreadSheetName
			,IsActive
		  )	
    VALUES(
			 s.ID
			,s.ExcelName
			,s.ExcelSpreadSheetName
			,s.IsActive
		  );
GO
