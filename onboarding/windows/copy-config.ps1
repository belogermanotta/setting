# Backs up existing configs, then applies the onboarding settings.
# Idempotent: existing files are never overwritten unless --Force.
# Usage: .\copy-config.ps1 [--Force]
param([switch]$Force)

$ErrorActionPreference = "Continue"
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$configSrc = Join-Path $scriptDir "config"
$vault = if ($env:VAULT_DIR) { $env:VAULT_DIR } else { "$env:USERPROFILE\notes" }
$backupDir = Join-Path $env:USERPROFILE (".config-backup-" + (Get-Date -Format "yyyyMMdd-HHmmss"))
New-Item -ItemType Directory -Force -Path $backupDir | Out-Null

function Apply-File([string]$srcRel, [string]$dstAbs) {
    $src = Join-Path $configSrc $srcRel
    if (-not (Test-Path $src)) { Write-Host "  (skip) $dstAbs - no source in config/"; return }
    $dstDir = Split-Path -Parent $dstAbs
    if (Test-Path $dstAbs) {
        Copy-Item $dstAbs (Join-Path $backupDir (Split-Path -Leaf $dstAbs)) -Force -ErrorAction SilentlyContinue
        Write-Host "  backup: $dstAbs"
        if (-not $Force) { Write-Host "  (keep)  $dstAbs exists - use --Force to overwrite"; return }
    }
    New-Item -ItemType Directory -Force -Path $dstDir | Out-Null
    Copy-Item $src $dstAbs -Force
    Write-Host "  apply:  $dstAbs"
}

Write-Host "==> Backing up existing configs to $backupDir"

$profileFile = if ($PROFILE) { $PROFILE } else { "$env:USERPROFILE\Documents\PowerShell\Microsoft.PowerShell_profile.ps1" }
Apply-File "Microsoft.PowerShell_profile.ps1" $profileFile
Apply-File "gitconfig" "$env:USERPROFILE\.gitconfig"
Apply-File "editorconfig" "$env:USERPROFILE\.editorconfig"
Apply-File "wezterm.lua" "$env:USERPROFILE\.config\wezterm\wezterm.lua"
Apply-File "nvim-init.lua" "$env:APPDATA\nvim\init.lua"

Write-Host "==> Obsidian settings -> $vault\.obsidian"
$obsSrc = Join-Path $scriptDir "..\..\obsidian"
if (Test-Path $obsSrc) {
    if (Test-Path "$vault\.obsidian") {
        Copy-Item "$vault\.obsidian" (Join-Path $backupDir "obsidian") -Recurse -Force -ErrorAction SilentlyContinue
        Write-Host "  backup: .obsidian"
    }
    New-Item -ItemType Directory -Force -Path "$vault\.obsidian" | Out-Null
    if ($Force) {
        Copy-Item "$obsSrc\*" "$vault\.obsidian\" -Recurse -Force
        Write-Host "  apply:  .obsidian (overwrite)"
    } else {
        # robocopy /XC /XN /XO = skip existing (changed/newer/older) -> missing only
        robocopy "$obsSrc" "$vault\.obsidian" /E /XC /XN /XO /NFL /NDL /NJH /NJS | Out-Null
        Write-Host "  apply:  .obsidian (missing files only)"
    }
} else {
    Write-Host "  (skip) obsidian/ not found at $obsSrc"
}

Write-Host ""
Write-Host "Done. Backups (if any) in $backupDir"
Write-Host "Next: git config --global user.name / user.email"
