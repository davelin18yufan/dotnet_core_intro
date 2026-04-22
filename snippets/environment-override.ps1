$env:ASPNETCORE_ENVIRONMENT = "Production"
$env:ConnectionStrings__MainDb = `
  "Server=sql-prod;Database=OrdersDb;User Id=svc_api;Password=***"

$env:Mail__Host = "smtp-prod.internal.local"
dotnet Company.Project.Api.dll
