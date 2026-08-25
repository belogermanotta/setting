# PowerShell 7 profile (onboarding default)
# oh-my-posh with the Powerlevel10k rainbow theme + zoxide + terminal icons

# --- oh-my-posh (p10k-style prompt) ---
if (Get-Command oh-my-posh -ErrorAction SilentlyContinue) {
    oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\powerlevel10k_rainbow.omp.json" | Invoke-Expression
}

# --- posh-git (git status in the prompt) ---
Import-Module posh-git -ErrorAction SilentlyContinue

# --- Terminal icons ---
Import-Module Terminal-Icons -ErrorAction SilentlyContinue

# --- zoxide (smart cd: z proj, zi = interactive) ---
if (Get-Command zoxide -ErrorAction SilentlyContinue) {
    Invoke-Expression (& { (zoxide init powershell | Out-String) })
}

# --- PSReadLine: history suggestions like zsh-autosuggestions ---
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadLineOption -EditMode Windows

# --- Aliases ---
Set-Alias v nvim
Set-Alias lg lazygit
function ll { eza -la --icons @args }
function ls2 { eza --icons @args }
Set-Alias gs "git status -sb"
function gp { git pull --rebase --autostash @args }
function gcm { git commit -m @args }
