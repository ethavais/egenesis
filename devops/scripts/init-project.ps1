<#
.SYNOPSIS
    Initialize project by replacing {{ProjectEgenesisName}} placeholder across all config files.

.DESCRIPTION
    Run this once after cloning/pulling the template.
    Replaces {{ProjectEgenesisName}} in all .vscode and devops config files with the given name.

.PARAMETER ProjectName
    PascalCase project name, e.g. "ApiHub"

.EXAMPLE
    .\devops\scripts\init-project.ps1 -ProjectName ApiHub
#>

param(
    [Parameter(Mandatory = $true)]
    [ValidatePattern('^[A-Z][A-Za-z0-9]+$')]
    [string]$ProjectName
)

$placeholder = '{{ProjectEgenesisName}}'
$root = Resolve-Path "$PSScriptRoot/../.."

$targets = @(
    "$root/.vscode/settings.json",
    "$root/.vscode/launch.json",
    "$root/.vscode/tasks.json",
    "$root/.vscode/agents.json",
    "$root/devops/scripts/build.ps1",
    "$root/devops/scripts/cleanup-usings.ps1",
    "$root/devops/pipelines/azure-pipelines.yml"
)

$replaced = 0

foreach ($file in $targets) {
    if (-not (Test-Path $file)) {
        Write-Warning "  [skip] Not found: $file"
        continue
    }

    $content = Get-Content $file -Raw -Encoding UTF8

    if ($content -match [regex]::Escape($placeholder)) {
        $newContent = $content -replace [regex]::Escape($placeholder), $ProjectName
        Set-Content $file -Value $newContent -Encoding UTF8 -NoNewline
        Write-Host "  [ok]   $((Resolve-Path $file).Path)"
        $replaced++
    }
    else {
        Write-Host "  [skip] No placeholder: $((Resolve-Path $file).Path)"
    }
}

Write-Host ""
Write-Host "Done. Replaced '$placeholder' → '$ProjectName' in $replaced file(s)." -ForegroundColor Green
Write-Host ""
Write-Host "Next steps:"
Write-Host "  dotnet new sln -n $ProjectName --format slnx"
Write-Host "  dotnet new webapi -n $ProjectName.App -o src/$ProjectName.App"
Write-Host "  dotnet sln add src/$ProjectName.App"
Write-Host "  git init && git add . && git commit -m `"chore: init`""
