#Parameters needed by the script.
Param(     
    [Parameter(Mandatory=$True)]
    [string] $KeyVaultName,
    [Parameter(Mandatory=$True)]
    [string] $MetadataSqlServerName,
	[Parameter(Mandatory=$True)]
    [string] $MetadataSqlDatabaseName,
    [Parameter(Mandatory=$True)]
    [string] $MetadataAdministratorLogin,
    [Parameter(Mandatory=$True)]
    [string] $MetadataAdministratorLoginPassword,
	[Parameter(Mandatory=$True)]
    [string] $SynapseWorkspaceName,
    [Parameter(Mandatory=$True)]
    [string] $SqlPoolName,
    [Parameter(Mandatory=$True)]
    [string] $SynapseSqlAdministratorLogin,
    [Parameter(Mandatory=$True)]
    [string] $SynapseSqlAdministratorLoginPassword,
	[Parameter(Mandatory=$True)]
    [string] $MasterKeyPassword,
	[Parameter(Mandatory=$True)]
    [string] $LogicAppTriggerCallBackURI,
	[Parameter(Mandatory=$True)]
    [string] $SubscriptionId,
	[Parameter(Mandatory=$True)]
    [string] $ResourceGroupName
)

#Function main method
Function Provision-KeyVault-Secrets {

    $context = Get-AzContext;

    $objectId = $Context.Account.Id;

    Set-AzKeyVaultAccessPolicy -VaultName $KeyVaultName -ServicePrincipalName $objectId -PermissionsToSecrets Get,Set;

    Create-KeyVaultSecret $MetadataSqlServerName $KeyVaultName "MetadataSqlServerName";

    Create-KeyVaultSecret $MetadataAdministratorLogin $KeyVaultName "MetadataAdministratorLogin";

    Create-KeyVaultSecret $MetadataAdministratorLoginPassword $KeyVaultName "MetadataAdministratorLoginPassword";

    Create-KeyVaultSecret $SqlPoolName $KeyVaultName "SqlPoolServerName";

    Create-KeyVaultSecret $SynapseSqlAdministratorLogin $KeyVaultName "SynapseSqlAdministratorLogin";

    Create-KeyVaultSecret $SynapseSqlAdministratorLoginPassword $KeyVaultName "SynapseSqlAdministratorLoginPassword";

	Create-KeyVaultSecret $MasterKeyPassword $KeyVaultName "MasterKeyPassword";

	$metadataSQLConnectionString = "Server=tcp:" + $MetadataSqlServerName + ".database.windows.net,1433;Initial Catalog=" + $MetadataSqlDatabaseName + ";User ID=" + $MetadataAdministratorLogin + ";Password=" + $MetadataAdministratorLoginPassword + ";Integrated Security=False;Encrypt=True;Connection Timeout=30;"

	Create-KeyVaultSecret $metadataSQLConnectionString $KeyVaultName "MetadataSQLConnectionString";

	$sQLPoolConnectionString = "Server=tcp:" + $SynapseWorkspaceName + ".sql.azuresynapse.net,1433;Initial Catalog=" + $SqlPoolName + ";User ID=" + $SynapseSqlAdministratorLogin + ";Password=" + $SynapseSqlAdministratorLoginPassword + ";Integrated Security=False;Encrypt=True;Connection Timeout=30;"

	Create-KeyVaultSecret $sQLPoolConnectionString $KeyVaultName "SQLPoolConnectionString";
	
	Create-KeyVaultSecret $LogicAppTriggerCallBackURI $KeyVaultName "LogicAppTriggerCallBackURI";

	$notificationMessageBody = "{`"DataFactoryName`":`"" + $SynapseWorkspaceName + "`",`"PipelineName`":`"<Pipeline>`",`"Subject`":`"<Subject>`",`"ErrorMessage`":`"<ErrorMessage>`",`"MonitorURL`":`"https://web.azuresynapse.net/en-us/monitoring/pipelineruns/<RunId>?workspace=%2Fsubscriptions%2F" + $SubscriptionId + "%2FresourceGroups%2F" + $ResourceGroupName + "%2Fproviders%2FMicrosoft.Synapse%2Fworkspaces%2F" + $SynapseWorkspaceName + "`"}";

	Create-KeyVaultSecret $notificationMessageBody $KeyVaultName "NotificationMessageBody";
}

# Function to add key vault secret.
Function Create-KeyVaultSecret($valueToStore, $vaultName, $secretName) {     
    $secretvalue = ConvertTo-SecureString $valueToStore -AsPlainText -Force  
    $secret = Set-AzKeyVaultSecret -VaultName $vaultName -Name $secretName -SecretValue $secretvalue
    Write-Host "Added Key Vault secret [$secretName]."
    return $secret
}

Provision-KeyVault-Secrets;