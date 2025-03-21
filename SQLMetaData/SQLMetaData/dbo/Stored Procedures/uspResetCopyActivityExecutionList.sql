/****** Object:  StoredProcedure [dbo].[uspResetCopyActivityExecutionList] ******/
CREATE PROCEDURE [dbo].[uspResetCopyActivityExecutionList] 
(
	@SystemName		varchar(100) -- copyActivityExecutionGroupname
	)
AS
BEGIN

	SET NOCOUNT ON

	UPDATE CopyActivityExecutionPlan
	SET IsRestart = 1
	FROM	CopyActivityExecutionPlan pep
			INNER JOIN CopyActivitySink p ON
				p.[CopyActivitySinkKey] = pep.[CopyActivitySinkKey]
            INNER JOIN CopyActivityExecutionGroup peg ON
				pep.CopyActivityExecutionGroupKey = peg.CopyActivityExecutionGroupKey
			INNER JOIN Container s on pep.ContainerKey=s.ContainerKey
	WHERE 
			peg.CopyActivityExecutionGroupName = @SystemName AND
			peg.IsActive = 1 AND
			pep.IsRestart = 0

END
GO
