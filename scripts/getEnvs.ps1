#!/usr/bin/pwsh

# read the parameters
$storageName="tsdurablenetheritedemo"
$groupName="tsdurablenetheritedemo"
$namespaceName="tsdurablenetheritehub"

$separator="---------------"

# look up the two connection strings and assign them to the respective environment variables
$Env:AzureWebJobsStorage = (az storage account show-connection-string --name $storageName --resource-group $groupName | ConvertFrom-Json).connectionString
$Env:EventHubsConnection = (az eventhubs namespace authorization-rule keys list --resource-group $groupName --namespace-name $namespaceName --name RootManageSharedAccessKey | ConvertFrom-Json).primaryConnectionString

$Env:AzureWebJobsStorage
$separator
$Env:EventHubsConnection