#!/usr/bin/pwsh

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
 
if ((az group exists --name $groupName) -ne "true") {
	Write-Host "Creating Resource Group..."
	az group create --name $groupName --location $location
}
else {
	Write-Host "Resource Group already exists."
}

if ((az storage account check-name --name $storageName | ConvertFrom-Json).reason -ne "AlreadyExists") {
	Write-Host "Creating Storage Account..."
	az storage account create --name  $storageName --location $location --resource-group  $groupName --sku $storageSku --allow-blob-public-access false --https-only true --min-tls-version TLS1_2
}
else {
	Write-Host "Storage account already exists."
}
 
if ((az eventhubs namespace exists --name $namespaceName | ConvertFrom-Json).reason -ne "NameInUse") {
	Write-Host "Creating EventHubs Namespace..."
	az eventhubs namespace create --name $namespaceName --resource-group $groupName 
}
else {
	Write-Host "EventHubs Namespace already exists."
}