# eGenesis

.NET project scaffold template. Pull, rename, code.

## Usage

```powershell
npx -y degit ethavais/egenesis
# OR
npx degit ethavais/egenesis

cd <your-project-folder>
```

Then run the init script (replaces `{{ProjectEgenesisName}}` in all config files automatically):

```powershell
.\devops\scripts\init-project.ps1 -ProjectName YourProjectName
```

> `YourProjectName` must be PascalCase, e.g. `ApiHub`

## Structure

```
├── .vscode/
│   ├── settings.json      # Hides devops/, points to .slnx
│   ├── mcp.json           # MCP server config for VS Code
│   ├── agents.json
│   ├── launch.json
│   └── tasks.json
├── .cursor/
│   └── mcp.json           # MCP server config for Cursor
├── .mcp.json              # MCP server config for Antigravity
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

## `.vscode/settings.json`

```json
{
    "dotnet.defaultSolution": "{{ProjectEgenesisName}}.slnx",
    "files.exclude": {
        "devops": true,
        "Directory.Build.props": true
    }
}
```

- `dotnet.defaultSolution` — points the .NET extension to the right `.slnx` file. Replace `{{ProjectEgenesisName}}` so IntelliSense and test discovery work without manual setup.
- `files.exclude` — hides `devops/` and `Directory.Build.props` from VS Code Explorer. Coders only see `src/`. DevOps files are still fully accessible from the terminal and CI.

## Placeholders

All `{{ProjectEgenesisName}}` occurrences are handled automatically by `devops/scripts/init-project.ps1`:

| File | Where |
|---|---|
| `.vscode/settings.json` | `dotnet.defaultSolution` |
| `.vscode/launch.json` | `program`, `cwd` |
| `.vscode/tasks.json` | `.csproj` paths |
| `.vscode/agents.json` | `name`, `instructions` |
| `devops/scripts/build.ps1` | project path, `AssemblyName` |
| `devops/scripts/cleanup-usings.ps1` | `.slnx` filename |
| `devops/pipelines/azure-pipelines.yml` | `projectName` variable |
