dotnet ef migrations add InitOrderModule `
  --project src/Company.Project.Infrastructure `
  --startup-project src/Company.Project.Api

dotnet ef database update `
  --project src/Company.Project.Infrastructure `
  --startup-project src/Company.Project.Api
