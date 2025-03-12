
# Parameters
$ResourceGroupName='<ResourceGroupName_Param>'
$WorkspaceName='<SynapseWorkspaceName_Param>'
$SynapseSqlPoolName='<SqlPoolName_Param>'
$SQL_Server_Name ='<SynapseWorkspaceName_Param>.sql.azuresynapse.net'


# Get credentials from automation credentials 

Write-Output "Get sql credentials from automation"
$SQLServerCred = Get-AutomationPSCredential -Name "sqlpoollogin"


# Connecting to Azure

Write-Output "Connecting to Azure to check active queries "
$ConnectionName = 'AzureRunAsConnection'
$ServicePrincipalConnection = Get-AutomationConnection -Name $ConnectionName
    

# Check if there are active queries 

Write-Output "Check if there are active queries " 
$Query = "SELECT * FROM sys.dm_pdw_exec_requests Where status='Running' "
$dsInstanceList=invoke-sqlcmd2 -ServerInstance "$SQL_Server_Name" -Database "$SynapseSqlPoolName" -Credential $SQLServerCred -Query "$Query" -As 'DataTable'
$querycounter =0
foreach($Instance in $dsInstanceList.rows)
{
    $querycounter = $querycounter + 1
   

}




if ($querycounter -eq 1 )
{



    Write-Output "No active queries ,connecting to sqlpool to stop "

    $null= Connect-AzAccount `
        -ServicePrincipal `
        -TenantId $ServicePrincipalConnection.TenantId `
        -ApplicationId $ServicePrincipalConnection.ApplicationId `
        -CertificateThumbprint $ServicePrincipalConnection.CertificateThumbprint
  


    Write-Output "Stopping ...   "
    Suspend-AzSynapseSqlPool -WorkspaceName $WorkspaceName -Name $SynapseSqlPoolName
    Write-Output "stopped  the server  "
    
}
else 
{

Write-Output "There are active queries"
Write-Output $querycounter
Write-Output "Quit without stopping "


}

