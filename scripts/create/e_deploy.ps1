$functionAppName="ts-durable-netherite-script"

npm install

npm run build

npm prune --production

func extensions install

Write-Host "Publishing code to function app"
func azure functionapp publish $functionAppName --typescript

Pop-Location