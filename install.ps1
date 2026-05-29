# install.ps1 — Symlink Bob agents into ~/.kiro/ (user-scoped, all projects)
# Run from the repo root: .\install.ps1
# Requires: elevated PowerShell (symlinks need admin on some Windows configs)

$ErrorActionPreference = "Stop"
$RepoRoot = $PSScriptRoot
$KiroHome = Join-Path $env:USERPROFILE ".kiro"

# Ensure ~/.kiro/ exists
if (-not (Test-Path $KiroHome)) {
    New-Item -ItemType Directory -Path $KiroHome | Out-Null
    Write-Host "Created $KiroHome"
}

# Symlink agents/
$agentsSrc = Join-Path $RepoRoot "agents"
$agentsDst = Join-Path $KiroHome "agents"
if (Test-Path $agentsDst) {
    $existing = Get-Item $agentsDst
    if ($existing.Attributes -band [IO.FileAttributes]::ReparsePoint) {
        Remove-Item $agentsDst
        Write-Host "Removed existing symlink: $agentsDst"
    } else {
        Write-Host "ERROR: $agentsDst exists and is not a symlink. Back it up and remove it first."
        exit 1
    }
}
New-Item -ItemType SymbolicLink -Path $agentsDst -Target $agentsSrc | Out-Null
Write-Host "Linked: $agentsDst -> $agentsSrc"

# Symlink prompts/
$promptsSrc = Join-Path $RepoRoot "prompts"
$promptsDst = Join-Path $KiroHome "prompts"
if (Test-Path $promptsDst) {
    $existing = Get-Item $promptsDst
    if ($existing.Attributes -band [IO.FileAttributes]::ReparsePoint) {
        Remove-Item $promptsDst
        Write-Host "Removed existing symlink: $promptsDst"
    } else {
        Write-Host "ERROR: $promptsDst exists and is not a symlink. Back it up and remove it first."
        exit 1
    }
}
New-Item -ItemType SymbolicLink -Path $promptsDst -Target $promptsSrc | Out-Null
Write-Host "Linked: $promptsDst -> $promptsSrc"

Write-Host ""
Write-Host "Done. Bob is available globally via: /agent bob"
Write-Host "Update by pulling this repo. Changes propagate via symlinks."
