# Windows dependency installer (winget). Run once after unboxing.
# Usage: powershell -ExecutionPolicy Bypass -File install.ps1
# Optional: $env:VAULT_URL = "git@github.com:<you>/notes.git" before running
# to auto-clone the vault.

$ErrorActionPreference = "Continue"

Write-Host "==> [1/6] winget present?"
if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {
    Write-Host "winget missing - install App Installer from the Store first." -ForegroundColor Red
    exit 1
}

Write-Host "==> [2/6] Core tools"
$packages = @(
    "Git.Git",
    "GitHub.cli",
    "GoLang.Go",
    "OpenJS.NodeJS.LTS",
    "Python.Python.3.12",
    "Neovim.Neovim",
    "BurntSushi.ripgrep.MSVC",
    "junegunn.fzf",
    "jqlang.jq",
    "sharkdp.bat",
    "eza-community.eza",
    "ajeetdsouza.zoxide",
    "JesseDuffield.lazygit",
    "mikefarah.yq",
    "tldr-pages.tlrc",
    "charmbracelet.glow"
)
foreach ($p in $packages) {
    Write-Host "  -> $p"
    winget install --id $p --accept-source-agreements --accept-package-agreements --silent
}

Write-Host "==> [3/6] Apps"
$apps = @(
    "Microsoft.PowerShell",
    "Microsoft.WindowsTerminal",
    "Vivaldi.Vivaldi",
    "Obsidian.Obsidian",
    "WezTerm.WezTerm",
    "Microsoft.VisualStudioCode",
    "JanDeDobbeleer.OhMyPosh"
)
foreach ($a in $apps) {
    Write-Host "  -> $a"
    winget install --id $a --accept-source-agreements --accept-package-agreements --silent
}

Write-Host "==> [4/6] PowerShell modules (posh-git, Terminal-Icons)"
Set-PSRepository -Name PSGallery -InstallationPolicy Trusted -ErrorAction SilentlyContinue
Install-Module posh-git -Scope CurrentUser -Force -ErrorAction SilentlyContinue
Install-Module Terminal-Icons -Scope CurrentUser -Force -ErrorAction SilentlyContinue

Write-Host "==> [5/6] JetBrains Mono Nerd Font (for prompt icons)"
$fontDir = "$env:LOCALAPPDATA\Microsoft\Windows\Fonts"
New-Item -ItemType Directory -Force -Path $fontDir | Out-Null
$zip = "$env:TEMP\jbmono-nerd.zip"
Invoke-WebRequest -Uri "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip" -OutFile $zip
Expand-Archive -Path $zip -DestinationPath "$env:TEMP\jbmono-nerd" -Force
Get-ChildItem "$env:TEMP\jbmono-nerd\*.ttf" | ForEach-Object {
    Copy-Item $_.FullName $fontDir -Force
    # register for the current user
    $reg = "HKCU:\Software\Microsoft\Windows NT\CurrentVersion\Fonts"
    New-ItemProperty -Path $reg -Name "$($_.BaseName) (TrueType)" -Value $_.Name -PropertyType String -Force | Out-Null
}
Remove-Item $zip, "$env:TEMP\jbmono-nerd" -Recurse -Force -ErrorAction SilentlyContinue

Write-Host "==> [6/6] Notes vault"
$vault = "$env:USERPROFILE\notes"
if (Test-Path "$vault\.git") {
    Write-Host "  already cloned at $vault"
} elseif ($env:VAULT_URL) {
    git clone $env:VAULT_URL $vault
} else {
    Write-Host "  no VAULT_URL set - clone manually: git clone git@github.com:<you>/notes.git $vault"
}

Write-Host ""
Write-Host "Done. Next: cd $vault\onboarding\windows; .\copy-config.ps1"
Write-Host "Then open PowerShell 7 (pwsh) - the p10k-style prompt needs a fresh window."
