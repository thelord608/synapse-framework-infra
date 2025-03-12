#Parameters needed by the script.
Param(     
    [Parameter(Mandatory=$True)]
    [string] $FilePath,
    [Parameter(Mandatory=$True)]
    [string] $ResourceGroupName,
    [Parameter(Mandatory=$True)]
    [string] $AnalysisServicesName,
    [Parameter(Mandatory=$True)]
    [string] $SynapseWorkspaceName,
	[Parameter(Mandatory=$True)]
    [string] $SqlPoolName
)

$fullPath = $FilePath + "\infra\AzureAutomationAccount\*.ps1"
$filesToUpdate = Get-ChildItem -Path $fullPath -Recurse -Force
Write-Host "Retrieved powershell scripts from source directory."
foreach ($file in $filesToUpdate)
{
    (Get-Content -Path $file.PSPath) | Foreach-Object -Process { $_ -replace "<ResourceGroupName_Param>", $ResourceGroupName } | Set-Content -Path $file.PSPath
    (Get-Content -Path $file.PSPath) | Foreach-Object -Process { $_ -replace "<AnalysisServicesName_Param>", $AnalysisServicesName } | Set-Content -Path $file.PSPath
    (Get-Content -Path $file.PSPath) | Foreach-Object -Process { $_ -replace "<SynapseWorkspaceName_Param>", $SynapseWorkspaceName } | Set-Content -Path $file.PSPath
	(Get-Content -Path $file.PSPath) | Foreach-Object -Process { $_ -replace "<SqlPoolName_Param>", $SqlPoolName } | Set-Content -Path $file.PSPath
}