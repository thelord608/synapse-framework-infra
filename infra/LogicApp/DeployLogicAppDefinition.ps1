#Parameters needed by the script.
Param(     
    [Parameter(Mandatory=$True)]
    [string] $ResourceGroupName,
    [Parameter(Mandatory=$True)]
    [string] $LogicAppName,
    [Parameter(Mandatory=$True)]
    [string] $FilePath,
	[Parameter(Mandatory=$True)]
    [string] $NotificationWebhookURI
)

Function Set-LogicAppDefinition($definition, $definitionParameters, $logicAppResource) {    
    Write-Host "Updating the logic app definition"
    $logicAppResource.Properties.parameters = $definitionParameters;
    $logicAppResource.Properties.definition = $definition.definition;
    $logicAppResource | Set-AzResource -Force;
}

Function Get-LogicAppResource($resourceGroupName, $logicAppName) {
    return Get-AzResource -ResourceGroupName $resourceGroupName -ResourceName $logicAppName -ResourceType Microsoft.Logic/workflows -ErrorAction SilentlyContinue;    
}

Function Start-LogicAppDefinitionDeployment($resourceGroupName, $logicAppName, $filePath, $notificationWebhookURI) {
	Write-Host "Checking whether the logic app exists: '$LogicAppName'"
	$logicAppResource = Get-LogicAppResource -resourceGroupName $resourceGroupName -logicAppName $logicAppName;    
    
	if ($null -eq $logicAppResource) {
		Write-Error "Logic app '$LogicAppName' is not deployed."
	}
	else
	{
		$logicAppDefinitionPath = $filePath + "\ARM\LogicApp\LogicAppDefinition.json"
		$definitionContent = (Get-Content $logicAppDefinitionPath -Encoding UTF8 -Raw) 
		$definition = ConvertFrom-Json -InputObject $definitionContent;
		$logicAppDefinitionParametersPath = $filePath + "\ARM\LogicApp\LogicAppDefinition.parameters.json"
		$definitionParametersContent = (Get-Content $logicAppDefinitionParametersPath -Encoding UTF8 -Raw) 
		$definitionParameters = ConvertFrom-Json -InputObject $definitionParametersContent;
		$definitionParameters.NotificationWebhookURI.value = $notificationWebhookURI;
		Set-LogicAppDefinition -definition $definition -definitionParameters $definitionParameters -logicAppResource $logicAppResource

		$callBackUrlInstance = Get-AzLogicAppTriggerCallbackUrl -ResourceGroupName $resourceGroupName -Name $logicAppName -TriggerName "manual"
		$callBackUrl = $callBackUrlInstance.value;

		Write-Host "##vso[task.setvariable variable=LogicAppTriggerCallBackURI;]$callBackUrl"
	}
}

Start-LogicAppDefinitionDeployment $ResourceGroupName $LogicAppName $FilePath $NotificationWebhookURI