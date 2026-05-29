# Script to remove unused usings in the project
# Uses 'dotnet format' which respects the rules in .editorconfig

$ErrorActionPreference = "Stop"
$projectDir = Split-Path -Parent $MyInvocation.MyCommand.Path | Split-Path -Parent | Split-Path -Parent

$slnFiles = Get-ChildItem -Path $projectDir -Filter "*.slnx" -File
if ($slnFiles.Count -eq 0) {
    throw "No .slnx solution file found in: $projectDir. Run 'dotnet new sln' first."
}
$sln = $slnFiles[0].FullName

Write-Host ">>> Scanning and removing unused usings (workspace: $sln)..." -ForegroundColor Cyan

dotnet format style $sln --severity warn

if ($LASTEXITCODE -eq 0) {
    Write-Host ">>> Completed! Unused usings have been removed." -ForegroundColor Green
}
else {
    Write-Host ">>> An error occurred during formatting." -ForegroundColor Red
    exit $LASTEXITCODE
}
