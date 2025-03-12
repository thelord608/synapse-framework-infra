#Parameters needed by the script.
Param(     
	[Parameter(Mandatory=$True)]
    [string] $AutomationAccountName,
    [Parameter(Mandatory=$True)]
    [string] $FilePath,
    [Parameter(Mandatory=$True)]
    [string] $ResourceGroupName
)

Function ImportRunBook($automationAccountName, $runbookName, $scriptPath, $resourceGroupName) {
	Import-AzAutomationRunbook -Name $runbookName -Path $scriptPath -ResourceGroupName $resourceGroupName -AutomationAccountName $automationAccountName -Type PowerShellWorkflow -Force
	Write-Host "Completed importing $runbookName ."
}

Function PublishRunBook($automationAccountName, $runbookName, $resourceGroupName) {
	Publish-AzAutomationRunbook -AutomationAccountName $automationAccountName -Name $runbookName -ResourceGroupName $resourceGroupName
	Write-Host "Completed publishing $runbookName ."
}

Function ScheduleRunBook($automationAccountName, $runbookName, $resourceGroupName, $scheduleName) {
	try
	{
		$existingSchedule = Get-AzAutomationSchedule -AutomationAccountName $automationAccountName -Name $scheduleName -ResourceGroupName $resourceGroupName -ErrorAction Stop
		Write-Host "Schedule $scheduleName already exists."
	}
	catch [Microsoft.Azure.Commands.Automation.Common.ResourceNotFoundException]
	{
		$startTime = (Get-Date).AddMinutes(7)
		New-AzAutomationSchedule -AutomationAccountName $automationAccountName -Name $scheduleName -StartTime $startTime -ResourceGroupName $resourceGroupName -HourInterval 3
		Write-Host "Completed adding schedule $scheduleName ."
		Register-AzAutomationScheduledRunbook –AutomationAccountName $automationAccountName –Name $runbookName –ScheduleName $scheduleName -ResourceGroupName $resourceGroupName
		Write-Host "Completed linking runbook $runbookName to schedule $scheduleName ."
	}		
}

$runbookName = "StopAnalysisService"
$scriptPath = $FilePath + "\ARM\AzureAutomationAccount\StopAnalysisService.ps1"
ImportRunBook $AutomationAccountName $runbookName $scriptPath $ResourceGroupName
$runbookName = "StopSQLPool"
$scriptPath = $FilePath + "\ARM\AzureAutomationAccount\StopSQLPool.ps1"
ImportRunBook $AutomationAccountName $runbookName $scriptPath $ResourceGroupName
PublishRunBook $AutomationAccountName $runbookName $ResourceGroupName
$scheduleName = "StopSQLPoolSchedule"
ScheduleRunBook $AutomationAccountName $runbookName $ResourceGroupName $scheduleName