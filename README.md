# eGenesis

.NET project scaffold template. Pull, rename, code.

## Usage

```powershell
cd <your-project-folder>
npx degit ethavais/egenesis
```

Then open in VS Code and **Ctrl+H → Replace All** (Match Case on):

```
Find:    {{ProjectName}}
Replace: YourProjectName   # PascalCase, e.g. api-hub → ApiHub
```

## Structure

```
├── .vscode/
│   ├── settings.json      # Hides devops/, points to .slnx
│   ├── agents.json
│   ├── launch.json
│   └── tasks.json
├── devops/                # Hidden from VS Code Explorer
│   ├── docker/
│   ├── k8s/
│   ├── scripts/
│   │   ├── build.ps1
│   │   └── cleanup-usings.ps1
│   └── pipelines/
│       ├── azure-pipelines.yml
│       └── template-build.yml
├── src/                   # Your code goes here
├── .editorconfig
├── .gitignore
└── Directory.Build.props
```

## Placeholders

All `{{ProjectName}}` occurrences across these files:

| File | Where |
|---|---|
| `.vscode/settings.json` | `dotnet.defaultSolution` |
| `.vscode/launch.json` | `program`, `cwd` |
| `.vscode/tasks.json` | `.csproj` paths |
| `.vscode/agents.json` | `name`, `instructions` |
| `devops/scripts/build.ps1` | project path, `AssemblyName` |
| `devops/scripts/cleanup-usings.ps1` | `.slnx` filename |
| `devops/pipelines/azure-pipelines.yml` | `projectName` variable |

## After renaming

```powershell
dotnet new sln -n ApiHub --format slnx
dotnet new webapi -n ApiHub.App -o src/ApiHub.App
dotnet new xunit  -n ApiHub.Tests -o src/ApiHub.Tests
dotnet sln add src/ApiHub.App src/ApiHub.Tests
git init && git add . && git commit -m "chore: init"
```
