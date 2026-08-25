# Daily note calendar+tasks sync (Windows entry point, used by Task Scheduler).
# 1) Write today's note: calendar events + Google Tasks into # Todo Day Planner,
#    creating the note from the template if missing.
# 2) Commit + push immediately so other devices never see a stale divergence.
$ErrorActionPreference = "Continue"

$vault = if ($env:VAULT_DIR) { $env:VAULT_DIR } else { "$env:USERPROFILE\notes" }

python "$vault\Resources\scripts\calendar_to_daily.py"

Set-Location $vault
git add "Daily Log/" 2>$null
git commit -m "daily note sync (auto)" 2>$null   # no-op if nothing staged
git pull --rebase --autostash 2>$null
git push 2>$null
