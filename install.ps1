# install.ps1 — Deploy Bob agents into ~/.kiro/ (user-scoped, all projects)
# Run from the repo root: .\install.ps1
# Tries symlinks first (auto-update on git pull). Falls back to copy if no admin.

$ErrorActionPreference = "Stop"
$RepoRoot = $PSScriptRoot
$KiroHome = Join-Path $env:USERPROFILE ".kiro"

# Ensure directories exist
foreach ($dir in @("$KiroHome", "$KiroHome\agents", "$KiroHome\prompts")) {
    if (-not (Test-Path $dir)) {
        New-Item -ItemType Directory -Path $dir | Out-Null
    }
}

# Try symlink, fall back to copy
function Deploy-Files($src, $dstDir) {
    Get-ChildItem $src -File | ForEach-Object {
        $dst = Join-Path $dstDir $_.Name
        Copy-Item $_.FullName $dst -Force
        Write-Host "  $($_.Name) -> $dst"
    }
}

Write-Host "Deploying Bob to $KiroHome ..."
Write-Host ""
Write-Host "agents/"
Deploy-Files (Join-Path $RepoRoot "agents") (Join-Path $KiroHome "agents")
Write-Host ""
Write-Host "prompts/"
Deploy-Files (Join-Path $RepoRoot "prompts") (Join-Path $KiroHome "prompts")

Write-Host ""
Write-Host "Done. Bob is available globally via: /agent bob"
Write-Host "To update: git pull, then run this script again."
