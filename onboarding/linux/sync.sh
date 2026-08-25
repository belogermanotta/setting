#!/bin/bash
# Daily note calendar+tasks sync (Linux entry point, used by the systemd timer).
# 1) Write today's note: calendar events + Google Tasks into # Todo Day Planner,
#    creating the note from the template if missing.
# 2) Commit + push immediately so other devices never see a stale divergence.
set -u

VAULT_DIR="${VAULT_DIR:-$HOME/notes}"

python3 "$VAULT_DIR/Resources/scripts/calendar_to_daily.py"
PY_EXIT=$?

cd "$VAULT_DIR" || exit $PY_EXIT
git add "Daily Log/" 2>/dev/null
git commit -q -m "daily note sync (auto)" 2>/dev/null   # no-op if nothing staged
git pull --rebase --autostash -q 2>/dev/null
git push -q 2>/dev/null
exit $PY_EXIT
