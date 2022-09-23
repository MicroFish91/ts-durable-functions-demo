# settings------
# In case you are running into issues with Windows execution policies, you can unblock the *.ps1 files via:
# Unblock-File -Path ./*.ps1

Write-Host "Using parameters specified in settings.ps1."

# always edit this parameter before running the scripts
$name = "ts-durable-netherite-script"

# REVIEW THESE PARAMETERS BEFORE RUNNING THE SCRIPT
$location = "westeurope"
$storageSku = "Standard_LRS"

# optionally, customize the following parameters
# to use different names for resource group, namespace, function app, storage account, and plan
$groupName = $name
$nameSpaceName = $name
$functionAppName = $name
$storageName = "tsdurablescrstor"
$planName = $name

if (($name -eq "globally-unique-lowercase-alphanumeric-name-with-no-dashes")) {
	throw "You must edit the 'name' parameter in settings.ps1 before using this script"
}

# settings ------

# look up the two connection strings and assign them to the respective environment variables
$Env:AzureWebJobsStorage = (az storage account show-connection-string --name $storageName --resource-group $groupName | ConvertFrom-Json).connectionString
$Env:EventHubsConnection = (az eventhubs namespace authorization-rule keys list --resource-group $groupName --namespace-name $namespaceName --name RootManageSharedAccessKey | ConvertFrom-Json).primaryConnectionString
