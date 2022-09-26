# Set variables for your server and database
$resourceGroupName = "demoname"
$location = "eastus"
$adminLogin = "myadminuser"
$password = "myFakePass"
$serverName = "demoname"
$databaseName = "DurableDB"

# The ip address range that you want to allow to access your server
$startIp = "0.0.0.0"
$endIp = "0.0.0.0"

echo "Resource group name is $resourceGroupName"
echo "Server name is $serverName"

# Create an Azure resource group for your database
# az group create --name $resourceGroupName --location $location

# Create a SQL server and configure admin credentials
echo "Creating a SQL server and configuring admin credentials..."
az sql server create --name $serverName --resource-group $resourceGroupName --location $location --admin-user $adminlogin --admin-password $password

# Configure client IP address restrictions for the SQL server
echo "Configuring server firewall rules for SQL server..."
az sql server firewall-rule create --resource-group $resourceGroupName --server $serverName -n AllowYourIp --start-ip-address $startip --end-ip-address $endip

# Finally, create the database itself
echo "Creating the SQL database..."
az sql db create --resource-group $resourceGroupName --server $serverName --name $databaseName --collation Latin1_General_100_BIN2_UTF8