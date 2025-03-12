$ResourceGroupName='<ResourceGroupName_Param>'
$AnalysisServerName ='<AnalysisServicesName_Param>' 

try
{

    Write-Output "Connecting to Azure"
    $ConnectionName = 'AzureRunAsConnection'
    $ServicePrincipalConnection = Get-AutomationConnection -Name $ConnectionName      


    $null = Connect-AzAccount `
            -ServicePrincipal `
            -TenantId $ServicePrincipalConnection.TenantId `
            -ApplicationId $ServicePrincipalConnection.ApplicationId `
            -CertificateThumbprint $ServicePrincipalConnection.CertificateThumbprint

    Write-Output "Connected "
    Write-Output "Connecting to analysis service to get status "
    

   $asSrv=Get-AzAnalysisServicesServer -ResourceGroupName $ResourceGroupName -Name $AnalysisServerName
   If ($asSrv.State -eq "Paused")
   {
       Write-Output "Server is not running "
   }
   else
   {
       Write-Output "Server is  running, ..  stopping the service"
       Suspend-AzAnalysisServicesServer -ResourceGroupName $ResourceGroupName -Name $AnalysisServerName
   }
    
}
catch 
{

    
    Write-output -Message $_.Exception.Message

}