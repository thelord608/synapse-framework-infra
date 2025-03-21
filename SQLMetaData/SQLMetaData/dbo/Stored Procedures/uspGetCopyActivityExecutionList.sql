/****** Object:  StoredProcedure [dbo].[uspGetCopyActivityExecutionList] ******/
CREATE PROCEDURE [dbo].[uspGetCopyActivityExecutionList] 
(
	@CopyActivityExecutionGroupName		varchar(100)
	)
AS
BEGIN

	SET NOCOUNT ON

	SELECT	c.ContainerName,
			p.CopyActivitySinkName
			,cap.CopyActivityDataADLSFolderPath
			,cap.CopyActivityDataADLSFileName
	FROM	CopyActivityExecutionPlan pep
			INNER JOiN Container c on pep.ContainerKey = c.ContainerKey
			INNER JOIN CopyActivitySink p ON
				p.[CopyActivitySinkKey] = pep.[CopyActivitySinkKey]
            INNER JOIN CopyActivityExecutionGroup peg ON
				pep.CopyActivityExecutionGroupKey = peg.CopyActivityExecutionGroupKey
			INNER JOIN CopyActivityDataADLS cap ON
				p.CopyActivitySinkName = cap.CopyActivityDataADLSName
	
	WHERE 
			peg.CopyActivityExecutionGroupName = @CopyActivityExecutionGroupName AND 
			peg.IsActive = 1 AND
			pep.IsRestart = 1 AND
		    pep.IsActive = 1
	
	ORDER BY 
			pep.CopyActivityOrder

END
GO
