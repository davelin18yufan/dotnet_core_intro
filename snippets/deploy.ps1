param(
    [string]$ArtifactPath = "D:\\deploy\\orders-api",
    [string]$ServiceName = "OrdersApi"
)

$env:ASPNETCORE_ENVIRONMENT = "Production"
$env:ConnectionStrings__MainDb = "Server=sql-prod;Database=OrdersDb;User Id=svc_api;Password=***"

dotnet "$ArtifactPath\\Company.Project.Api.dll" --apply-migrations
Restart-Service -Name $ServiceName
