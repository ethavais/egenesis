# Script to remove unused usings in the project
# Uses 'dotnet format' which respects the rules in .editorconfig

$ErrorActionPreference = "Stop"
$projectDir = Split-Path -Parent $MyInvocation.MyCommand.Path | Split-Path -Parent | Split-Path -Parent
$sln = Join-Path $projectDir "{{ProjectName}}.slnx"

if (-not (Test-Path -LiteralPath $sln)) {
    throw "Solution not found: {{ProjectName}}.slnx — make sure you replaced {{ProjectName}} with the actual project name."
}

Write-Host ">>> Scanning and removing unused usings (workspace: $sln)..." -ForegroundColor Cyan

dotnet format style $sln --severity warn

if ($LASTEXITCODE -eq 0) {
    Write-Host ">>> Completed! Unused usings have been removed." -ForegroundColor Green
} else {
    Write-Host ">>> An error occurred during formatting." -ForegroundColor Red
    exit $LASTEXITCODE
}
