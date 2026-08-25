# Windows onboarding playbook

What to do the day a new Windows laptop arrives. Run top to bottom. Reusable —
no company names, no job specifics.

```
onboarding/windows/
├── README.md                  ← you are here
├── install.ps1                ← [3] winget: everything (terminal, tools, apps)
├── copy-config.ps1            ← [4] backs up + applies dotfiles & Obsidian settings
├── sync.ps1                   ← daily note sync (script + git commit/push)
└── config/                    ← settings copy-config.ps1 applies
    ├── Microsoft.PowerShell_profile.ps1  (oh-my-posh p10k theme, zoxide, aliases)
    ├── gitconfig
    ├── editorconfig
    ├── wezterm.lua
    └── nvim-init.lua
```

Shared with all platforms: `../../obsidian/` (sanitized Obsidian settings) and
`Resources/scripts/` in the vault (the calendar sync script).

---

## 0. Before you start (from your home machine)

1. **GitHub access** — your SSH public key added to GitHub
   (`github.com/settings/ssh/new`).
2. **The two secret files** — `token.json` + `client_secret.json` from
   `Resources/scripts/` on your home machine (gitignored, don't ride the repo).
   USB / private cloud — **never** company email.
3. **Vault clone URL** — `git@github.com:<you>/notes.git`.

## 1. Corporate enrollment (do FIRST)

- Join the company **MDM** (Intune/management profile) and endpoint protection
  before touching anything personal.
- Sign into the **work email** in whatever client it configures.
- Keep work and personal accounts/browsers separate from day one.

## 2. System settings (10 min)

- Sign in with your personal Microsoft account; enable **BitLocker** (Settings
  → Privacy & security → Device encryption).
- Windows Update until current.
- Settings → Personalization → Terminal default app: **Windows Terminal**.

## 3. Install everything — `install.ps1`

```powershell
cd <vault>\onboarding\windows
powershell -ExecutionPolicy Bypass -File install.ps1
```

Installs via **winget**: Git, GitHub CLI, Go, Node LTS, Python 3.12, Neovim,
ripgrep, fzf, jq, bat, eza, zoxide, lazygit, yq, tlrc, glow, **PowerShell 7**,
**Windows Terminal**, **Vivaldi, Obsidian, WezTerm, VS Code**, oh-my-posh,
posh-git, Terminal-Icons, and the **JetBrains Mono Nerd Font** (needed for
prompt icons). Clones the vault to `C:\Users\<you>\notes`.

> Run everything from **PowerShell 7** (`pwsh`) after this — it's the shell
> the config targets.

## 4. Apply your configs — `copy-config.ps1`

```powershell
cd $env:USERPROFILE\notes\onboarding\windows
.\copy-config.ps1          # --Force to overwrite existing
```

- **Backs up** your PowerShell profile, `.gitconfig`, `.editorconfig`,
  `wezterm.lua`, `init.lua`, and the vault's `.obsidian/` into
  `~\.config-backup-<ts>\`
- **Applies** the kit's settings (missing files only; `--Force` overwrites),
  including the sanitized Obsidian snapshot from `../../obsidian/` (configs +
  themes only — plugin binaries come from the vault clone).
- Sets up **oh-my-posh** with the Powerlevel10k *rainbow* theme and
  **zoxide** (`z`) — the PowerShell equivalent of the p10k setup
- Then set your identity:
  ```powershell
  git config --global user.name "Your Name"
  git config --global user.email "you@example.com"
  ```

> Open a **new** PowerShell window — the prompt should render with icons.
> If you see boxes instead of icons, the Nerd Font isn't selected in
> Windows Terminal (Settings → Profile → Appearance → Font face →
> "JetBrainsMono Nerd Font").

## 5. Notes vault + calendar sync

```powershell
# 5a. Drop the two secret files in (from step 0):
Copy-Item <transferred>\token.json $env:USERPROFILE\notes\Resources\scripts\
Copy-Item <transferred>\client_secret.json $env:USERPROFILE\notes\Resources\scripts\

# 5b. Test — no browser prompt, the saved token just works:
cd $env:USERPROFILE\notes\Resources\scripts
py calendar_to_daily.py --dry-run
py calendar_to_daily.py
```

### 5c. Schedule it — Task Scheduler (daily 00:00)

```powershell
schtasks /Create /TN "daily-note-calendar-sync" /SC DAILY /ST 00:00 /F `
  /TR "powershell -NoProfile -ExecutionPolicy Bypass -File `"$env:USERPROFILE\notes\onboarding\windows\sync.ps1`""
```

Each run: writes today's note (creating it from the template if missing),
then commits + pushes so other devices never see a stale repo.

To remove later: `schtasks /Delete /TN "daily-note-calendar-sync" /F`

## 6. AI agent (optional)

Same as the macOS kit — see `../macos/AI-AGENT.md`. Corporate policy first:
if IT bans external AI tools, skip it.

## 7. Daily workflow

1. Open Obsidian → today's note already exists with calendar events + tasks
   under `# Todo Day Planner`
2. Tick tasks off — they sync via the vault repo
3. Add events/tasks anywhere → the 00:00 run (or `py calendar_to_daily.py`)
   folds them in

## Corporate caveats

- **winget blocked / proxy kills Google APIs** → stop; iCal fallback exists.
- **Work calendar** → keep in the company calendar app; work events don't
  belong in the personal notes repo (data-handling risk). Free/busy-only sync
  is the safe middle ground if ever needed.

## Troubleshooting

| Symptom | Fix |
|---|---|
| `pwsh` not recognized | re-run `install.ps1` (installs PowerShell 7), or open it from Start menu |
| Prompt has no icons / boxes | Windows Terminal → Settings → Font face → JetBrainsMono Nerd Font |
| Script says `Missing Google libraries` | `py -m pip install --user google-api-python-client google-auth-oauthlib` |
| `py` not recognized | Python 3.12 install → enable "py launcher" (re-run installer if needed) |
| Task didn't run | `schtasks /Query /TN "daily-note-calendar-sync" /V`; check the script path is escaped properly |
| Git push rejected | `git pull --rebase --autostash` then push (phone may have pushed) |
