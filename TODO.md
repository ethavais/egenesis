# Welcome to your new eGenesis project! 🎉

You have successfully pulled the template. Now, let's get your project ready.

## Next Steps

**1. Initialize your project name**
Run the initialization script to automatically replace the `{{ProjectEgenesisName}}` placeholder across all configuration files:

```powershell
.\devops\scripts\init-project.ps1 -ProjectName YourProjectName
```
*(Note: `YourProjectName` must be in PascalCase, e.g., `ApiHub` or `PaymentService`)*

**2. Scaffold .NET projects**
```powershell
dotnet new sln -n YourProjectName --format slnx
dotnet new webapi -n YourProjectName.App -o src/YourProjectName.App
dotnet sln add src/YourProjectName.App
```

**3. Initial Commit**
```powershell
git init
git add .
git commit -m "chore: initial project scaffold"
```

## Done!
You can now delete this `TODO.md` file and start coding.
