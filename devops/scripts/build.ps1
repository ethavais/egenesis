# Build script for {{ProjectName}} application
# Builds release version and outputs to artifacts/release folder

$ErrorActionPreference = "Stop"
$projectDir = Split-Path -Parent $MyInvocation.MyCommand.Path | Split-Path -Parent | Split-Path -Parent
$projectFile = Join-Path $projectDir "src\{{ProjectName}}.App\{{ProjectName}}.App.csproj"
$outputDir = Join-Path $projectDir "artifacts\release"

# Ensure output directory exists
if (!(Test-Path $outputDir)) {
    New-Item -ItemType Directory -Path $outputDir | Out-Null
}

Write-Host ">>> Building {{ProjectName}} application..." -ForegroundColor Cyan

dotnet publish $projectFile `
    -c Release `
    -o $outputDir `
    -p:PublishSingleFile=true `
    -p:EnableCompressionInSingleFile=true `
    -p:AssemblyName={{ProjectName}} `
    -p:GenerateAssemblyInfo=true `
    -p:IncludeAllContentForSelfExtract=true `
    -p:RuntimeIdentifier=win-x64

if ($LASTEXITCODE -eq 0) {
    Write-Host ">>> Build completed successfully!" -ForegroundColor Green
    Write-Host ">>> Output: $outputDir" -ForegroundColor Yellow

    Get-ChildItem -Path $outputDir -Filter "*.exe" | ForEach-Object {
        Write-Host "    $($_.Name) ($([math]::Round($_.Length / 1KB, 2)) KB)" -ForegroundColor Gray
    }
} else {
    Write-Host ">>> Build failed!" -ForegroundColor Red
    exit $LASTEXITCODE
}
